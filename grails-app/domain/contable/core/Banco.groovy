package contable.core

class Banco implements Serializable {

    String codigo
    Cuenta cuenta
    Empresa empresa
    String descripcion
    String numero
    String tipo
    Integer ultimoCheque
    Double saldo
    Date fecha
    Date creacion
    String usuario

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'BANCO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"string"
        columns {
            codigo column: 'BAN_CODIGO'
            empresa column: 'EMP_CODIGO'
            descripcion column: 'BAN_DESCRIPCION'
            numero column: 'BAN_NUM_CUENTA'
            tipo column: 'BAN_TIPO_CUENTA'
            ultimoCheque column: 'BAN_ULTIMO_CHEQUE'
            saldo column: 'BAN_SALDO'
            fecha column: 'BAN_FECHA'
            cuenta column: 'CTA_CUENTA'
            creacion column: 'BAN_FECHA_CREA'
            usuario column: 'BAN_EMPLEADO_CREA'

        }
    }


    static constraints = {
        codigo(size: 1..4)
        descripcion(size: 1..30)
        numero(size: 1..20)
        tipo(size: 1..1)
        saldo(nullable: true)
        fecha(nullable: true)
        creacion(nullable: true)
        usuario(nullable: true,blank:true,size: 1..20)
    }
}
