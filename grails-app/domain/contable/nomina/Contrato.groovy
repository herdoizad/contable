package contable.nomina

class Contrato {

    Empleado empleado
    String numero
    Date inicio
    Date fin
    Double sueldo
    TipoContrato tipo
    String path
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'CONTRATO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            numero column: 'NUMERO'
            inicio column: 'INICIO'
            sueldo column: 'SUELDO'
            fin column:'FIN'
            path column:'PATH'
            tipo column:'TIPO_CONTRATO_ID'

        }
    }

    static constraints = {
        numero(size: 1..30)
        fin(nullable: true)
        path(nullable: true,size: 1..150)
    }
}
