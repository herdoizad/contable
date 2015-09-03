package contable.nomina

import contable.seguridad.Shield
import groovy.sql.Sql
class RolController extends Shield {

    def dataSource
    def mailService
    def index() {
        def meses = MesNomina.findAllByCodigoLessThanEquals((new Date().format("yyyy")+"13").toInteger(),[sort:"codigo"])
        def empleados = Empleado.findAllByEstado("A",[sort: 'apellido'])

        [meses:meses,empleados:empleados,emp:params.empleado]

    }

    def getRolMes_ajax(){
        def mes = MesNomina.get(params.id)
        def roles = []
        def tipos = ["1":"Ingreso","-1":"Egreso"]
        if(params.empleado=="0"){
            roles = Rol.findAllByMes(mes)
        }else{
            def rol = Rol.findByMesAndEmpleado(mes,Empleado.get(params.empleado))
            if(rol)
                roles.add(rol)
        }
        def max = Empleado.countByEstado("A")
        roles = roles.sort{it.empleado.apellido}
        [roles:roles,emp:params.empleado,mes:mes,tipos:tipos,max:max]
    }


    def addRubro_ajax(){
        def rol = Rol.get(params.id)
        def dt= new DetalleRol()
        dt.valor=params.valor.toDouble()
        dt.descripcion=params.desc
        dt.usuario=session.usuario.login
        dt.signo=params.tipo.toInteger()
        dt.rol=rol
        if(!dt.save(flush: true))
            println "dt error save "+dt.errors
        rol.calculaTotal()
        redirect(action: "getRolMes_ajax",params: [id:rol.mes.id,empleado: rol.empleado.id])

    }


    def generarRol_ajax(){
        println "params generar "+params
        def empleados = []
        def variables = Variable.list()
        if(params.empleado=="0")
            empleados=Empleado.findAllByEstado("A")
        else
            empleados.add(Empleado.get(params.empleado))
        def mes = MesNomina.get(params.mes)
        def inicio = new Date().parse("yyyyMMdd",""+mes.codigo+"01")
        def mesNum = inicio.format("MM").toInteger()
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, inicio.format("yyyy").toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
        def fin  = cal.getTime();
        def resultados=[:]

        println "inicio "+inicio+"  fin "+fin
        empleados.each {e->
            println "empleado "+e
            def rol = Rol.findByMesAndEmpleado(mes,e)
            if(!rol){
                rol = new Rol()
                rol.empleado=e
                rol.mes=mes
                rol.estado="N"
                rol.usuario=session.usuario.login
                def totalIngresos = 0
                def totalEgresos = 0
                if(!rol.save(flush: true))
                    println "error save rol "+rol.errors
                else{
                    def rubros = RubroEmpleado.withCriteria {
                        eq("empleado",e)
                        le("inicio",inicio)
                        or{
                            ge("fin",fin)
                            isNull("fin")
                        }
                    }

                    rubros.each {r->
                        println "rubro! "+r.rubro.nombre
                        if(r.rubro.codigo!="IRNTA"){
                            if(r.mes==0 || r.mes==mesNum){
                                def dt = new DetalleRol()
                                dt.rol=rol
                                dt.usuario=session.usuario.login
                                dt.descripcion=r.rubro.nombre
                                dt.rubro=r.rubro
                                dt.codigo=r.rubro.codigo
                                if(r.rubro.valor>0)
                                    dt.valor=r.rubro.valor
                                else
                                    dt.valor = procesaFormula_ajax(r.rubro.formula,e,mes,inicio,fin,variables,resultados)
                                dt.valor=dt.valor.round(2)
                                dt.signo=r.rubro.signo
                                if(dt.signo>0)
                                    totalIngresos+=dt.valor
                                else
                                    totalEgresos+=dt.valor
                                if(!dt.save(flush: true))
                                    println "error save dt "+dt.errors
                            }

                        }else{
                            /*Impuesto a la renta*/
                            def v = procesaFormula_ajax(r.rubro.formula,e,mes,inicio,fin,variables,resultados)
                            def renta = ImpuestoRenta.findAll("from ImpuestoRenta where anio=${fin.format('yyyy')} and desde>= ${v} and hasta<=${v} order by desde")
                            if(renta.size()==0)
                                renta = ImpuestoRenta.findAll("from ImpuestoRenta where anio=${fin.format('yyyy').toInteger()-1} and desde>= ${v} and hasta<=${v} order by desde")
                            println "renta ${e.cedula} "+renta
                            if(renta.size()>0){
                                renta=renta.pop()
                                def pagar = renta.base+((v-renta.desde)*renta.impuesto/100)
                                println "renta a pagar "+pagar
                                def dt = new DetalleRol()
                                dt.rol=rol
                                dt.usuario=session.usuario.login
                                dt.descripcion=r.rubro.nombre
                                dt.rubro=r.rubro
                                dt.codigo=r.rubro.codigo
                                dt.valor=pagar
                                dt.valor=dt.valor.round(2)
                                dt.signo=-1
                                totalEgresos+=dt.valor
                                if(!dt.save(flush: true))
                                    println "error save dt "+dt.errors
                            }
                            /*Fin impuesto a la renta*/

                        }

                    }
                    def prestamo = Prestamo.withCriteria {
                        eq("empleado",e)
                        le("inicio",inicio)
                        ge("fin",fin)
                    }
                    println "prestamo "+prestamo
                    if(prestamo.size()>0){
                        prestamo=prestamo.pop()
                        def dt = new DetalleRol()
                        dt.rol=rol
                        dt.usuario=session.usuario.login
                        dt.descripcion="Prestamo (${prestamo.monto})"
                        dt.valor=prestamo.valorCuota.round(2)
                        dt.signo=-1
                        totalEgresos+=dt.valor
                        if(!dt.save(flush: true))
                            println "error save dt "+dt.errors
                    }




                    rol.totalEgresos=totalEgresos
                    rol.totalIngresos=totalIngresos
                    rol.save(flush: true)

                }
            }
        }

        redirect(action: 'getRolMes_ajax',params: ["id":params.mes,"empleado":params.empleado])
    }


    def updateRubro_ajax(){
        def dt = DetalleRol.get(params.id)
        dt.descripcion=params.desc
        dt.valor=params.valor.toDouble().round(2)
        dt.modificacion=new Date()
        dt.save(flush: true)
        dt.rol.calculaTotal()
        render "ok"
    }

    def deleteRubro_ajax(){
        def dt = DetalleRol.get(params.id)
        def rol = dt.rol
        dt.delete(flush: true)
        rol.calculaTotal()
        render "ok"
    }


    def procesaFormula_ajax(formula,empleado,mes,inicio,fin,variables,resultados){

        variables.each {v->
            if(formula=~v.codigo){
                if(!resultados[v.codigo]){
                    def r = ejecutar_ajax(v,empleado,mes,inicio,fin)
                    formula=formula.replaceAll(v.codigo,""+r)
                    if(!v.sql)
                        resultados.put(v.codigo,r)
                    else{
                        if(!v.sql.contains("@empleado"))
                            resultados.put(v.codigo,r)
                    }
                }else{
                    formula=formula.replaceAll(v.codigo,""+resultados[v.codigo])
                }
            }
        }

        try{
            println "formula  "+formula
            def res = Eval.me(formula)
            return res
        }catch (e){
            return  0
        }
    }

    def ejecutar_ajax(Variable varaible,Empleado empleado,MesNomina mes,inicio,fin){
        def sql = varaible.sql
        def res = 0
        if(!sql)
            return varaible.valor
        sql = sql.replaceAll("@empleado",""+empleado.id)
        sql = sql.replaceAll("@mes",""+mes.id)
        sql = sql.replaceAll("@fecha",""+fin.format("MM-dd-yyyy"))
        def cn = new Sql(dataSource)
        println "sql variable "+sql

        cn.eachRow(sql){r->
//            println "r "+r
            res=r[0]
        }
        return res
    }

    def aprobarRoles_ajax(){
        println "params "+params
        def mes = MesNomina.get(params.mes)
        def empleados = []
        if(params.empleado=="0")
            empleados=Empleado.list()
        else
            empleados.add(Empleado.get(params.empleado))
        println "empleados "+empleados.id
        Rol.findAllByMesAndEmpleadoInList(mes,empleados).each {r->
            println "r "+r.id+" "+r.estado
            if(r.estado=="N"){
                r.estado="A"
                if(!r.save(flush: true))
                    println "error save rol aprobar "+r.errors
            }
        }
        redirect(action: 'getRolMes_ajax',params: ["id":params.mes,"empleado":params.empleado])
    }


    def enviarEmails_ajax(){

        def mes = MesNomina.get(params.mes)
        def empleados = []
        if(params.empleado=="0")
            empleados=Empleado.list()
        else
            empleados.add(Empleado.get(params.empleado))

        Rol.findAllByMesAndEmpleadoInList(mes,empleados).each { r ->
            def detalle = DetalleRol.findAllByRol(r,[sort:"signo",order:"desc"])
            mailService.sendMail {
                multipart true
                to "valentinsvt@hotmail.com"
//                to r.empleado.email
                subject "Rol de pagos"
                body( view:"mailRol",
                        model:[rol: r,detalle:detalle,usuario:session.usuario.login])
                inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
            }
        }
        render "ok"


    }



//

}
