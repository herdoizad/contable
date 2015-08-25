package contable.nomina

class Sueldo {
    Empleado empleado
    Double sueldo
    Date inicio
    Date fin
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'SUELDO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column: 'EMPLEADO_ID'
            inicio column: 'INICIO'
            sueldo column: 'SUELDO'
            fin column:'FIN'

        }
    }

    static constraints = {
        fin(nullable: true)
    }
}
