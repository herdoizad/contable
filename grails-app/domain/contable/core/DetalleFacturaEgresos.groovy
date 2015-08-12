package contable.core

class DetalleFacturaEgresos implements Serializable {

    String numeroFactura
    Integer mes
    Double comprobante
    Empresa empresa
    Integer tipo
    TipoDocumento tipoDocumento
    Double valor
    String tipoRetencion
    Double retencion
    Double pagar
    String tipoIva
    Double valorIva
    String usuario
    Date creacion = new Date()
    Integer retencionIva
    Integer secuencialRetencion = 1
    Date fechaDocumento
    Integer estadoMigra = 0
    String estado = "A"


    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'DETALLE_FACTURA_EGRESOS'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['mes','comprobante','tipo','empresa','secuencialRetencion']
        columns {
            numeroFactura  column: 'NUMERO_FACTURA'
            mes  column: 'MES_CODIGO'
            comprobante column: 'COM_NUMERO'
            empresa column: 'EMP_CODIGO'
            tipo column: 'COM_TIPO_CODIGO'
            usuario column: 'EMPLEADO_CREA'
            creacion column: 'FECHA_CREA'
            tipoDocumento  column: 'CODIGO_TIPO'
            valor  column: 'VALOR_FACTURA'
            tipoRetencion  column: 'TIPO_RETENCION'
            retencion  column: 'RETENCION'
            pagar  column: 'APAGAR'
            tipoIva  column: 'TIPO_IVA'
            valorIva  column: 'VALOR_IVA'
            retencionIva  column: 'RETENCION_IVA'
            secuencialRetencion  column: 'SECUENCIAL_RET'
            fechaDocumento  column: 'FECHA_DOCUMENTO'
            estadoMigra  column: 'ESTADO_MIGRA'
            estado  column: 'ESTADO'
        }
    }

    static constraints = {
        numeroFactura(size: 1..30)
        tipoRetencion(nullable: true)
        retencion(nullable: true)
        pagar(nullable: true)
        tipoIva(nullable: true)
        valorIva(nullable: true)
        usuario(nullable: true,size: 1..16)
        creacion(nullable: true)
        retencionIva(nullable: true)
        fechaDocumento(nullable: true)
        estado(size: 1..1)
    }
}
