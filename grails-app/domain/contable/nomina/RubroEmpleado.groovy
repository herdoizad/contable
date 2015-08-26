package contable.nomina

class RubroEmpleado {

    Empleado empleado
    Rubro rubro
    Date inicio
    Date fin
    Integer mes
    String descontable = "S"
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'RUBRO_EMPLEADO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            rubro column: 'RUBRO_ID'
            empleado column: 'EMPLEADO_ID'
            inicio column: 'FECHA_INICIO'
            fin column: 'FECHA_FIN'
            mes column: 'MES'
            descontable column: 'DESCUENTA'
        }
    }

    static constraints = {
        fin(nullable: true)
        descontable(size: 1..1)
    }
}
