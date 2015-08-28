package contable.nomina

import contable.seguridad.Shield
import groovy.sql.Sql
class RolController extends Shield {

    def dataSource
    def mailService
    def index() {

        def meses = MesNomina.findAllByCodigoLessThanEquals((new Date().format("yyyy")+"13").toInteger(),[sort:"codigo"])
        def empleados = Empleado.list([sort: 'nombre'])
        [meses:meses,empleados:empleados]

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
        roles = roles.sort{it.empleado.apellido}
        [roles:roles,emp:params.empleado,mes:mes,tipos:tipos]
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
//        println "params generar "+params
        def empleados = []
        def variables = Variable.list()
        if(params.empleado=="0")
            empleados=Empleado.list()
        else
            empleados.add(Empleado.get(params.empleado))
        def mes = MesNomina.get(params.mes)
        def inicio = new Date().parse("yyyyMMdd",""+mes.codigo+"01")
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, inicio.format("yyyy").toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
        def fin  = cal.getTime();
        def resultados=[:]
        println "inicio "+inicio+"  fin "+fin
        empleados.each {e->
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
                        ge("inicio",inicio)
                        or{
                            le("fin",fin)
                            isNull("fin")
                        }
                    }
                    println "rubros "+rubros
                    rubros.each {r->
                        def dt = new DetalleRol()
                        dt.rol=rol
                        dt.usuario=session.usuario.login
                        dt.descripcion=r.rubro.nombre
                        if(r.rubro.valor>0)
                            dt.valor=r.rubro.valor
                        else
                            dt.valor = procesaFormula_ajax(r.rubro.formula,e,mes,variables,resultados)
                        dt.valor=dt.valor.round(2)
                        dt.signo=r.rubro.signo
                        if(dt.signo>0)
                            totalIngresos+=dt.valor
                        else
                            totalEgresos+=dt.valor
                        if(!dt.save(flush: true))
                            println "error save dt "+dt.errors

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
//                    def horasExtra = HorasExtra.findByEmpleadoAndMes(e)
//                    println "horas extra "+horasExtra
//                    if(horasExtra){
//                        if(horasExtra.horas1x>0){
//                            def dt = new DetalleRol()
//                            dt.rol=rol
//                            dt.usuario=session.usuario.login
//                            dt.descripcion="Horas extra 100%: "
//                            def formula=""
//                            dt.valor=horasExtra.horas1x*(100)
//                            dt.signo=1
//                            totalIngresos+=dt.valor
//                            if(!dt.save(flush: true))
//                                println "error save dt "+dt.errors
//                        }
//                        if(horasExtra.horas15x>0){
//                            def dt = new DetalleRol()
//                            dt.rol=rol
//                            dt.usuario=session.usuario.login
//                            dt.descripcion="Horas extra 150%: "
//                            dt.valor=horasExtra.horas15x*(100)
//                            dt.signo=1
//                            totalIngresos+=dt.valor
//                            if(!dt.save(flush: true))
//                                println "error save dt "+dt.errors
//                        }
//                        if(horasExtra.horas2x>0){
//                            def dt = new DetalleRol()
//                            dt.rol=rol
//                            dt.usuario=session.usuario.login
//                            dt.descripcion="Horas extra 200%: "
//                            dt.valor=horasExtra.horas2x*(100)
//                            dt.signo=1
//                            totalIngresos+=dt.valor
//                            if(!dt.save(flush: true))
//                                println "error save dt "+dt.errors
//                        }
//
//
//                    }
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


    def procesaFormula_ajax(formula,empleado,mes,variables,resultados){

        variables.each {v->
            if(formula=~v.codigo){
                if(!resultados[v.codigo]){
                    def r = ejecutar_ajax(v,empleado,mes)
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

    def ejecutar_ajax(Variable varaible,Empleado empleado,MesNomina mes){
        def sql = varaible.sql
        def res = null
        if(!sql)
            return varaible.valor
        sql = sql.replaceAll("@empleado",""+empleado.id)
        sql = sql.replaceAll("@mes",""+mes.id)
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
