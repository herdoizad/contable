package contable.nomina

class Unidad {

    Empleado jefe
    Unidad padre
    String nombre
    String codigo
    String lugar
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'UNIDAD'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            jefe column:'JEFE'
            padre column:'PADRE'
            nombre column:'NOMBRE'
            codigo column:'CODIGO'
            lugar column:'LUGAR'
        }
    }

    static constraints = {
        nombre(size: 1..100)
        jefe(nullable: true)
        padre (nullable: true)
        codigo(size: 1..5)
        lugar (nullable: true,size: 1..30)

    }
}
