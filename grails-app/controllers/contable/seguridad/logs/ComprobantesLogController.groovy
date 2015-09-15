package contable.seguridad.logs

import contable.seguridad.Shield
import groovy.sql.Sql

class ComprobantesLogController  extends  Shield{

    def dataSource

    def visor() {
        def operaciones = ["U":"Edición","D":"Eliminación"]
        [operaciones:operaciones]
    }

    def getDetalle_ajax(){
        println "params "+params
        def cn = new Sql(dataSource)
        def desde = new Date().parse("dd-MM-yyyy",params.desde)
        def hasta = new Date().parse("dd-MM-yyyy",params.hasta)
        def sql
        def datos =[]
        if(params.operacion=="U") {
            sql = "select l.MES_CODIGO mes,l.COM_NUMERO numero,l.COM_TIPO_CODIGO tipo," +
                    "l.COM_DESCRIPCION descripcion,l.COM_SIGNO signoO," +
                    "d.COM_SIGNO signoN,l.COM_VALOR valorO,d.COM_VALOR valorN,l.FECHA_ACTUALIZA fecha," +
                    "l.OPERACION operacion,l.EMPLEADO_ACTUALIZA usuario, \n" +
                    "l.CTA_CUENTA cuenta "+
                    "from LOG_CONTABLE..LOG_COMPROBANTE_DETALLE l, CONTABLE..COMPROBANTE_DETALLE d\n" +
                    "where l.MES_CODIGO=d.MES_CODIGO \n" +
                    "and l.COM_NUMERO = d.COM_NUMERO\n" +
                    "and l.COM_TIPO_CODIGO=d.COM_TIPO_CODIGO\n" +
                    "and l.OPERACION ='U'\n" +
                    "and l.COM_VALOR > 0"+
                    "and l.COM_VALOR!=d.COM_VALOR\n" +
                    "and l.FECHA_ACTUALIZA > '${desde.format('MM-dd-yyyy')}'\n" +
                    "and l.FECHA_ACTUALIZA < '${hasta.format('MM-dd-yyyy')}'\n"
            if(params.usuario!="")
                sql+="and l.EMPLEADO_ACTUALIZA='${params.usuario}'"
            sql+="order by l.FECHA_ACTUALIZA desc "
        }else{

        }
        cn.eachRow(sql.toString()){r->
            datos.add(r.toRowResult())
        }
        def tipos = [1:"Ingreso",2:"Egreso",3:"Diario"]
        [datos:datos,tipos:tipos]
    }
}
