package contable.nomina

class TipoPrestamo {

    String descripcion
    String codigo
    Integer diasDeGracia
    static mapping = {
        table 'TIPO_PRESTAMO'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: "increment"
        version false
        columns {
            id column:'ID'
            codigo column: 'CODIGO'
            descripcion column: 'DESCRIPCION'
            diasDeGracia column: 'DIAS_DE_GRACIA'
        }
    }

    static constraints = {
        codigo(size: 1..4)
        descripcion(size: 1..100)
        diasDeGracia(nullable: true)
    }

    String toString(){
        return this.descripcion
    }
}
