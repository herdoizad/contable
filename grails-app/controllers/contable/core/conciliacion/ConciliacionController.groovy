package contable.core.conciliacion

import contable.core.Comprobante
import contable.core.DetalleComprobante
import contable.seguridad.Shield
import groovy.sql.Sql

class ConciliacionController extends Shield {
    def dataSource_pys
    def dataSource
    def index() {

    }

    def cargaTablaFacturas_ajax(){
        def cn = new Sql(dataSource_pys)
        def fecha = new Date().parse("dd-MM-yyyy",params.fecha)
        def sql = "up_optimiza_concilia_fecha '${fecha.format('MM-dd-yyyy')}' "
        def datos = []
        def datosCon = [:]
        cn.eachRow(sql.toString()){r->
            datos.add(r.toRowResult())
            datosCon.put(r["NUMERO_FACTURA"].trim(),[:])
        }
        /*TODO arreglar esto.. sacar directamente por cada factura??*/
        sql = "\n" +
                "SELECT  CONCILIACION.NUMERO_FACTURA ,CONCILIACION.ESTADO_CONCILIACION ,CONCILIACION.FECHA_ACREDITACION ,  " +
                "         CONCILIACION.OPCION_CONCILIACION,CONCILIACION.CONCILIA_BANCO,CONCILIACION.FECHA_VENTA\n" +
                "        FROM CONCILIACION,FACTURA\n" +
                "        WHERE FACTURA.NUMERO_FACTURA=CONCILIACION.NUMERO_FACTURA and (FACTURA.FECHA_VENTA = '${fecha.format('MM-dd-yyyy')}')  "
        cn.eachRow(sql.toString()){r->
            datosCon.put(r["NUMERO_FACTURA"].trim(),r.toRowResult())
        }
        def bancos = BancoConciliacion.list([sort:"descripcion"])
        cn.close()
        [datos:datos,datosCon:datosCon,bancos:bancos]
    }

    def cargaTablaConcilia_ajax(){
        def cn = new Sql(dataSource_pys)
        def fecha = new Date().parse("dd-MM-yyyy",params.fecha)
        def sql = "\n" +
                "SELECT  CONCILIACION.NUMERO_FACTURA ,CONCILIACION.ESTADO_CONCILIACION ,CONCILIACION.FECHA_ACREDITACION ,  " +
                "         CONCILIACION.OPCION_CONCILIACION,CONCILIACION.CONCILIA_BANCO,CONCILIACION.FECHA_VENTA\n" +
                "        FROM CONCILIACION\n" +
                "        WHERE (CONCILIACION.FECHA_VENTA = '${fecha.format('MM-dd-yyyy')}')  "
        println "sql "+sql
        def datos = []
        cn.eachRow(sql.toString()){r->

            datos.add(r.toRowResult())
        }
        cn.close()
        [datos:datos]
    }

    def saveConcilia_ajax(){
//        println "params "+params
        def concilia = Conciliacion.findByNumeroFactura(params.numero)
        concilia.banco=BancoConciliacion.findByConciliaBanco(params.banco)
        concilia.acreditacion=new Date().parse("dd-MM-yyyy",params.fecha)
        if(!concilia.save(flush: true))
            println "error save concilia "+concilia.errors
        redirect(action: "cargaTablaFacturas_ajax",params: [fecha:params.fechaLista])
    }

    def conciliaForm_ajax(){
        def fact = params.numero
        def bancos = BancoConciliacion.list([sort:"descripcion"])
        def fechaVenta
        def cn = new Sql(dataSource_pys)
        def sql ="SELECT CODIGO_CONDICION,FECHA_VENCIMIENTO,FECHA_VENTA\n" +
                "\tFROM FACTURA\n" +
                "\tWHERE NUMERO_FACTURA ='${params.numero}'"
        cn.eachRow(sql.toString()){r->
            fechaVenta=r["FECHA_VENTA"]
        }
        cn.close()
        [fact:fact,bancos:bancos,fechaLista:params.fechaLista,fechaVenta:fechaVenta]
    }

    def saveConciliaForm_ajax(){
        println "save form "+params
        def concilia = new Conciliacion()
        concilia.numeroFactura=params.numero
        concilia.acreditacion=new Date().parse("d-MM-yyyy",params.fechaNuevo_input)
        concilia.banco=BancoConciliacion.findByConciliaBanco(params.banco)
        concilia.estado='-1'
        concilia.usuario=session.usuario.login
        concilia.registro=new Date()
        concilia.opcion="BA"
        def cn = new Sql(dataSource_pys)
        def sql ="SELECT CODIGO_CONDICION,FECHA_VENCIMIENTO,FECHA_VENTA\n" +
                "\tFROM FACTURA\n" +
                "\tWHERE NUMERO_FACTURA ='${params.numero}'"
        cn.eachRow(sql.toString()){r->
            concilia.venta=r["FECHA_VENTA"]
            concilia.vence=r["FECHA_VENCIMIENTO"]
        }
//        sql ="update FACTURA set ESTADO_CONCILIACION='-1' where NUMERO_FACTURA='${params.numero}'"
        if(!concilia.save(flush: true)){
            println "error conciclia "+concilia.errors
        }else{
//            println "update "+cn.execute(sql.toString())
        }
        cn.close()
        redirect(action: "cargaTablaFacturas_ajax",params: [fecha:params.fechaLista])
    }



    def contabilizar(){

    }

    def procesaEstaciones_ajax(){
        println "params "+params
        def fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        def dia = fecha.format("dd")
        if(dia.length()<2)
            dia="0"+dia
        def numeroComp = "0330"+dia
//        year(date(em_f_inicio.text))*100 + month(date(em_f_inicio.text))
        def mes = fecha.format("yyyy").toInteger()*100+(fecha.format("MM").toInteger())

        def sql = "SELECT COUNT(MES_CODIGO) num \n" +
                "\t\tFROM\t COMPROBANTE_MAESTRO\n" +
                "\t\tWHERE\t MES_CODIGO = ${mes} AND COM_NUMERO = ${numeroComp} " +
                "AND EMP_CODIGO = 'PS' AND COM_TIPO_CODIGO = 3 AND COM_TIPO_PROCESAMIENTO=1"

        def cn = new Sql(dataSource)
        def cnpys = new Sql(dataSource_pys)
        def count = 0
        def mensaje
        cn.eachRow(sql.toString()){r->
            count=r["num"]
        }
        if(count>0){
            mensaje ="Información ya procesada "

        }
        cnpys.execute("EXECUTE up_cuentas_concilia_contable '${fecha.format('MM-dd-yyyy')}'")
        sql ="SELECT ISNULL(COUNT(CODIGO_CLIENTE),0) as num\n" +
                "\t\t\tFROM\t CUENTAS_ERROR_TMP\n" +
                "\t\t\tWHERE\t CTA_CUENTA='99999'"
        count =0
        cnpys.eachRow(sql.toString()){r->
            count=r["num"]
        }
        if(count>0){
            mensaje= "Atención!!!,Existen clientes sin Código Contable, por favor actualícelos"
        }
        cnpys.execute("EXECUTE up_cuentas_facturas_vencidas '${fecha.format('MM-dd-yyyy')}' ")
        count = 0
        sql ="SELECT COUNT(CODIGO_CLIENTE) as num\n" +
                "\t\t\tFROM\t CUENTAS_ERROR_TMP"
        cnpys.eachRow(sql.toString()){r->
            count=r["num"]
        }
        if(count>0){
            mensaje =  " Atención!!!,Existen clientes sin Código Contable para Facturas Vencidas, por favor actualícelos"

        }
        cnpys.execute("EXECUTE up_conciliacion_debe_contable '${fecha.format('MM-dd-yyyy')}' ")
        if(mensaje=="")
            mensaje =  "Proceso de Conciliación Terminado con éxito"
        def res = datosComprobante_ajax(numeroComp,mes)
        def comprobante = res["comprobante"]
        def detalle = res["detalles"]
        [mensaje:mensaje,comprobante: comprobante,detalles: detalle]
    }
    def procesaIndustrias_ajax(){
        println "paramsi "+params
        def fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        def dia = fecha.format("dd")
        def mensaje=""
        if(dia.length()<2)
            dia="0"+dia
        def numeroComp = "0370"+dia
//        year(date(em_f_inicio.text))*100 + month(date(em_f_inicio.text))
        def mes = fecha.format("yyyy").toInteger()*100+(fecha.format("MM").toInteger())

        def sql = "SELECT COUNT(MES_CODIGO) num \n" +
                "\t\tFROM\t COMPROBANTE_MAESTRO\n" +
                "\t\tWHERE\t MES_CODIGO = ${mes} AND COM_NUMERO = ${numeroComp} " +
                "AND EMP_CODIGO = 'PS' AND COM_TIPO_CODIGO = 3 AND COM_TIPO_PROCESAMIENTO=1"

        def cn = new Sql(dataSource)
        def cnpys = new Sql(dataSource_pys)
        def count = 0
        cn.eachRow(sql.toString()){r->
            count=r["num"]
        }
        if(count>0){
            mensaje= "Información ya procesada "

        }
        cnpys.execute("EXECUTE up_clientes_timsa_concilia '${fecha.format('MM-dd-yyyy')}'")
        sql ="SELECT ISNULL(COUNT(CODIGO_CLIENTE),0) as num\n" +
                "\t\t\tFROM\t CUENTAS_ERROR_TMP\n" +
                "\t\t\tWHERE\t CTA_CUENTA='99999'"
        count =0
        cnpys.eachRow(sql.toString()){r->
            count=r["num"]
        }
        if(count>0){
            mensaje= "Atención!!!,Existen clientes sin Código Contable, por favor actualícelos"

        }

        cnpys.execute("EXECUTE up_debe_contable_timsa '${fecha.format('MM-dd-yyyy')}' ")
        if(mensaje=="")
            mensaje= "Proceso de Conciliación Terminado con éxito"
        def res = datosComprobante_ajax(numeroComp,mes)
        def comprobante = res["comprobante"]
        def detalle = res["detalles"]
        println "mensaje "+mensaje
        [mensaje:mensaje,comprobante: comprobante,detalles: detalle]
    }

    def datosComprobante_ajax(numero,mes){
        def comprobante = Comprobante.findAll("from Comprobante  where numero=${numero} and mes=${mes} and empresa='PS' and tipo=3")
        def detalles=[]
        println "comprobante "+comprobante
        println "numero "+numero+" mes "+mes
        if(comprobante.size()>0){
            comprobante=comprobante.pop()
            detalles = DetalleComprobante.findAll("from DetalleComprobante  where numero=${numero} and mes=${mes} and empresa='PS' and tipo=3")
        }
        println "detalles"+ detalles
        return [comprobante:comprobante,detalles:detalles]
    }

    def borrarDiario_ajax(){
        def fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        def dia = fecha.format("dd")

        if(dia.length()<2)
            dia="0"+dia
        def numeroComp=""
        if(params.tipo=="1"){
            numeroComp = "0330"+dia
        }else{
            numeroComp = "0370"+dia
        }

        def mes = fecha.format("yyyy").toInteger()*100+(fecha.format("MM").toInteger())
        def cn = new Sql(dataSource)
        def sql ="delete from COMPROBANTE_DETALLE where MES_CODIGO = ${mes} AND COM_NUMERO = ${numeroComp} \" +\n" +
                "                \"AND EMP_CODIGO = 'PS' AND COM_TIPO_CODIGO = 3 AND COM_TIPO_PROCESAMIENTO=1"
        sql ="delete from COMPROBANTE_MAESTRO where MES_CODIGO = ${mes} AND COM_NUMERO = ${numeroComp} \" +\n" +
                "                \"AND EMP_CODIGO = 'PS' AND COM_TIPO_CODIGO = 3 AND COM_TIPO_PROCESAMIENTO=1"
    }


}
