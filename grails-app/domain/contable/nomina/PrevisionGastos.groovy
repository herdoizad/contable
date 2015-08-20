package contable.nomina

class PrevisionGastos {

    Empleado empleado
    Integer anio
    Double totalAlimentacion = 0
    Double totalVivienda = 0
    Double totalSalud = 0
    Double totalEducacion = 0
    Double totalVestimenta = 0

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'PREVISION_RENTA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            anio column: 'anio'
            totalAlimentacion column: 'TOTAL_ALIMENTACION'
            totalVivienda column: 'TOTAL_VIVIENDA'
            totalSalud column: 'TOTAL_SALUD'
            totalEducacion column: 'TOTAL_EDUACION'
            totalVestimenta column: 'TOTAL_VESTIMENTA'
        }
    }

    static constraints = {

    }
}
