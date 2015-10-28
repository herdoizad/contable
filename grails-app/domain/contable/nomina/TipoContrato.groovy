package contable.nomina

class TipoContrato {


    String descripcion
    String codigo
    String procedimiento


    static mapping = {
        table 'TIPO_CONTRATO'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: "increment"
        version false
        columns {
            id column:'ID'
            codigo column: 'CODIGO'
            descripcion column: 'DESCRIPCION'
            procedimiento column: 'NOMBRE_PROCEDIMIENTO'
        }
    }

    static constraints = {
        codigo(size: 1..4)
        descripcion(size: 1..100)
        procedimiento(nullable: true,blank: true, size: 1..100)
    }

    String toString(){
        return this.descripcion
    }
}
