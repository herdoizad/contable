package contable.core

class Formula{

    Empresa empresa
    String nombre
    Integer operacionesDividendo
    Integer operacionesDivisor
    String descripcionDividendo
    String descripcionDivisor

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'FORMULA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id column:'SECUENCIAL_FORMULA',sqlType: "int"
        id generator: "increment"
        columns {
            empresa column: 'EMP_CODIGO'
            nombre  column: 'NOMBRE_FORMULA'
            operacionesDividendo column: 'OPERACIONES_DIVIDENDO'
            operacionesDivisor column: 'OPERACIONES_DIVISOR'
            descripcionDividendo column: 'DESCRIPCION_DIVIDENDO'
            descripcionDivisor column: 'DESCRIPCION_DIVISOR'
        }
    }

    static constraints = {
        nombre(size: 1..60,nullable: true,blank: true)
        operacionesDividendo(nullable: true)
        operacionesDivisor(nullable: true)
        descripcionDividendo(size: 1..150,nullable: true,blank: true)
        descripcionDivisor(size: 1..150,nullable: true,blank: true)
    }
}
