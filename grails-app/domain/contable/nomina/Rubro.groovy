package contable.nomina

import contable.core.Cuenta

class Rubro {

    String formula
    String nombre
    Double valor
    Integer signo
    Cuenta cuenta
    String codigo
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
            cuenta column: 'CTA_CUENTA'
            codigo column: 'CODIGO'
        }
    }

    static constraints = {
        nombre(size: 1..50)
        formula(nullable: true,size: 1..150)
        codigo(nullable: true,size: 1..5)
        valor(nullable: true)
        cuenta(nullable: true)

    }
}
