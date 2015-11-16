package contable

import contable.nomina.DetalleRol
import contable.nomina.Empleado
import contable.nomina.ImpuestoRenta
import contable.nomina.MesNomina
import contable.nomina.Rol
import contable.nomina.Sueldo
import contable.nomina.Variable
import grails.transaction.Transactional
import groovy.sql.Sql

@Transactional
class RolDePagosService {

    def dataSource

    def calculaRol(Rol rol){
        def detalles = DetalleRol.findAllByRolAndSigno(rol,1)
        def totalIngresos = 0
        def sueldo = Sueldo.findAllByEmpleado(rol.empleado,[sort:"inicio",order:"desc"])
        if(sueldo.size()>0)
            sueldo=sueldo.first().sueldo
        def q1 = DetalleRol.findByRolAndCodigo(rol,"Q1")
        def q2 = DetalleRol.findByRolAndCodigo(rol,"Q2")

        if(q2 && q1){
            q2.valor=(sueldo-q1?.valor).toDouble().round(2)
            q2.save(flush: true)
        }
        detalles.each {d->
            if(d.codigo!="FDRE" && d.codigo!="S13"  && d.codigo!="S14"){
                totalIngresos+=d.valor
                if(d.codigo=="Q1")
                    q1=d.valor
                if(d.codigo=="Q2")
                    q2=d.valor
            }
        }

//        println "total ingresos "+totalIngresos
        def d13 = DetalleRol.findByRolAndCodigo(rol,"S13")
        if(d13){
            d13.valor=(totalIngresos/12).toDouble().round(2)
            d13.save(flush: true)
        }
        def fondosDeReserva = DetalleRol.findByRolAndCodigo(rol,"FDRE")
        if(fondosDeReserva){
            fondosDeReserva.valor=(totalIngresos/12).toDouble().round(2)
            fondosDeReserva.save(flush: true)
        }
        def aporteIess = DetalleRol.findByRolAndCodigo(rol,"IESS")
        def porcentaje = Variable.findByCodigo("@AIess")
        if(aporteIess){
            aporteIess.valor=(totalIngresos*porcentaje.valor/100).toDouble().round(2)
            aporteIess.save(flush: true)
        }
        def dRenta = DetalleRol.findByRolAndCodigo(rol,"IRNTA")
        if(dRenta){
            def variables = Variable.list()
            def inicio = new Date().parse("yyyyMMdd",""+dRenta.rol.mes.codigo+"01")
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
            cal.set(Calendar.YEAR, inicio.format("yyyy").toInteger());
            cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
            cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
            def fin  = cal.getTime();
            def v = procesaFormula_ajax(dRenta.rubro.formula,dRenta.rol.empleado,dRenta.rol.mes,inicio,fin,variables,[:])
            def renta = ImpuestoRenta.findAll("from ImpuestoRenta where anio=${fin.format('yyyy')} and desde<= ${v} and hasta>=${v} order by desde")
            if(renta.size()==0)
                renta = ImpuestoRenta.findAll("from ImpuestoRenta where anio=${fin.format('yyyy').toInteger()-1} and desde<= ${v} and hasta>=${v} order by desde")
            if(renta.size()>0) {
                renta = renta.pop()
                def pagar = renta.base + ((v - renta.desde) * renta.impuesto / 100)
                println "renta a pagar " + pagar
                dRenta.valor=(pagar/12).toDouble().round(2)
                dRenta.save(flush: true)
            }
        }

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
}
