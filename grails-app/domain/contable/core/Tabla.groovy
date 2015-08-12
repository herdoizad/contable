package contable.core

class Tabla {

    String codigo
    String descripcion
    String padre
    Double porcentaje
    Cuenta cuenta
    String sri
    Date creacion
    String usuario

    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'TABLA_TABLAS'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"string"
        columns {
            codigo column: 'CODIGO_MASTER'
            descripcion column: 'DESCRIPCION'
            padre column: 'CODIGO_PADRE'
            porcentaje column: 'PORCENTAJE'
            cuenta column: 'CTA_CUENTA'
            sri column: 'CODIGO_SRI'
            creacion column: 'FECHA_CREA'
            usuario column: 'EMPLEADO_CREA'

        }
    }
    static constraints = {
        codigo(size: 1..8)
        descripcion(size: 1..50)
        porcentaje(nullable: true,blank:true)
        cuenta(nullable: true,blank:true)
        padre(size: 1..8)
        usuario(nullable: true,blank:true,size: 1..20)
        padre(nullable: true,blank:true,size: 1..15)
    }
}
