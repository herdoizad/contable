package contable.core

class DetalleResultado implements Serializable {

    GrupoResultado grupo
    Empresa empresa
    Cuenta cuenta
    String descripcion

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'DETALLE_RESULTADO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['grupo','cuenta']
        columns {
            empresa column: 'EMP_CODIGO'
            grupo column: 'SECUENCIAL_GRUPO'
            cuenta column: 'CTA_CUENTA'
            descripcion column: 'CTA_DESCRIPCION'
        }
    }

    static constraints = {
        descripcion(size: 1..60)
    }
}
