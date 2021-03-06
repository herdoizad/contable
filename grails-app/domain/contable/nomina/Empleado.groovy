package contable.nomina

import contable.core.Cuenta

class Empleado {

    EstadoCivil estadoCivil
//    Ubicacion ubicacion
    Unidad unidad
    String nombre
    String apellido
    String cedula
    Date fechaNacimiento
    String sexo
    String direccion
    String calleSecundaria
    String numero
    String telefono
    String cargo
    String email
    String tipoSangre
    String nacionalidad
    String afiliacionIess
    String ciudadTrabajo
    String codigoSectorial
    Date registro = new Date()
    String cuenta
    String banco
    String tipoCuenta
    String estado  ="A"
    String foto
    String path /*path al pdf de la hoja de vida*/
    String sistemaDeFacturacion
    String usuario

    Cuenta cuentaContable /*Todo esto cambiar a dominio cuenta cuando se una con contabilidad*/

    static auditable = false
    static mapping = {
        table 'EMPLEADO'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: "increment"
        version false
        columns {
            id column:'ID'
            cedula column: "NUMERO_CEDULA"
            estadoCivil column: "CODIGO_ESTADO_CIVIL"
            nombre column: "NOMBRE"
            apellido column: "APELLLIDO"
            direccion column: "DIRECCION"
            calleSecundaria column: "CALLE_SECUNDARIA"
            numero column: 'NUMERO_DIRECCION'
            telefono column: "TELEFONO"
            fechaNacimiento column: "FECHA_NACIMIENTO"
            nacionalidad column: "NACIONALIDAD"
            afiliacionIess column: "AFILIACION_IESS"
            cargo column: "CARGO"
            sexo column: "SEXO"
            estado column: "ESTADO_EMPLEADO"
            tipoSangre column: "TIPO_SANGRE"
            codigoSectorial column: "CODIGO_SECTORIAL"
            ciudadTrabajo column: "CIUDAD_TRABAJO"
            cuenta column: "CUENTA_BANCO"
            email column: "DIRECCION_ELECTRONICA"
//            ubicacion column: 'CODIGO_UBICACION'
            unidad column:'UNIDAD_ID'
            registro column:'FECHA_REGISTRO'
            banco column: 'BANCO'
            tipoCuenta column: 'TIPO_CUENTA'
            estado column: 'ESTADO'
            path column: 'PATH'
            cuentaContable column: 'CTA_CUENTA'
            foto column: 'PATH_FOTO'
            sistemaDeFacturacion column: 'SISTEMA_FACTURACION'
            usuario column: 'USUARIO_LOGIN'
        }
    }

    static constraints = {
        nombre(size: 1..60)
        apellido(size: 1..60)
        cedula(size: 1..10)
        sexo(size: 1..1,inList: ["M","F"])
        fechaNacimiento(nullable: true)
        direccion(size: 1..150,nullable: true)
        telefono(size: 1..10,nullable: true)
        email(size: 1..60,nullable: true)
        path(nullable: true,size: 1..150)
        cargo(size: 1..50,nullable: true)
        tipoSangre(size: 1..4,nullable: true)
        nacionalidad(size: 1..40,nullable: true)
        afiliacionIess(size: 1..20,nullable: true)
        ciudadTrabajo(size: 1..50,nullable: true)
        codigoSectorial(size: 1..20,nullable: true)
        cuenta(size: 1..20,nullable: true)
        banco(size: 1..50,nullable: true)
        tipoCuenta(size: 1..1,nullable: true)
        estado(size: 1..1)
        cuentaContable(size: 1..15,nullable: true)
        numero(nullable: true,blank: true,size: 1..20)
        calleSecundaria(nullable: true,blank: true,size: 1..75)
        foto(nullable: true,blank: true,size: 1..150)
        sistemaDeFacturacion(nullable: true,blank: true,size: 1..1)
        usuario(nullable: true,blank: true,size: 1..20)
    }

    String toString(){
        return "${this.apellido} ${this.nombre}"
    }

}
