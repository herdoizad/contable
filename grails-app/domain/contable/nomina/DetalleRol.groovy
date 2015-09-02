package contable.nomina

class DetalleRol {

    Rol rol
    String descripcion
    Double valor
    Integer signo
    Date registro = new Date()
    String usuario
    Date modificacion
    Rubro rubro
    String codigo
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'DETALLE_ROL'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            rol column:'ROL_ID'
            descripcion column:'DESCRIPCION'
            valor  column:'VALOR'
            signo  column:'SIGNO'
            registro column:'FECHA_REGISTRO'
            usuario column:'USUARIO_CREA'
            modificacion column:'FECHA_MODIFICACION'
            rubro column: 'RUBRO_ID'
            codigo column: 'CODIGO'
        }
    }

    static constraints = {
        descripcion(size: 1..150)
        usuario(size: 1..15)
        codigo(size: 1..5,nullable: true)
        modificacion(nullable: true)
        rubro(nullable: true)

    }
}
