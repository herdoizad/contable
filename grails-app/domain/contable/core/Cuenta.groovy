package contable.core

class Cuenta {
    String numero
    Empresa empresa
    String descripcion
    String clase
    Integer agrupa
    Integer nivel
    Integer tipoPresupuesto
    String auxiliar1
    String auxiliar2
    String auxiliar3
    Double saldoInicial
    Double debe
    Double haber
    Double saldoDeudor
    Double saldoAcreedor
    Date creacion
    String usuario
    Date inicio
    String padre
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'PLAN_CUENTA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "numero", generator: 'assigned', type:"string"
        columns {
            numero column: 'CTA_CUENTA'
            empresa column: 'EMP_CODIGO'
            descripcion column: 'CTA_DESCRIPCION'
            clase column: 'CTA_CLASE'
            agrupa column: 'CTA_AGRUPA'
            nivel column: 'CTA_NIVEL'
            tipoPresupuesto column: 'CTA_TIPO_PRESUPUESTO'
            auxiliar1 column: 'CTA_AUXILIAR1'
            auxiliar2 column: 'CTA_AUXILIAR2'
            auxiliar3 column: 'CTA_AUXILIAR3'
            saldoInicial column: 'CTA_SALDO_INI'
            debe column: 'CTA_DEBE'
            haber column: 'CTA_HABER'
            saldoDeudor column: 'CTA_SALDO_DEU'
            saldoAcreedor column: 'CTA_SALDO_ACR'
            creacion column: 'CTA_FECHA_CREA'
            inicio column: 'CTA_FECHA_INICIO_CUENTA'
            usuario column: 'CTA_EMPLEADO_CREA'
            padre column: 'CTA_PADRE'
        }
    }
    static constraints = {
        numero(size: 1..15)
        empresa(size: 1..2)
        descripcion(size: 1..60)
        clase(size: 1..1)
        agrupa(nullable: true,blank:true)
        tipoPresupuesto(nullable: true,blank:true)
        auxiliar1(size: 1..15,nullable: true,blank:true)
        auxiliar2(size: 1..15,nullable: true,blank:true)
        auxiliar3(size: 1..15,nullable: true,blank:true)
        saldoInicial(nullable: true,blank:true)
        debe(nullable: true,blank:true)
        haber(nullable: true,blank:true)
        saldoDeudor(nullable: true,blank:true)
        saldoAcreedor(nullable: true,blank:true)
        inicio(nullable: true,blank:true)
        usuario(nullable: true,blank:true,size: 1..20)
        padre(nullable: true,blank:true,size: 1..15)
    }

    String toString(){
        return "${this.numero.trim()} - ${this.descripcion.trim()}"
    }

    def getClaseString(){
        switch (this.clase){
            case "1":
                return "Activo"
                break;
            case "2":
                return "Pasivo"
                break;
            case "3":
                return "Patrimonio"
                break;
            case "4":
                return "Ingresos"
                break;
            case "5":
                return "Egresos"
                break;
            case "6":
                return "De orden"
                break;
            default:
                return "De orden"
        }
    }

}
