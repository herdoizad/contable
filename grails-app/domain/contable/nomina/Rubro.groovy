package contable.nomina

class Rubro {

    String formula
    String nombre
    Double valor
    Integer signo
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'RUBRO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            formula column:'FORMULA'
            nombre column:'NOMBRE'
            valor column:'VALOR'
            signo column:'SIGNO'
        }
    }

    static constraints = {
        nombre(size: 1..50)
        formula(nullable: true,size: 1..150)
        valor(nullable: true)

    }
}