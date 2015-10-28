package contable.core.conciliacion

import contable.seguridad.Shield
import groovy.sql.Sql

class BancoGuayaquilController extends Shield {
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
        def numeroDeRegistros = 0
        if(f && !f.empty) {
//            println "delete "+ cn.execute("delete from PRECIO_TEMPORAL")
            def file = File.createTempFile('temp', '.txt')
            f.transferTo(file)
            file.eachLine {
                if(it.length()>14){
                    numeroDeRegistros++
                    def prueba1=it.substring(0,5).toDouble()
                    def numeroFactura=it.substring(8,16)
                    def fechaAcreditacion=it.substring(27,35)
                    fechaAcreditacion=new Date().parse("yyyyMMdd",fechaAcreditacion)
//                    println "prueba1 "+prueba1+" num "+numeroFactura+" fechaAc "+fechaAcreditacion
                    def sql ="SELECT CODIGO_CONDICION,FECHA_VENCIMIENTO,FECHA_VENTA\n" +
                            "\tFROM FACTURA\n" +
                            "\tWHERE NUMERO_FACTURA ='${numeroFactura}'"
                    def condicion
                    def fechaVence
                    def fechaVenta
//                    println "sql "+sql
                    cn.eachRow(sql.toString()){r->
                        println "r "+r
                        condicion=r["CODIGO_CONDICION"]
                        fechaVence=r["FECHA_VENCIMIENTO"]
                        fechaVenta=r["FECHA_VENTA"]
                    }
                    if(prueba1>0){
                        if(condicion=="1"){
                            sql ="SELECT NUMERO_FACTURA\n" +
                                    "\tFROM CONCILIACION\n" +
                                    "\tWHERE NUMERO_FACTURA ='${numeroFactura}'"
                            def existe=false
                            cn.eachRow(sql.toString()){r->
                               existe=true
                            }
                            if(!existe){
                                sql="INSERT INTO CONCILIACION(\n" +
                                        "\t\t\t\tNUMERO_FACTURA,\n" +
                                        "\t\t\t\tESTADO_CONCILIACION,\n" +
                                        "\t\t\t\tFECHA_ACREDITACION,\n" +
                                        "\t\t\t\tOPCION_CONCILIACION,\n" +
                                        "\t\t\t\tCONCILIA_BANCO,\n" +
                                        "\t\t\t\tFECHA_VENTA,\n" +
                                        "\t\t\t\tFECHA_VENCE)\n" +
                                        "\t\t\tVALUES ('${numeroFactura}',\n" +
                                        "\t\t\t\t'-1',\n" +
                                        "\t\t\t\t'${fechaAcreditacion.format('MM-dd-yyyy')}',\n" +
                                        "\t\t\t\t'BA',\n" +
                                        "\t\t\t\t'37',\n" +
                                        "\t\t\t\t'${fechaVenta?.format('MM-dd-yyyy')}',\n" +
                                        "\t\t\t\t'${fechaVence?.format('MM-dd-yyyy')}')"
//                                println "insert  "+sql
                                if(cn.execute(sql.toString())==false){
                                    insertados++
                                }else {
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
