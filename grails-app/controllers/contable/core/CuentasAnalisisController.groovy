package contable.core

class CuentasAnalisisController {

    def index() {
        def cuentas = Cuenta.list([sort: "numero"])
        def signos = ["+":"+","-":"-"]
        def formulas = Formula.list([sort:"nombre"])
        def formula = null
        if(params.id)
            formula=Formula.get(params.id)
        def det1=null
        def det2=null
        if(formula){
            det1 = DetalleDividendo.findByFormula(formula.id.toInteger())
            det2 = DetalleDivisor.findByFormula(formula.id.toInteger())
        }
//        println "de1 "+det1?.getCampo1Pad()+"! "+det2?.campo1
        [cuentas:cuentas,signos:signos,formulas:formulas,formula:formula,det1:det1,det2:det2]
    }

    def save_ajax(){
        println "params "+params
        def formula=params.formula.toInteger()
        def det1 = DetalleDividendo.findByFormula(formula)
        det1.campo1=params.campo1?.trim()
        det1.campo2=params.campo2?.trim()
        det1.campo3=params.campo3?.trim()
        det1.signo1=params.signo1?.trim()
        det1.signo2=params.signo2?.trim()
        if(!det1.save(flush: true))
            println "error save det1 "+det1.errors

        def det2 = DetalleDivisor.findByFormula(formula)
        det2.campo1=params.campo4?.trim()
        det2.campo2=params.campo5?.trim()
        det2.campo3=params.campo6?.trim()
        det2.signo1=params.signo3?.trim()
        det2.signo2=params.signo4?.trim()
        if(!det2.save(flush: true))
            println "error save det1 "+det2.errors
        render "ok"

    }
}
