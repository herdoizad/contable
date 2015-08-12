package contable.core

class Comprobante  implements Serializable{
    Integer mes
    Double numero
    Empresa empresa
    Integer tipo
    String concepto
    Date fecha
    Double numeroCheque
    Double cotiza
    Double control
    Integer tipoProcesamiento
    String usuario
    Date creacion=new Date()
    Integer revisaAuditoria
    String beneficiario
    Integer ocp
    String tipoOcp
    Date fechaOcp
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'COMPROBANTE_MAESTRO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['mes','numero','empresa','tipo']
        columns {
            mes column: 'MES_CODIGO'
            numero column: 'COM_NUMERO'
            empresa column: 'EMP_CODIGO'
            tipo column: 'COM_TIPO_CODIGO'
            concepto column: 'COM_CONCEPTO'
            fecha column: 'COM_FECHA'
            numeroCheque column: 'COM_NUMERO_CHEQUE'
            cotiza column: 'COM_COTIZA_DOLAR'
            control column: 'COM_CODIGO_CONTROL'
            tipoProcesamiento column: 'COM_TIPO_PROCESAMIENTO'
            usuario column: 'COM_EMPLEADO_CREA'
            creacion column: 'COM_FECHA_CREA'
            revisaAuditoria column: 'REVISA_AUDITORIA'
            beneficiario column: 'CODIGO_BENEFICIARIO'
            ocp column: 'COM_OCP'
            tipoOcp column: 'COM_TIPO_OCP'
            fechaOcp column: 'COM_FECHA_OCP'
        }
    }
    static constraints = {
        concepto(size: 1..255)
        numeroCheque(nullable: true,blank:true)
        cotiza(nullable: true,blank:true)
        usuario(size: 1..16)
        revisaAuditoria(nullable: true,blank:true)
        beneficiario(nullable: true,blank: true,size: 1..8)
        ocp(nullable: true,blank:true)
        tipoOcp(nullable: true,blank:true,size: 1..2)
        fechaOcp(nullable: true,blank:true)

    }

    def getTipoString(){
        switch (this.tipo){
            case 1:
                return "Ingreso"
                break;
            case 2:
                return "Egreso"
                break;
            case 3:
                return "Diario"
                break;
            case 4:
                return "Ajuste"
                break;
            default:
                return ""
        }
    }
}
