package contable.nomina

class Relacion {

    String descripcion
    String codigo
    static auditable = [ignore: []]
    static mapping = {
        table 'RELACION'
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
