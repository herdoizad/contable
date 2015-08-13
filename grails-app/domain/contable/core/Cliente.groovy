package contable.core

class Cliente implements Serializable{
    Empresa empresa
    String codigo
    String cp
    String auxiliar
    String auxiliar2
    String nombre
    String ruc
    String ciudad
    String direccion
    String telefono
    String fax
    String contacto
    String observacion
    String codigoLista
    Integer tipo
    String email
    String cuentaPorCobrar
    String cuentaPorPagar
    Date creacion
    String usuario
    String proveedor
    String cliente
    Integer codigoVendedor
    String aceptaMora
    String cuentaAnticipos
    String contibuyenteEspecial
    String cuentaPrestamos
    String retieneFuente
    BancoOcp banco
    String tipoCuenta
    String numeroCuenta
    String tipoid


    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'CLIENTE_PROVEDOR'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['empresa','codigo']
        columns {
            empresa column: 'EMP_CODIGO'
            codigo column: 'CODIGO_CLIENTE'
            cp column: 'CP_CLIENTE'
            auxiliar column: 'CTA_AUXILIAR1'
            auxiliar2 column: 'CATA_AUXILIAR2'
            nombre column: 'CP_NOMBRE_CLIENTE'
            ruc column: 'CP_RUC'
            ciudad column: 'CP_CIUDAD'
            direccion column: 'CP_DIRECCION'
            telefono column: 'CP_TELEFONO'
            fax column: 'CP_FAX'
            contacto column: 'CONTACTO'
            observacion column: 'OBSERVACION'
            codigoLista column: 'CODIGO_LISTA'
            tipo column: 'TIPO_CLIENTE'
            email column: 'MAIL_CLIENTE'
            cuentaPorCobrar column: 'CTAXCOBRAR'
            cuentaPorPagar column: 'CTAXPAGAR'
            creacion column: 'CP_FECHA_CREA'
            usuario column: 'CP_EMPLEADO_CREA'
            proveedor column: 'PROVEEDOR'
            cliente column: 'CLIENTE'
            codigoVendedor column: 'CODIGO_VENDEDOR'
            aceptaMora column: 'ACEPTA_MORA'
            cuentaAnticipos column: 'CTA_ANTICIPOS'
            contibuyenteEspecial column: 'CONTRIBUYENTE_ESPECIAL'
            cuentaPrestamos column: 'CTA_PRESTAMO'
            retieneFuente column: 'RETIENE_FUENTE'
            banco column: 'CP_BANCO'
            tipoCuenta column: 'CP_TIPO_CUENTA'
            numeroCuenta column: 'CP_NUM_CUENTA'
            tipoid column: 'CP_TIPOID'

        }
    }

    static constraints = {
        codigo(size: 1..8)
        cp(size: 1..100)
        auxiliar(nullable: true,blank: true, size: 1..15)
        auxiliar2(nullable: true,blank: true,size: 1..15)
        nombre(nullable: true,blank: true,size: 1..50)
        ruc(nullable: true,blank: true,size: 1..13)
        ciudad(nullable: true,blank: true,size: 1..20)
        direccion(nullable: true,blank: true,size: 1..50)
        telefono(nullable: true,blank: true,size: 1..10)
        fax(nullable: true,blank: true,size: 1..10)
        contacto(nullable: true,blank: true,size: 1..50)
        observacion(nullable: true,blank: true,size: 1..255)
        codigoLista(nullable: true,blank: true,size: 1..4)
        tipo(nullable: true,blank: true)
        email(nullable: true,blank: true,size: 1..90)
        cuentaPorCobrar(nullable: true,blank: true,size: 1..15)
        cuentaPorPagar(nullable: true,blank: true,size: 1..15)
        usuario(size: 1..16)
        proveedor(nullable: true,blank: true,size: 1..1)
        cliente(nullable: true,blank: true,size: 1..1)
        codigoVendedor(nullable: true,blank: true)
        aceptaMora(nullable: true,blank: true,size: 1..1)
        cuentaAnticipos(nullable: true,blank: true,size: 1..15)
        contibuyenteEspecial(nullable: true,blank: true,size: 1..1)
        cuentaPrestamos(nullable: true,blank: true,size: 1..15)
        retieneFuente(nullable: true,blank: true,size: 1..1)
        banco(nullable: true,blank: true,size: 1..3)
        tipoCuenta(nullable: true,blank: true,size: 1..3)
        numeroCuenta(nullable: true,blank: true,size: 1..20)
        tipoid(nullable: true,blank: true,size: 1..2)
    }

    String toString(){
        return "${this.ruc} - ${this.nombre}"
    }
}
