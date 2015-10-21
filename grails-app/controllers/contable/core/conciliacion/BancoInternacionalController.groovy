package contable.core.conciliacion

import contable.seguridad.Shield
import groovy.sql.Sql

class BancoInternacionalController extends Shield {
    def dataSource_pys
    def index() {
        def mensajes = session.mensajes
        session.mensajes=null
        [mensajes: mensajes]
    }
    def subirArchivo_ajax(){
        def cn = new Sql(dataSource_pys)
        def f = request.getFile('file')
        def mensajes = []
        def insertados = 0
        def meses = ["ENE":"01","FEB":"02","MAR":"03","ABR":"04","MAY":"05","JUN":"06","JUL":"07","AGO":"08","SEP":"09","OCT":"10","NOV":"11","DIC":"12"]
        def numeroDeRegistros = 0
        if(f && !f.empty) {
//            println "delete "+ cn.execute("delete from PRECIO_TEMPORAL")
            def file = File.createTempFile('temp', '.txt')
            f.transferTo(file)
            file.eachLine {
                if(it.length()>105){
                    numeroDeRegistros++
                    def prueba1=it.substring(0,2).toDouble()
                    def fechaVenta=it.substring(0,11)
                    def numeroFactura=it.substring(55,63)
                    def pos =it.indexOf('$')
                    def  valor = it.substring(pos+1,pos+9)
                    valor = valor.replaceAll(",","")
                    valor=valor.toDouble()
                    def fechaAcreditacion=it.substring(84,95)
                    meses.each {m->
                        fechaAcreditacion=fechaAcreditacion.replaceAll(m.key,m.value)
                        fechaVenta=fechaVenta.replaceAll(m.key,m.value)
                    }
                    fechaAcreditacion=new Date().parse("dd/MM/yyyy",fechaAcreditacion)
                    fechaVenta=new Date().parse("dd/MM/yyyy",fechaVenta)
//                    println "prueba1 "+prueba1+" num "+numeroFactura+" fechaAc "+fechaAcreditacion+" valor "+valor

                    def sql ="SELECT CODIGO_CONDICION,FECHA_VENCIMIENTO\n" +
                            "\tFROM FACTURA\n" +
                            "\tWHERE NUMERO_FACTURA ='${numeroFactura}'"
                    def condicion
                    def fechaVence
//                    println "sql "+sql
                    cn.eachRow(sql.toString()){r->
//                        println "r "+r
                        condicion=r["CODIGO_CONDICION"]
                        fechaVence=r["FECHA_VENCIMIENTO"]
                    }
                    if(prueba1>0){

                        if(condicion=="1"){
                            def taza = 17.50
                            def dias=fechaVence-fechaAcreditacion
                            def pago = (valor*dias*(taza/100))/360
                            pago=pago.toDouble().round(2)
                            if(pago<0) {
                                pago = 0
                            }
                            sql ="SELECT NUMERO_FACTURA\n" +
                                    "\tFROM CONCILIACION\n" +
                                    "\tWHERE NUMERO_FACTURA ='${numeroFactura}'"
                            def existe=false
                            cn.eachRow(sql.toString()){r->
                                existe=true
                            }
                            if(!existe) {
                                sql = "INSERT INTO CONCILIACION(\n" +
                                        "\t\t\t\tNUMERO_FACTURA,\n" +
                                        "\t\t\t\tESTADO_CONCILIACION,\n" +
                                        "\t\t\t\tFECHA_ACREDITACION,\n" +
                                        "\t\t\t\tOPCION_CONCILIACION,\n" +
                                        "\t\t\t\tCONCILIA_BANCO,\n" +
                                        "\t\t\t\tFECHA_VENTA,\n" +
                                        "\t\t\t\tFECHA_VENCE,\n" +
                                        "\t\t\t\tDIAS_MORA,\n" +
                                        "\t\t\t\tTASA_INTERES,\n" +
                                        "\t\t\t\tVALOR_MORA)\n" +
                                        "\t\t\tVALUES ('${numeroFactura}',\n" +
                                        "\t\t\t\t'-1',\n" +
                                        "\t\t\t\t'${fechaAcreditacion.format('MM-dd-yyyy')}',\n" +
                                        "\t\t\t\t'BA',\n" +
                                        "\t\t\t\t'36',\n" +
                                        "\t\t\t\t'${fechaVenta?.format('MM-dd-yyyy')}',\n" +
                                        "\t\t\t\t'${fechaVence?.format('MM-dd-yyyy')}'," +
                                        "\t\t\t\t${dias}," +
                                        "\t\t\t\t${taza}," +
                                        "\t\t\t\t${pago})"
//                            println "insert  "+sql
                                if (cn.execute(sql.toString()) == false) {
                                    insertados++
                                } else {
                                    mensajes.add("Error al insertar la factura No.${numeroFactura}.")
                                }
                            }else{
                                mensajes.add("La factura No.${numeroFactura} ya está conciliada")
                            }
                        }else{
                            mensajes.add("La factura No.${numeroFactura} no está registrada en la base de datos")
                        }
                    }

                }
            }
        }
        mensajes.add("Se insertarón ${insertados} de ${numeroDeRegistros} registros ")
        session.mensajes=mensajes
        redirect(action: "index")
    }
}

