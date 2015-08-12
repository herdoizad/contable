package contable.core

class TipoDocumento {

    Integer codigo
    String descripcion

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'TIPO_DOCUMENTO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"string"
        columns {
            codigo column: 'CODIGO_TIPO'
            descripcion column: 'DESCRIPCION_TIPO'
        }
    }


    static constraints = {

        descripcion(size: 1..40)
    }
}
