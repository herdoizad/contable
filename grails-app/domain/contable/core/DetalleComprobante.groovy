package contable.core

class DetalleComprobante implements Serializable{

    Integer mes
    Double numero
    Empresa empresa
    Integer tipo
    Cuenta cuenta
    String descripcion
    Integer signo
    Double valor
    String usuario
    Date  creacion
    Double secuencial
    Integer concilia
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'COMPROBANTE_DETALLE'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['mes','numero','empresa','tipo','secuencial']
        columns {
            mes column: 'MES_CODIGO'
            numero column: 'COM_NUMERO'
            empresa column: 'EMP_CODIGO'
            tipo column: 'COM_TIPO_CODIGO'
            cuenta column: 'CTA_CUENTA' ,sqlType: "varchar", length: 15
            descripcion column: 'COM_DESCRIPCION'
            signo column: 'COM_SIGNO'
            valor column: 'COM_VALOR'
            secuencial column: 'COM_SECUENCIAL'
            concilia column: 'COM_CONCILIA'
            usuario column: 'COM_EMPLEADO_CREA'
            creacion column: 'COM_FECHA_CREA'
        }
    }
    static constraints = {
        descripcion(size: 1..35)
        usuario(size: 1..16)
        concilia(nullable: true,blank:true)

    }
}
