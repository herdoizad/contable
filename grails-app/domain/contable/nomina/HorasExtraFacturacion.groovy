package contable.nomina

class HorasExtraFacturacion {

    Empleado empleado
    Double horas1x = 0
    Double horas15x = 0
    Double horas2x = 0

    MesNomina mes

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'HORAS_EXTRA_FACTURACION'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            mes column:'MES'
            horas1x column:'HORAS_1'
            horas15x column:'HORAS_15'
            horas2x column:'HORAS_2'
        }
    }

    static constraints = {

    }
}
