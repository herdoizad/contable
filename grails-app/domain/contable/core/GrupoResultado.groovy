package contable.core

class GrupoResultado {

    String nombre
    Empresa empresa

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'GRUPO_RESULTADO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id column:'SECUENCIAL_GRUPO',sqlType: "int"
        id generator: "increment"
        columns {
            empresa column: 'EMP_CODIGO'
            nombre column: 'NOMBRE_GRUPO'
        }
    }

    static constraints = {
        nombre(size: 1..60)
    }
}
