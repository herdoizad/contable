package contable.seguridad

class Usuario {

    String login
    Grupos grupo
    String nombre
    String descripcion
    String password
    String estado

    static auditable = false
    static mapping = {
        datasource 'usuarios'
        table 'USUARIOS'
        cache usage: 'read-write', include: 'non-lazy'
        id name: "login", generator: 'assigned', type:"string"
        version false
        columns {
            login column: 'LOGIN'
            grupo column: 'CODIGO_GRUPO'
            nombre column: 'NOMBRE'
            descripcion column: 'DESCRIPCION'
            password column: 'PASSWORD'
            estado column: 'ESTADO_EMPLEADO'
        }
    }

    static constraints = {
        login(nullable: false,size: 1..16,unique: true)
        nombre(size: 1..30)
        descripcion(size: 1..40)
        password(size: 1..255,nullable: true)
    }

    String toString(){
        return "${this.login}"
    }
}
