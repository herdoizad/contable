package contable.core

class Mes {

    Integer codigo
    Empresa empresa
    Date inicio
    Date fin
    String estado
    String usuario
    Date creacion
    String periodoSri
    String descripcion
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'MES_PROCESO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"int"
        columns {
            codigo column: 'MES_CODIGO'
            inicio column: 'MES_PRIMER_DIA'
            fin column: 'MES_ULTIMO_DIA'
            estado column: 'MES_ESTADO'
            creacion column: 'MES_FECHA_CREA'
            periodoSri column: 'MES_PERIODO_SRI'
            descripcion column: 'MES_DESCRIPCION_PERIODO'
            empresa column: 'EMP_CODIGO'
            usuario column: 'MES_EMPLEADO_CREA'
        }
    }

    static constraints = {
        estado(nullable: false,blank: false,size: 1..1)
        periodoSri(nullable: true,blank: true,size: 1..5)
        descripcion(nullable: true,blank: true,size: 1..50)
    }
}
