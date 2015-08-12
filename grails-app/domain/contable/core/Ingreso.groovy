package contable.core

class Ingreso implements Serializable {
    Integer mes
    Double numero
    Empresa empresa
    Integer tipo
    String recibi
    Double efectivo=0
    Double cheques=0
    Double notas=0
    Double total=0
    String usuario
    Date creacion=new Date()


    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'INGRESO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['mes','numero','empresa','tipo']
        columns {
            mes column: 'MES_CODIGO'
            numero column: 'COM_NUMERO'
            empresa column: 'EMP_CODIGO'
            tipo column: 'COM_TIPO_CODIGO'
            recibi column: 'RECIBI'
            efectivo column: 'EFECTIVO'
            cheques column: 'CHEQUES'
            notas column: 'NC'
            total column: 'TOTAL_INGRESO'
            usuario column: 'EMPLEADO_CREA'
            creacion column: 'FECHA_CREA'

        }
    }

    static constraints = {
        recibi(size: 1..255)
        usuario(size: 1..16)
    }
}
