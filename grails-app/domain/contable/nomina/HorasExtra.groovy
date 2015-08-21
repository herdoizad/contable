package contable.nomina

class HorasExtra {

    Empleado empleado
    Double cantidad
    Double factor
    MesNomina mes

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'HORAS_EXTRA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            mes column:'MES'
            cantidad column:'HORAS'
            factor column:'FACTOR'
        }
    }

    static constraints = {

    }
}
