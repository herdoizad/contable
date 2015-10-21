package contable.core.conciliacion

import contable.seguridad.Shield
import groovy.sql.Sql

class ConciliacionController extends Shield {
    def dataSource_pys
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
        [fact:fact,bancos:bancos,fechaLista:params.fechaLista]
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


}
