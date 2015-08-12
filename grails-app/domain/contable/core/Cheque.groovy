package contable.core

class Cheque implements Serializable {

    Integer numero
    Banco banco
    Integer mes
    Double comprobante
    Empresa empresa
    Integer tipo
    String cuenta
    String beneficiario
    Date emision
    Double valor
    String usuario
    Date creacion = new Date()
    Date entrega
    Integer entregado
    Integer conciliado
    String codigoBeneficiario

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'CHEQUE'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['numero','banco']
        columns {
            numero column: 'CHE_NUMERO_CHEQUE'
            banco column: 'BAN_CODIGO'
            mes  column: 'MES_CODIGO'
            comprobante column: 'COM_NUMERO'
            empresa column: 'EMP_CODIGO'
            tipo column: 'COM_TIPO_CODIGO'
            cuenta column: 'CHE_CUENTA'
            beneficiario column: 'CHE_BENEFICIARIO'
            emision column: 'CHE_FECHA_EMISION'
            valor column: 'CHE_VALOR'
            usuario column: 'CHE_EMPLEADO_CREA'
            creacion column: 'CHE_FECHA_CREA'
            entrega column: 'CHE_FECHA_ENTREGA'
            entregado column: 'CHE_ENTREGADO'
            conciliado column: 'CHE_MES_CONCILIA'
            codigoBeneficiario column: 'CHE_CODIGOBENEF'
        }
    }


    static constraints = {
         cuenta(nullable: true,blank: true,size: 1..15)
         beneficiario(size: 1..100)
         emision(nullable: true)
         valor(nullable: true)
         usuario(size: 1..16,nullable: true,blank: true)
         creacion(nullable: true,blank: true)
         entrega(nullable: true,blank: true)
         entregado(nullable: true,blank: true)
         conciliado(nullable: true,blank: true)
         codigoBeneficiario(size: 1..8, nullable: true,blank: true)
    }
}
