package contable.nomina

import contable.seguridad.Shield
import groovy.sql.Sql

class RolController extends Shield {

    def dataSource

    def index() {

        def meses = MesNomina.findAllByCodigoLessThanEquals(new Date().format("yyyyMM").toInteger(),[sort:"codigo"])
        def empleados = Empleado.list([sort: 'nombre'])
        [meses:meses,empleados:empleados]

    }

    def getRolMes_ajax(){
        def mes = MesNomina.get(params.id)
        def roles = []
        if(params.empleado=="0"){
            roles = Rol.findAllByMes(mes)
        }else{
            def rol = Rol.findByMesAndEmpleado(mes,Empleado.get(params.empleado))
            if(rol)
                roles.add(rol)
        }
        [roles:roles,emp:params.empleado,mes:mes]
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
        render "ok"
    }

    def deleteRubro_ajax(){
        def dt = DetalleRol.get(params.id)
        dt.delete(flush: true)
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

}
