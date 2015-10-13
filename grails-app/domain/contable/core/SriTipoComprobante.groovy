package contable.core

class SriTipoComprobante implements Serializable {

    String codigo
    String descripcion
    String usuario
    Date crea
    Integer compras
    Integer importaciones
    Integer ventas
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'SRI_TIPO_COMPROBANTE'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"string"
        columns {
            codigo column: 'COM_CODIGO'
            descripcion column: 'COM_TIPO_COMPROBANTE'
            usuario column: 'COM_EMP_CREA'
            crea column: 'COM_FECHA_CREA'
            compras column: 'COM_COMPRAS'
            importaciones column: 'COM_IMPORTACIONES'
            ventas column: 'COM_VENTA'
        }
    }
    static constraints = {
        codigo(size: 1..2)
        descripcion(size: 1..60)
        usuario(size: 1..16)
        compras(nullable: true)
        importaciones(nullable: true)
        ventas(nullable: true)
    }
}
