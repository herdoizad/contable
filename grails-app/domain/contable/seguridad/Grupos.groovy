package contable.seguridad

class Grupos {

    String descripcion
    static mapping = {
        datasource 'usuarios'
        table 'GRUPOS'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        sort nombre: "asc"
        columns {
            id column: 'CODIGO_GRUPO'
            descripcion column: 'DESCRIPCION_GRUPO'

        }
    }
    static constraints = {
        descripcion(size: 1..20)
    }
}
