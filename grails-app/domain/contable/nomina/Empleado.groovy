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

    String path /*path al pdf de la hoja de vida*/

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
        }
    }

    static constraints = {
        nombre(size: 1..60)
        apellido(size: 1..60)
        cedula(size: 1..10)
        sexo(size: 1..1,inList: ["M","F"])
        direccion(size: 1..150)
        telefono(size: 1..10)
        email(size: 1..60)
        path(nullable: true,size: 1..150)
        cargo(size: 1..50)
        tipoSangre(size: 1..4,nullable: true)
        nacionalidad(size: 1..40)
        afiliacionIess(size: 1..20,nullable: true)
        ciudadTrabajo(size: 1..50,nullable: true)
        codigoSectorial(size: 1..20,nullable: true)
        cuenta(size: 1..20,nullable: true)
        banco(size: 1..50,nullable: true)
        tipoCuenta(size: 1..1,nullable: true)
        estado(size: 1..1)
        cuentaContable(size: 1..15,nullable: true)
    }

    String toString(){
        return "${this.nombre} ${this.apellido}"
    }

}
