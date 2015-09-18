package contable.nomina

import contable.seguridad.Shield

class HorasExtraController extends Shield{

    def index() {
        def empleados = []
        if(params.empleado=="0")
            empleados=Empleado.findAllByEstado("A",[sort: "apellido"])
        else
        if(params.empleado)
            empleados.add(Empleado.get(params.empleado))
        def meses = MesNomina.findAllByCodigoGreaterThanAndCodigoLessThanEquals(new Date().format("yyyy").toInteger(),new Date().format("yyyyMM").toInteger(),[sort: "codigo"])
        [empleados:empleados,meses:meses,empleado:params.empleado]
    }


    def save_ajax(){
        println "params "+params
        def data = params.data.split("W")
        data.each {d->
            if(d!=""){
                def parts = d.split(";")
                println "parts "+parts
                def emp = Empleado.get(parts[1].toLong())
                def mes = MesNomina.get(parts[0].toLong())
                def h = HorasExtra.findByEmpleadoAndMes(emp,mes)
                if(!h){
                    if(parts[2]+parts[3]+parts[4]!="000"){
                        h=new HorasExtra()
                        h.empleado=emp
                        h.mes=mes
                        h.horas1x=parts[2].toDouble()
                        h.horas15x=parts[3].toDouble()
                        h.horas2x=parts[4].toDouble()
                        if(!h.save(flush: true))
                            println "error save  h "+h.errors
                    }
                }else{
                    h.horas1x=parts[2].toDouble()
                    h.horas15x=parts[3].toDouble()
                    h.horas2x=parts[4].toDouble()
                    if(!h.save(flush: true))
                        println "error save  h "+h.errors
                }

            }

        }
        data = params.dataf.split("W")
        data.each {d->
            if(d!=""){
                def parts = d.split(";")
                println "partsf "+parts
                def emp = Empleado.get(parts[1].toLong())
                def mes = MesNomina.get(parts[0].toLong())
                def h = HorasExtraFacturacion.findByEmpleadoAndMes(emp,mes)
                if(!h){
                    if(parts[2]+parts[3]+parts[4]!="000"){
                        h=new HorasExtraFacturacion()
                        h.empleado=emp
                        h.mes=mes
                        h.horas1x=parts[2].toDouble()
                        h.horas15x=parts[3].toDouble()
                        h.horas2x=parts[4].toDouble()
                        if(!h.save(flush: true))
                            println "error save  h "+h.errors
                    }
                }else{
                    h.horas1x=parts[2].toDouble()
                    h.horas15x=parts[3].toDouble()
                    h.horas2x=parts[4].toDouble()
                    if(!h.save(flush: true))
                        println "error save  h "+h.errors
                }

            }

        }
        render("ok")
    }
}
