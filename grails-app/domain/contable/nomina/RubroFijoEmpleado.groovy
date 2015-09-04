package contable.nomina

class RubroFijoEmpleado {

    Empleado empleado
    Date inicio
    Date fin
    Double valor
    String descripcion

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'RUBROFIJO_EMPLEADO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            inicio column:'FECHA_INICIO'
            fin column:'FECHA_FIN'
            valor column:'VALOR'
            descripcion column:'DESCRIPCION'
        }
    }

    static constraints = {
        fin(nullable: true)
        descripcion(size:1..150)
    }
    /*todo acabar esto!  copiar de la pantalla rubro empleado... ojala antes de la presentacion */
}
