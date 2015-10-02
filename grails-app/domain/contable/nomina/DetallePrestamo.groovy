package contable.nomina

class DetallePrestamo {

    Prestamo prestamo
    Date registro = new Date()
    Double cuota=0
    Double taza=0
    Double interes=0
    Double capital=0
    Date fechaDePago
    Double saldo = 0
    String estado="R"  //R->registrado
    String usuario
    MesNomina mes

/**
 * Define el mapeo entre los campos del dominio y las columnas de la base de datos
 */
    static mapping = {

        table 'DETALLE_PRESTAMO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            prestamo column:'PRESTAMO_ID'
            registro column:'FECHA_REGISTRO'
            cuota column:'CUOTA'
            taza column:'TAZA'
            interes column:'INTERES'
            capital column:'CAPITAL'
            fechaDePago column:'FECHA_DE_PAGO'
            estado column:'ESTADO'
            usuario column:'USUARIO'
            mes column: 'MES_ID'
            saldo column: 'SALDO'
        }
    }

    static constraints = {
        usuario(size: 1..15)
        fechaDePago(nullable: true)
        estado(size: 1..1)
        mes(nullable: true)
        saldo(nullable: true)
    }
}
