package contable.core

class BancoOcp {
    String codigo
    String descripcion
    Date creacion
    String usuario
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'BANCO_OCP'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"string"
        columns {
            codigo column: 'BAN_CODIGO'
            descripcion column: 'BAN_DESCRIPCION'
            creacion column: 'BAN_FECHA_CREA'
            usuario column: 'BAN_EMPLEADO_CREA'

        }
    }
    static constraints = {
        codigo(size: 1..3)
        descripcion(size: 1..60)
        creacion(nullable: true)
        usuario(nullable: true,blank:true,size: 1..20)
    }
}
