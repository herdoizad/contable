package contable.nomina

class Capacitacion {

    Empleado empleado
    String titulo
    String institucion
    Date inicio
    Date fin
    String path
    TipoCapacitacion tipo
    Integer horas
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'CAPACITACION'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            titulo column:'TITULO'
            institucion column:'INSTITUCION'
            inicio column:'INICIO'
            fin column:'FIN'
            path column:'PATH'
            tipo column:'TIPO'
            horas column: 'HORAS'

        }
    }

    static constraints = {
        titulo(size: 1..150)
        institucion(size: 1..150)
        fin(nullable: true)
        inicio(nullable: true)
        path(nullable: true,size: 1..150)
        horas(nullable: true)
    }
}
