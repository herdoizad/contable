package contable.core

class GrupoEstadoDeResultadosController {

    def index() {


    }


    def addCuenta_ajax(){

    }

    def borrarCuenta_ajax(){

    }


    def save_ajax(){

    }

    def detalle_ajax(){

        def grupo = GrupoResultado.get(params.id)
        def detalle = DetalleResultado.findAllByGrupo(grupo)
        [grupo:grupo,detalle:detalle]

    }
}
