package contable.core

class DetalleDividendo implements Serializable {

    Integer formula
    Empresa empresa
    String campo1
    String campo2
    String campo3
    String signo1
    String signo2



    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {

        table 'DETALLE_DIVIDENDO'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id composite: ['formula','empresa']
        columns {
            empresa column: 'EMP_CODIGO'
            formula column:'SECUENCIAL_FORMULA'
            campo1 column:'CAMPO_1'
            campo2 column:'CAMPO_2'
            campo3 column:'CAMPO_3'
            signo1 column:'SIGNO_1'
            signo2 column:'SIGNO_2'
        }
    }

    static constraints = {
        campo1(nullable: true,blank: true,size: 1..15)
        campo2(nullable: true,blank: true,size: 1..15)
        campo3(nullable: true,blank: true,size: 1..15)
        signo1(nullable: true,blank: true,size: 1..1)
        signo2(nullable: true,blank: true,size: 1..1)
    }

    def getCampo1Pad(){
        def res =""
        if(!this.campo1)
            return res
        res=this.campo1
        (15-this.campo1.length()).times {
            res+=" "
        }
        return res
    }

    def getCampo2Pad(){
        def res =""
        if(!this.campo2)
            return res
        res=this.campo2
        (15-this.campo2.length()).times {
            res+=" "
        }
        return res
    }

    def getCampo3Pad(){
        def res =""
        if(!this.campo3)
            return res
        res=this.campo3
        (15-this.campo3.length()).times {
            res+=" "
        }
        return res
    }

}
