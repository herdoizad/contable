package contable.nomina.reportes

import contable.core.Banco
import contable.core.Cuenta
import contable.core.Mes
import contable.nomina.Empleado
import contable.nomina.MesNomina
import contable.seguridad.Shield

class ReportesNominaController extends Shield {

    def index() {
        def empleados = Empleado.findAllByEstado("A")
        def meses = MesNomina.findAllByCodigoGreaterThan(new Date().format("yyyy").toInteger(),[sort:"codigo"])
        [empleados:empleados,meses:meses]
    }
    def reportes(){
        switch (params.tipo){
            case "d":
                redirect(action: "descuentos",params: params)
                break;
            case "p":
                redirect(action: "provisiones",params: params)
                break;
            case "h":
                redirect(action: "horasExtra",params: params)
                break;
            case "c":
                redirect(action: "cuadre",params: params)
                break;
        }

    }

    def descuentos(){
        println "descuentos "+params
        def mes = MesNomina.get(params.mes)
        def emepleados = []
        if(params.empleado=="-1")
            emepleados=Empleado.findAllByEstado("A")
        else{
            emepleados.add(Empleado.get(params.empleado))
        }
        render "aqui hacer reporte"

    }

    def provisiones(){
        println "provisiones"
        def mes = MesNomina.get(params.mes)
        def emepleados = []
        if(params.empleado=="-1")
            emepleados=Empleado.findAllByEstado("A")
        else{
            emepleados.add(Empleado.get(params.empleado))
        }
        render "aqui hacer reporte"
    }

    def cuadre(){
        println "cuadre"
        def mes = MesNomina.get(params.mes)
        def emepleados = []
        if(params.empleado=="-1")
            emepleados=Empleado.findAllByEstado("A")
        else{
            emepleados.add(Empleado.get(params.empleado))
        }
        render "aqui hacer reporte"
    }

    def horasExtra(){
        println "horasExtra"
        def mes = MesNomina.get(params.mes)
        def emepleados = []
        if(params.empleado=="-1")
            emepleados=Empleado.findAllByEstado("A")
        else{
            emepleados.add(Empleado.get(params.empleado))
        }
        render "aqui hacer reporte"
    }
}

