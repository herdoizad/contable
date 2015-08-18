package contable.core

class PrototipoController {

    def index() {

        def cuentas = Cuenta.findAllByAgrupa(1)

        [id:params.id,cuentas:cuentas]

    }


    def getDetalle_ajax(){
        println "params "+params
        def detalle = DetallePrototipo.findAllByCodigoAndEmpresa(params.id.toInteger(),session.empresa)
        [detalle:detalle]

    }

    def addCuenta_ajax(){
        println "params "+params
        def next = DetallePrototipo.findAllByCodigo(params.id.toInteger(),[sort:"secuencial",order:"desc",max:1])
        if(next.size()>0)
            next=next.pop().secuencial+1
        else
            next=1
        println "next "+next
        def det = new DetallePrototipo()
        det.usuario=session.usuario.login
        det.creacion=new Date()
        det.cuenta=Cuenta.findByNumeroAndEmpresa(params.cuenta,session.empresa)
        det.descripcion=params.descripcion
        if(params.signo=="true")
            det.signo=1
        else
            det.signo=-1
        det.valor=params.valor.toDouble()
        det.codigo=params.id.toInteger()
        det.secuencial=next
        det.empresa=session.empresa
        if(!det.save(flush: true))
            println "error det "+det.errors
        redirect(action: "getDetalle_ajax",id: params.id)

    }

    def borraCuenta_ajax(){

        def det = DetallePrototipo.findByCodigoAndSecuencial(params.id.toInteger(),params.secuencial.toInteger())
        det.delete(flush: true)
        redirect(action: "getDetalle_ajax",id: params.id)
    }

    def save_ajax(){
        println "params "+params
        def prot = new Prototipo()
        prot.empresa=session.empresa
        prot.descripcion=params.descripcion
        prot.usuario=session.usuario.login
        prot.creacion=new Date()
        if(!prot.save(flush: true)){
            flash.message="Error al guardar el prototipo"
            println "error prot "+prot.errors
        }
        redirect(action: "index",id: prot.id)


    }
}
