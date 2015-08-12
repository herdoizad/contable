package contable.seguridad

/**
 * Clase para conectar con la tabla 'accs' de la base de datos
 */
class Horario implements Serializable{

    Integer dia
    Usuario usuario
    String inicio
    String fin

    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        datasource 'usuarios'
        table 'HORARIO_ACCESO'
        cache usage: 'read-write', include: 'non-lazy'
        id composite:['dia', 'usuario']
        version false
        columns {
            dia column: 'DIA_SEMANA'
            usuario column: 'LOGIN'
            inicio column: 'HORA_INICIO'
            fin column: 'HORA_FIN'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        inicio(size: 1..8)
        fin(size:1..8)
    }


}
