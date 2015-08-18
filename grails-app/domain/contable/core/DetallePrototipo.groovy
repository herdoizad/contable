package contable.core

class DetallePrototipo implements Serializable{

    Integer codigo
    Empresa empresa
    Integer secuencial
    Cuenta cuenta
    String descripcion
    Integer signo
    Double valor
    String usuario
    Date creacion

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'DETALLE_PROTOTIPO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['codigo','empresa','secuencial']
        columns {
            codigo column: 'CODIGO_PROTOTIPO'
            empresa column: 'EMP_CODIGO'
            secuencial column: 'SECUENCIAL'
            cuenta column: 'CODIGO_CUENTA'
            descripcion column: 'DP_DESCRIPCION'
            signo column: 'DP_SIGNO'
            valor column: 'DP_VALOR'
            creacion column: 'FECHA_CREA'
            usuario column: 'EMPLEADO_CREA'
        }
    }

    static constraints = {
        descripcion(size: 1..35)
        usuario(size: 1..16)
    }
}
