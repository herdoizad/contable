package contable.nomina

class Asistencia {

    Empleado empleado
    Mes mes
    Double horas
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'ASISTENCIA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            mes column:'MES'
            horas column:'HORAS'
        }
    }

    static constraints = {

    }
}
