package contable.seguridad

/**
 * Clase para conectar con la tabla 'mdlo' de la base de datos
 */
class Modulo {


    /**
     * Nombre del módulo
     */
    String nombre
    /**
     * Descripción del módulo
     */
    String estado = "A"
    /**
     * Orden del módulo
     */
    Integer orden
    /**
     * Icono del módulo
     */
    String icono = ""

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        datasource 'usuarios'
        table 'MODULOS'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id column:'CODIGO_MODULO',sqlType: "int"
        id generator: "increment"
        columns {
            nombre column: 'NOMBRE_MODULO'
            estado column: 'ESTADO_MODULO'
            orden column: 'ORDEN_MODULO'
            icono column: 'ICONO_MODULO'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        icono(nullable: true,size: 1..30)
        orden(nullable: true)
        nombre(size: 1..20)

    }

    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
