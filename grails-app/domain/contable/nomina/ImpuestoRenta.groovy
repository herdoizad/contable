package contable.nomina

class ImpuestoRenta {

    Double desde
    Double hasta
    Double base
    Double impuesto
    Integer anio

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'IMPUESTO_RENTA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            desde column:'DESDE'
            hasta column:'HASTA'
            base column:'BASE_IMPONIBLE'
            impuesto column:'IMPUESTO'
            anio column:'ANIO'
        }
    }

    static constraints = {

    }
}
