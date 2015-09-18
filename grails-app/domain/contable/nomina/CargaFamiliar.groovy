package contable.nomina

class CargaFamiliar {
    Empleado empleado
    String nombre
    String apellido
    String cedula
    Date fechaNacimiento
    String sexo
    String direccion
    String telefono
    String email
    Date inicio
    Date fin  //En caso de que deje de ser carga
    Relacion relacion
    String path

    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'CARGA_FAMILIAR'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: "increment"
        columns {
            id column:'ID'
            empleado column:'EMPLEADO_ID'
            cedula column: "NUMERO_CEDULA"
            nombre column: "NOMBRE"
            apellido column: "APELLLIDO"
            direccion column: "DIRECCION"
            telefono column: "TELEFONO"
            fechaNacimiento column: "FECHA_NACIMIENTO"
            sexo column: "SEXO"
            email column: "EMAIL"
            relacion column: 'RELACION_ID'
            inicio column: 'INICIO'
            fin column: 'FIN'
            path column: 'PATH'
        }
    }

    static constraints = {
        nombre(size: 1..60)
        apellido(size: 1..60)
        cedula(nullable: true,size: 1..10)
        sexo(size: 1..1,inList: ["M","F"])
        direccion(size: 1..150)
        telefono(size: 1..10)
        email(nullable: true, size: 1..60)
        path(nullable: true, size: 1..150)
        fin(nullable: true)
    }
}
