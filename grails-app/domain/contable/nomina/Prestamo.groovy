package contable.nomina

class Prestamo {

    Empleado empleado
    Double monto
    Integer plazo
    Double interes=0
    Double valorCuota
    Date inicio
    Date fin
    TipoPrestamo tipo
    String estado = "S"
    Date solicitado = new Date()
    Date fechaRevision
    String usuarioAprueba
    String observaciones
    Empleado garante
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'PRESTAMO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            monto column: 'MONTO'
            plazo column: 'PLAZO'
            interes column: 'INTERES'
            valorCuota column: 'VALOR_CUOTA'
            solicitado column: 'FECHA_SOLICITADO'
            inicio column: 'FECHA_INICIO'
            fin column: 'FECHA_FIN'
            tipo column: 'TIPO_PRESTAMO_ID'
            estado column: 'ESTADO'
            fechaRevision column: 'FECHA_REVISION'
            usuarioAprueba column: 'USUARIO_APRUEBA'
            observaciones column: 'OBSERVACIONES'
            garante column: 'EMPLEADO_GARANTE'
        }
    }

    static constraints = {
        inicio(nullable: true)
        fin(nullable: true)
        estado(size: 1..1)
        fechaRevision(nullable: true)
        usuarioAprueba(nullable: true,size: 1..20)
        observaciones(nullable: true,size: 1..255)
        garante(nullable: true)
        solicitado(nullable: true)
    }


    def getEstadoString(){
        switch (this.estado){
            case "S":
                return "Solicitado"
                break;
            case "A":
                return "Aprobado"
                break;
            case "N":
                return "Negado"
                break;
            case "R":
                return "Revisado"
                break;
        }
    }
}
