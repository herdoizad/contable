package contable.nomina

class Mes {

    Integer codigo
    Integer diasLaborables = 30
    String descripcion

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'MES'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            codigo column: 'CODIGO'
            diasLaborables column: 'DIAS_LABORABLES'
            descripcion column: 'DESCRIPCION'
        }
    }

    static constraints = {
        descripcion(size: 1..40)
    }
}
