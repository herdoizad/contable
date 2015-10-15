package contable.core.migra

import contable.seguridad.Shield
import groovy.sql.Sql

class MigraController extends Shield {

    def dataSource_pys

    def index() {
        [mensajes: params.mensajes]
    }

    def subirArchivo_ajax(){
        def cn = new Sql(dataSource_pys)
        def f = request.getFile('file')
        def mensajes = []
        def insertados = 0
        def numeroDePrecios = 0
        if(f && !f.empty){
//            println "delete "+ cn.execute("delete from PRECIO_TEMPORAL")
            def file =  File.createTempFile('temp', '.txt')
            f.transferTo(file)
            file.eachLine {
                if(it.length()>14){
                    numeroDePrecios++
                    def codigoPrecio = it.substring(0,6)
                    def fecha = it.substring(6,14)
                    fecha=new Date().parse("yyyyMMdd",fecha)
                    def justificacion = it.substring(14,44)
                    def precio = it.substring(44,56).toDouble()/1000000
                    def precioTerminal = it.substring(56,68).toDouble()/1000000
                    def precios = []
                    14.times {num->
                        def incremento = num*13
                        def tmp = [:]
//                        println "empieza en "+(69+incremento)+"  acaba en "+(82+incremento)
                        tmp.put("operador",it.substring(68+incremento,69+incremento))
                        tmp.put("signo",it.substring(69+incremento,70+incremento))
                        tmp.put("precio",it.substring(70+incremento,81+incremento).toDouble()/1000000)
                        precios.add(tmp)
                    }
                    def validacion = precio-(precioTerminal+precios[1]["precio"]).toDouble().round(5)
                    if(validacion!=0){
//                        messagebox("Error !!!","El Precio Producto es diferente al PrecioTerminal + Margen, Código Precio: "+ls_codigo_precio,StopSign!)
                        mensajes.add("El Precio Producto es diferente al PrecioTerminal + Margen, Código Precio: ${codigoPrecio}")
                    }
                    validacion = (precios[7]["precio"]-precio*0.12).toDouble().round(5)
                    if(validacion!=0){
//                        El Precio Terminal mas el Margen es diferente al Precio 8 (IVA), Código Precio: "+ls_codigo_precio+char(13)+"Diferencia: "+string(lde_diferencia_pp_iva
                        mensajes.add("El Precio Terminal mas el Margen es diferente al Precio 8 (IVA), Código Precio: ${codigoPrecio} Diferencia: ${validacion}")
                    }
//                    def pvp = 0
//                    def sql ="SELECT DISTINCT PVP\n" +
//                            "\t\t\t\tFROM   PRECIO_VIGENTE\n" +
//                            "\t\t\t\tWHERE  PRECIO_PCO = ${precioTerminal} AND \n" +
//                            "\t\t\t\t       FECHA_FIN IS NULL AND \n" +
//                            "\t\t\t\t\t\t PVP <> 0"
//                    cn.eachRow(sql.toString()){r->
//                        pvp=r["PVP"]
//                    }
//                    def pvpMas5=pvp+(pvp*0.05)
//                    def pvpMenos5=pvp-(pvp*0.05)
//                    def ivaMenos = ((pvpMenos5/1.12)-(precio)*0.12).toDouble().round(5)
//                    def iva= ((pvp/1.12)-(precio)*0.12).toDouble().round(5)
//                    def ivaMas= ((pvpMas5/1.12)-(precio)*0.12).toDouble().round(5)

                    def sql = "SELECT CODIGO_PRECIO\n" +
                            "\t\t\t\tFROM   PRECIO\n" +
                            "\t\t\t\tWHERE  CODIGO_PRECIO='${codigoPrecio}'"
                    def existe=false
                    cn.eachRow(sql.toString()){r->
                        println "r "+r
                        existe=true
                    }
                    if(!existe){
                        sql = "INSERT INTO PRECIO (CODIGO_PRECIO,FECHA_PRECIO,JUSTIFICACION,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tPRETOT,PRECIO_TERMINAL,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR1,SIGNO1,PRECIO1,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR2,SIGNO2,PRECIO2,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR3,SIGNO3,PRECIO3,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR4,SIGNO4,PRECIO4,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR5,SIGNO5,PRECIO5,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR6,SIGNO6,PRECIO6,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR7,SIGNO7,PRECIO7,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR8,SIGNO8,PRECIO8,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR9,SIGNO9,PRECIO9,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR10,SIGNO10,PRECIO10,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR11,SIGNO11,PRECIO11,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR12,SIGNO12,PRECIO12,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR13,SIGNO13,PRECIO13,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tOPERADOR14,SIGNO14,PRECIO14,\n" +
                                "\t\t\t\t\t\t\t\t\t\t\tEMPLEADO_CREA,FECHA_CREA)\n" +
                                "\t\t\n" +
                                "\t\t\t\t\t\tVALUES ( '${codigoPrecio}','${fecha.format('MM-dd-yyyy')}', '${justificacion}',\n" +
                                "\t\t\t\t\t\t\t\t\t${precio},   ${precioTerminal},\n" +
                                "\t\t\t\t\t\t\t\t\t${precios[0]['operador']},'${precios[0]['signo']}',${precios[0]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[1]['operador']},'${precios[1]['signo']}',${precios[1]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[2]['operador']},'${precios[2]['signo']}',${precios[2]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[3]['operador']},'${precios[3]['signo']}',${precios[3]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[4]['operador']},'${precios[4]['signo']}',${precios[4]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[5]['operador']},'${precios[5]['signo']}',${precios[5]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[6]['operador']},'${precios[6]['signo']}',${precios[6]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[7]['operador']},'${precios[7]['signo']}',${precios[7]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[8]['operador']},'${precios[8]['signo']}',${precios[8]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[9]['operador']},'${precios[9]['signo']}',${precios[9]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[10]['operador']},'${precios[10]['signo']}',${precios[10]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[11]['operador']},'${precios[11]['signo']}',${precios[11]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[12]['operador']},'${precios[12]['signo']}',${precios[12]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t${precios[13]['operador']},'${precios[13]['signo']}',${precios[13]['precio']}, \n" +
                                "\t\t\t\t\t\t\t\t\t'${session.usuario.login}','${new Date().format('MM-dd-yyyy')}')"
                        if(cn.execute(sql.toString())==false){
                            insertados++
                        }
//                        println "error insert ? "+cn.execute(sql.toString())
                    }else{
                        mensajes.add("El precio ${codigoPrecio} ya existe en la base de datos")                    }

                }

            }

        }
        mensajes.add("Se insertarón ${insertados} de ${numeroDePrecios} registros ")
        redirect(action: "index",params: [mensajes:mensajes])
    }

    def resultado(){

    }
}
