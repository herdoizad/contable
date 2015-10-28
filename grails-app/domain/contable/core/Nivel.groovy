package contable.core

class Nivel implements Serializable {

    String codigo
    Integer nivel1
    String nivelDesc1
    Integer nivel2
    String nivelDesc2
    Integer nivel3
    String nivelDesc3
    Integer nivel4
    String nivelDesc4
    Integer nivel5
    String nivelDesc5
    Integer nivel6
    String nivelDesc6
    String usuario
    Date creacion
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'NIVEL'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id name: "codigo", generator: 'assigned', type:"int"
        columns {
            codigo column: 'EMP_CODIGO'
            nivel1 column: 'NIVEL_1'
            nivelDesc1 column: 'NIVEL_DESCRIPCION_1'
            nivel2 column: 'NIVEL_2'
            nivelDesc2 column: 'NIVEL_DESCRIPCION_2'
            nivel3 column: 'NIVEL_3'
            nivelDesc3 column: 'NIVEL_DESCRIPCION_3'
            nivel4 column: 'NIVEL_4'
            nivelDesc4 column: 'NIVEL_DESCRIPCION_4'
            nivel5 column: 'NIVEL_5'
            nivelDesc5 column: 'NIVEL_DESCRIPCION_5'
            nivel6 column: 'NIVEL_6'
            nivelDesc6 column: 'NIVEL_DESCRIPCION_6'
            creacion column: 'NIVEL_FECHA_CREA'
            usuario column: 'NIVEL_EMPLEADO_CREA'
        }
    }

    static constraints = {
        codigo(size: 1..2)
        nivelDesc1(size: 1..15)
        nivelDesc2(size: 1..15)
        nivelDesc3(size: 1..15)
        nivelDesc4(size: 1..15)
        nivelDesc5(size: 1..15,nullable: true)
        nivel5(nullable: true)
        nivelDesc6(size: 1..15,nullable: true)
        nivel5(nullable: true)
        usuario(size: 1..16)
    }
}
