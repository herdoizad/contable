package contable.nomina

class MesNomina {

    Integer codigo
    Integer diasLaborables = 30
    String descripcion
    String estado = "A"

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'MESNOMINA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            codigo column: 'CODIGO'
            diasLaborables column: 'DIAS_LABORABLES'
            descripcion column: 'DESCRIPCION'
            estado column: 'ESTADO'
        }
    }

    static constraints = {
        descripcion(size: 1..40)
        estado(nullable: true,size:1..1)
    }
}
