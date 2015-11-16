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
    Date  creacion
    Double secuencial
    Integer concilia

    String usuario
    String ipMod
    String origen="W"

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

            creacion column: 'COM_FECHA_CREA'
            usuario column: 'USUARIO'
            ipMod column: 'IPCREA'
            origen column: 'ORIGEN'
        }
    }
    static constraints = {
        descripcion(size: 1..35)
        concilia(nullable: true,blank:true)
        usuario(size: 1..32,nullable: true,blank: true)
        ipMod(nullable: true,blank: true,size: 1..24)
        origen(nullable: true,blank: true,size: 1..1)
    }
}
