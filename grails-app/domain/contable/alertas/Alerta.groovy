package contable.alertas

import contable.seguridad.Usuario

class Alerta {

    String para
    String mensaje
    String controlador
    String accion
    String parametros
    Date fecha = new Date()
    Date revisado
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'ALERTA'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        columns {
            id column: 'ID_ALERTA'
            para column: 'PARA_ALERTA'
            mensaje column: 'MENSAJE_ALERTA'
            controlador column: 'CONTROLADOR_ALERTA'
            accion column: 'ACCION_ALERTA'
            parametros column: 'PARAMETROS_ALERTA'
            fecha column: 'FECHA_ALERTA'
            revisado column: 'REVISADO_ALERTA'

        }
    }
    static constraints = {
        para(nullable: true,blank: true,size: 1..20)
        mensaje(nullable: true,blank: true,size: 1..255)
        controlador(nullable: true,blank: true,size: 1..60)
        accion(nullable: true,blank: true,size: 1..60)
        parametros(nullable: true,blank: true,size: 1..60)
        revisado(nullable: true,blank: true)
    }

}
