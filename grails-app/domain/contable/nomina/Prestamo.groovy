package contable.nomina

class Prestamo {

    Empleado empleado
    Double monto
    Integer plazo
    Double interes=0
    Double valorCuota
    Date inicio
    Date fin
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'PRESTAMO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            monto column: 'MONTO'
            plazo column: 'PLAZO'
            interes column: 'INTERES'
            valorCuota column: 'VALOR_CUOTA'
            inicio column: 'FECHA_INICIO'
            fin column: 'FECHA_FIN'
        }
    }

    static constraints = {

    }
}
