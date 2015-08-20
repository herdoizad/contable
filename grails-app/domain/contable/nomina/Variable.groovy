package contable.nomina

class Variable {

    String nombre
    String sql
    Double valor
    String codigo

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'VARIABLE_NOMINA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            nombre column:'NOMBRE'
            codigo column:'CODIGO'
            sql column: 'SQL'
            sql type: 'text'
            valor column: 'VALOR'
        }
    }

    static constraints = {
        nombre(size: 1..100)
        codigo(size: 1..20)
        sql(nullable: true)
        valor(nullable: true)

    }
}
