package contable.core

class TipoPago implements Serializable{

    String codigo
    String descripcion

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'TIPOS_PAGOS_CARTERA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"string"
        columns {
            codigo column: 'CODIGO_TIPO_PC'
            descripcion column: 'DESCRIPCION_TIPO_PC'
        }
    }


    static constraints = {
        codigo(size: 1..2)
        descripcion(size: 1..50)
    }
}
