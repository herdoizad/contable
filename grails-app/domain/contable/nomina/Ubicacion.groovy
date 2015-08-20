package contable.nomina

class Ubicacion {

    String codigo
    String nombre
    Ubicacion padre


    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'UBICACION'
        sort 'nombre'
        cache usage: 'read-write', include: 'non-lazy'
        id name: "codigo", generator: 'assigned', type:"string"
        version false
        columns {
            codigo column: 'CODIGO_UBICACION', insertable: false, updateable: false
            nombre column: 'DESCRIPCION'
            padre column: 'CODIGO_PADRE'
        }
    }

    static constraints = {
    }
}
