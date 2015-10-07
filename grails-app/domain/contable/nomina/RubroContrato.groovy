package contable.nomina

class RubroContrato {

    Rubro rubro
    TipoContrato tipoContrato
    Integer mes
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'RUBRO_CONTRATO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            rubro column: 'RUBRO_ID'
            tipoContrato column: 'TIPO_CONTRATO_ID'
            mes column: 'MES'
        }
    }

    static constraints = {
        mes(nullable: true,blank:true)
    }
}
