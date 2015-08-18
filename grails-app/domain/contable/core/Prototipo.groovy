package contable.core

class Prototipo implements Serializable{

//    Integer codigo
    Empresa empresa
    String descripcion
    String usuario
    Date creacion

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'PROTOTIPO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id column:'CODIGO_PROTOTIPO',sqlType: "int"
        id generator: "increment"
        columns {
//            codigo column: 'CODIGO_PROTOTIPO'
            empresa column: 'EMP_CODIGO'
            descripcion column: 'DESCRIPCION'
            creacion column: 'FECHA_CREA'
            usuario column: 'EMPLEADO_CREA'
        }
    }

    static constraints = {
        descripcion(size: 1..50)
        usuario(size: 1..16)
    }
}
