package contable.core

class Empresa implements Serializable{

    String codigo
    String descripcion
    String direccion
    String telefono
    String fax
    String casilla
    Integer secuencialFactura
    Integer secuencialComprobante
    Integer secuencialIngreso
    Integer secuencialEgreso
    Integer secuencialDiario
    Double porcentajeIva
    String representante
    String contador
    String ruc
    String email
    String moneda
    Integer anio
    String comodin
    String principal
    String cedulaContador
    String cedulaRepresentante
    String tipoRepresentante
    Integer numeroCopias
    Integer secucialTransporte
    String editable="S"

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'EMPRESA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"string"
        columns {
            codigo column: 'EMP_CODIGO'
            descripcion column: 'EMP_DESCRIPCION'
            direccion column: 'EMP_DIRECCION'
            telefono column: 'EMP_TELEFONO'
            fax column: 'EMP_FAX'
            casilla column: 'EMP_CASILLA'
            secuencialFactura column: 'EMP_SECUENCIA_FACTURA'
            secuencialComprobante column: 'EMP_SECUENCIA_COMPROBANTE'
            secuencialIngreso column: 'EMP_SECUENCIA_INGRESO'
            secuencialEgreso column: 'EMP_SECUENCIA_EGRESO'
            secuencialDiario column: 'EMP_SECUENCIA_DIARIO'
            porcentajeIva column: 'EMP_IVA_PORCENTAJE'
            representante column: 'EMP_REPRESENTANTE'
            contador column: 'EMP_CONTADOR'
            ruc column: 'EMP_RUC'
            email column: 'EMP_EMAIL'
            moneda column: 'EMP_MONEDA'
            anio column: 'EMP_ANO_VIGENTE'
            comodin column: 'EMP_COMODIN_PLAN'
            principal column: 'EMP_DEFAULT'
            cedulaContador column: 'EMP_CI_CONTADOR'
            cedulaRepresentante column: 'EMP_CI_REP'
            tipoRepresentante column: 'EMP_TIPOREP'
            numeroCopias column: 'EMP_NUMEROCOPIAS'
            secucialTransporte column: 'EMP_SECUENCIA_FACT_TRANSPORTE'
            editable column: 'EMP_EDITABLE'
        }
    }


    static constraints = {
         codigo(nullable: false,blank: false,size: 1..2)
         descripcion(nullable: false,blank: false,size: 1..50)
         direccion(nullable: false,blank: false,size: 1..50)
         telefono(nullable: false,blank: false,size: 1..15)
         fax(nullable: false,blank: false,size: 1..15)
         casilla(nullable: false,blank: false,size: 1..15)
         secuencialFactura(nullable: false,blank: false)
         secuencialComprobante(nullable: false,blank: false)
         secuencialIngreso(nullable: false,blank: false)
         secuencialEgreso(nullable: false,blank: false)
         secuencialDiario(nullable: false,blank: false)
         porcentajeIva(nullable: false,blank: false)
         representante(nullable: false,blank: false,size: 1..50)
         contador(nullable: false,blank: false,size: 1..50)
         ruc(nullable: false,blank: false,size: 1..13)
         email(nullable: false,blank: false,size: 1..30)
         moneda(nullable: false,blank: false,size: 1..3)
         anio(nullable: false,blank: false)
         comodin(nullable: true,blank: true,size: 1..1)
         principal(nullable: true,blank: true,size: 1..1)
         cedulaContador(nullable: true,blank: true,size: 1..13)
         cedulaRepresentante(nullable: true,blank: true,size: 1..13)
         tipoRepresentante(nullable: true,blank: true,size: 1..1)
         numeroCopias(nullable: true,blank: true)
         secucialTransporte(nullable: true,blank: true)
        editable(nullable: true,blank: true,size: 1..1)
    }
}
