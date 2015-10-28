package contable.core.conciliacion

class Conciliacion implements Serializable {

    String numeroFactura
    String estado
    Date acreditacion
    String usuario
    Date registro
    String opcion
    BancoConciliacion banco
    Date venta
    Date vence
    Integer diasMora
    Double taza
    Double mora
    String snreporte

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        datasource 'pys'
        table 'CONCILIACION'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "numeroFactura", generator: 'assigned', type:"string"
        columns {
            numeroFactura column: 'NUMERO_FACTURA'
            estado column: 'ESTADO_CONCILIACION'
            acreditacion column: 'FECHA_ACREDITACION'
            usuario column: 'EMPLEADO_CREA'
            registro column: 'FECHA_CREA'
            opcion column: 'OPCION_CONCILIACION'
            banco column: 'CONCILIA_BANCO'
            venta column: 'FECHA_VENTA'
            vence column: 'FECHA_VENCE'
            diasMora column: 'DIAS_MORA'
            taza column: 'TASA_INTERES'
            mora column: 'VALOR_MORA'
            snreporte  column: 'SNREPORTE'
        }
    }


    static constraints = {
        numeroFactura(size: 1..8)
        estado(size: 1..2,nullable: true,blank: true)
        acreditacion(nullable: true,blank: true)
        usuario(nullable: true,blank: true,size: 1..12)
        registro(nullable: true,blank: true)
        opcion(nullable: true,blank: true,size: 1..2)
        banco(nullable: true,blank: true)
        venta(nullable: true,blank: true)
        vence(nullable: true,blank: true)
        diasMora(nullable: true,blank: true)
        taza(nullable: true,blank: true)
        mora(nullable: true,blank: true)
        snreporte(nullable: true,blank: true,size: 1..1)
    }
}
