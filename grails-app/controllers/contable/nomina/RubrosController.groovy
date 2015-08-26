package contable.nomina

import contable.core.Mes
import contable.seguridad.Shield
import groovy.sql.Sql

class RubrosController extends Shield {
    def dataSource
    def nuevoRubro(){
        def rubro = null
        if(params.id)
            rubro=Rubro.get(params.id)
        [rubro:rubro]
    }

    def rubros(){
        def rubros = getList(params, false)
        def count = getList(params, true).size()
        return [rubros: rubros, count: count]
    }

    def getEmpleados_ajax(){
        def emps = Empleado.list()
        def meses = MesNomina.findAllByCodigoGreaterThan(new Date().format("yyyy").toInteger())
        [emps:emps,meses:meses]
    }


    def test_ajax(){
        println "params "+params
        def variables = Variable.list()
        def empleado = Empleado.get(params.empleado)
        def formula = params.formula
        def mes = MesNomina.get(params.mes)
        variables.each {v->
            if(formula=~v.codigo){
                def r = ejecutar_ajax(v,empleado,mes)
                formula=formula.replaceAll(v.codigo,""+r)
            }
        }

        try{
            println "formula  "+formula
            def res = Eval.me(formula)
            render res
        }catch (e){
            println "error test "+e
            response.sendError(500)
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

    def save_ajax(){
        def rubro = new Rubro()
        if(params.id)
            rubro=Rubro.get(params.id)
        rubro.properties=params
        if(!rubro.save(flush: true)){
            println "error save rubro "+params
        }
        flash.message="Datos guardados"
        redirect(action: "rubros")
    }

    def addRubroContrato_ajax(){

    }

    def addRubroEmpleado_ajax(){
        def empleado = Empleado.get(params.empleado)
        def rubro = Rubro.get(params.rubro)
        def re = new RubroEmpleado()
        re.empleado=empleado
        re.rubro=rubro
        re.mes=params.mes.toInteger()
        re.descontable=params.descuenta
        if(params.inicio!="")
            re.inicio=new Date().parse("dd-MM-yyyy",params.inicio)
        if(params.fin!="")
            re.fin=new Date().parse("dd-MM-yyyy",params.fin)
        if(!re.save(flush: true))
            println "error save rubro "+re.errors
        redirect(action: 'detalleEmpleado_ajax',id: empleado.id)
    }


    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 20
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Rubro.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("nombre", "%" + params.search + "%")
                    ilike("formula", "%" + params.search + "%")
                }
            }
        } else {
            list = Rubro.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def rubrosEmpleado(){
        def empleado = null
        if(params.id)
            empleado=Empleado.get(params.id)
        def rubros = Rubro.list([sort: "nombre"])
        def empleados = Empleado.list([sort: "apellido"])
        [empleado:empleado,rubros:rubros,empleados:empleados]
    }
    
    def detalleEmpleado_ajax(){
        def empleado = Empleado.get(params.id)
        def rubros = RubroEmpleado.findAllByEmpleado(empleado)
        def meses = ["0":"Todos","1":"Enero","2":"Febero","3":"Marzo","4":"Abril","5":"Mayo","6":"Junio","7":"Juilo","8":"Agosto","9":"Septiembre","10":"Octubre","11":"Noviembre","12":"Diciembre"]
        [empleado:empleado,rubros: rubros,meses:meses]
    }

    def borrarRubroEmpleado_ajax(){
        def re = RubroEmpleado.get(params.id)
        def empleado = re.empleado
        re.delete(flush: true)
        redirect(action: 'detalleEmpleado_ajax',id: empleado.id)
    }
}
