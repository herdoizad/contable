package contable.core.conciliacion

class BancoConciliacion implements Serializable {

    String conciliaBanco
    String codigo
    String descripcion
    String codigoContable
    String codigoContableEx
    String cuenta

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        datasource 'pys'
        table 'TIPO_CONCILIA_BANCO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "conciliaBanco", generator: 'assigned', type:"string"
        columns {
            conciliaBanco column: 'CONCILIA_BANCO'
            codigo column: 'CODIGO_BANCO'
            descripcion column: 'DESCRIPCION_TIPO_CONCILIA'
            codigoContable column: 'CODIGO_CONTABLE'
            codigoContableEx column: 'CODIGO_CONTABLE_EX'
            cuenta column: 'CTA_CUENTA'
        }
    }


    static constraints = {

    }
}
