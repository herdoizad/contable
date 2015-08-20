package contable.nomina

class TipoCapacitacion {

    String descripcion
    String codigo
    static auditable = [ignore: []]
    static mapping = {
        table 'TIPO_CAPACITACION'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: "increment"
        version false
        columns {
            id column:'ID'
            codigo column: 'CODIGO'
            descripcion column: 'DESCRIPCION'
        }
    }

    static constraints = {
        codigo(size: 1..4)
        descripcion(size: 1..100)
    }

    String toString(){
        return this.descripcion
    }
}
