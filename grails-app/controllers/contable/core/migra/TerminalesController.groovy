package contable.core.migra

import contable.seguridad.Shield
import groovy.sql.Sql

class TerminalesController extends Shield {

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
        mensajes.add("")
        def insertados = 0
        def numeroDeRegistros = 0
        if(f && !f.empty) {
//            println "delete "+ cn.execute("delete from PRECIO_TEMPORAL")
            def file = File.createTempFile('temp', '.txt')
            f.transferTo(file)
            file.eachLine {
                if (it.length() > 14) {
                    numeroDeRegistros++

                    def numeroOrden= it.substring(0,7)
                    def numeroFactura= it.substring(8,16)
                    def numeroGuia= it.substring(16,31)
                    def placa= it.substring(31,39)
                    def codigoComer= it.substring(39,43)
                    def estadoOrden= it.substring(43,44)
                    def codigoTerminal= it.substring(44,46)
                    def fechaEmision= it.substring(46,56)
                    fechaEmision=new Date().parse("dd/MM/yyyy",fechaEmision)
                    def fechaSistema= it.substring(56,66)
                    fechaSistema=new Date().parse("dd/MM/yyyy",fechaSistema)
                    def horaSistema= it.substring(66,71)
                    def codigoProducto= it.substring(71,75)
                    def codigoProd1= it.substring(2,4)
                    def unidadMedida= it.substring(75,77)
                    def volumenPedido= it.substring(77,86)
                    volumenPedido=volumenPedido.toDouble()/100
                    def volumenNatural= it.substring(86,95)
                    volumenNatural=volumenNatural.toDouble()/100
                    def factorConversion= it.substring(95,101)
                    factorConversion=factorConversion.toDouble()/100000
                    def numeroComprobante= it.substring(101,109)
                    def fechaDespacho= it.substring(109,119)
                    fechaDespacho=new Date().parse("dd/MM/yyyy",fechaDespacho)
                    def volumenCompra= it.substring(119,128)
                    volumenCompra=volumenCompra.toDouble()/100
                    def estadoDespacho= it.substring(128,129)
                    def volumenDespacho= it.substring(129,138)
                    volumenDespacho=volumenDespacho.toDouble()/100
                    def nombreBuque= it.substring(138,163)
                    def codigoDnh=""
                    def codigoPuerto=""
                    if(it.length()>189) {
                        codigoDnh= it.substring(163,188)
                        codigoPuerto= it.substring(188,190)
                    }
//                    println "num orden "+numeroOrden+" unidad  "+unidadMedida+" volpe "+volumenPedido+" fecha "+fechaSistema+" "+fechaEmision+" "+fechaDespacho
//                    println "volDes "+volumenDespacho+"  estado  "+estadoDespacho+"  "+numeroComprobante+" buque "+nombreBuque
//                    println "resto !"+it.substring(163,it.length()-1)+"!"
                    if(estadoOrden=="D"){
//                        println "despachado "
                        def sql ="SELECT NUMERO_ORDEN\n" +
                                "\t\t\t\t\t\tFROM   ORDEN_TERMINALES   \n" +
                                "\t\t\t\t\t\tWHERE  NUMERO_ORDEN = '${numeroOrden}'\n"
                        def codigoControl=null
                        cn.eachRow(sql.toString()){r->
                            println "r "+r["NUMERO_ORDEN"]
                            codigoControl=r["NUMERO_ORDEN"]

                        }

                        sql ="SELECT CODIGO_TERMINAL\n" +
                                " FROM   FACTURA\n" +
                                "  WHERE  NUMERO_FACTURA = '${numeroFactura}'"
                        def codigoControl1
                        cn.eachRow(sql.toString()){r->
                            println "r "+r["CODIGO_TERMINAL"]
                            codigoControl1=r["CODIGO_TERMINAL"]

                        }

//                        sql =" SELECT VOLUMEN_COMPROBANTE\n" +
//                                "  FROM   ORDEN_TEM_TERMINALES\n" +
//                                "  WHERE  NUMERO_ORDEN = ${numeroFactura}"
//                        def ldVolumen
//                        cn.eachRow(sql.toString()){r->
//                            println "r "+r["VOLUMEN_COMPROBANTE"]
//                            ldVolumen=r["VOLUMEN_COMPROBANTE"]
//                            existe=true
//                        }

                        sql ="SELECT VOLUMEN_VENTA,\n" +
                                " CODIGO_PRODUCTO\n" +
                                " FROM   FACTURA\n" +
                                " WHERE  NUMERO_FACTURA = '${numeroFactura}'"
                        def ldVolumen
                        def codProdAux
                        cn.eachRow(sql.toString()){r->
                            println "r "+r["VOLUMEN_VENTA"]
                            ldVolumen=r["VOLUMEN_VENTA"]
                            codProdAux=r["CODIGO_PRODUCTO"]

                        }
                        println "----------------------------------"
                        println "codigo control "+codigoControl
                        println "codigo control 1 "+codigoControl1
                        println "codigo terminal "+codigoTerminal
                        println "ld volumen "+ldVolumen
                        println "volumen despacho "+volumenDespacho
                        println "codigo producto "+codigoProducto
                        println "codigo producto aux "+codProdAux
                        println "----------------------------------"
                        if(codigoControl==null && codigoControl1==codigoTerminal && ldVolumen==volumenDespacho && codigoProducto==codProdAux){
//                            println "paso el if"
                            sql ="INSERT INTO ORDEN_TERMINALES ( NUMERO_ORDEN, \n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tNUMERO_FACTURA,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tNUMERO_FACTURA_SRI,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tPLACA_AUTOTANQUE,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tCODIGO_COMERCIAL,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tESTADO_ORDEN,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tCODIGO_TERMINAL,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tFECHA_EMISION,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tFECHA_SISTEMA,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tHORA_SISTEMA,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tCODIGO_PRODUCTO,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tCODIGO_MEDIDA,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tVOLUMEN_PEDIDO,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tVOLUMEN_NATURAL,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tFACTOR_CONVERSION,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tNUMERO_COMPROBANTE,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tFECHA_COMPROBANTE,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tVOLUMEN_COMPROBANTE,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tESTADO_DESPACHO,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tVOLUMEN_DESPACHADO,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tEMPLEADO_CREA,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tFECHA_CREA,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tNOMBRE_BUQUE_TANQUE,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tCODIGO_DNH,\n" +
                                    "\t\t\t\t\t\t\t\t\t\t\t\t\t\tCODIGO_PUERTO)\n" +
                                    "\t\t\t\t\t\n" +
                                    "\t\t\t\t\t\t\tVALUES ('${numeroOrden}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${numeroFactura}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${numeroGuia}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${placa}', \n" +
                                    "\t\t\t\t\t\t\t\t\t'${codigoComer}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${estadoOrden}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${codigoTerminal}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${fechaEmision.format('MM-dd-yyyy')}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${fechaSistema.format('MM-dd-yyyy')}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${horaSistema}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${codigoProducto}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${unidadMedida}',\n" +
                                    "\t\t\t\t\t\t\t\t\t${volumenPedido},\n" +
                                    "\t\t\t\t\t\t\t\t\t${volumenNatural},\n" +
                                    "\t\t\t\t\t\t\t\t\t${factorConversion},\n" +
                                    "\t\t\t\t\t\t\t\t\t'${numeroComprobante}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${fechaDespacho.format('MM-dd-yyyy')}',\n" +
                                    "\t\t\t\t\t\t\t\t\t ${volumenCompra},\n" +
                                    "\t\t\t\t\t\t\t\t\t'${estadoDespacho}',\n" +
                                    "\t\t\t\t\t\t\t\t\t${volumenDespacho},\n" +
                                    "\t\t\t\t\t\t\t\t\t'${session.usuario.login}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${new Date().format('MM-dd-yyyy')}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${nombreBuque}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${codigoDnh}',\n" +
                                    "\t\t\t\t\t\t\t\t\t'${codigoPuerto}')"
                            try{
                                if(cn.execute(sql.toString())==false){
                                    insertados++
                                }
                            }catch (e){
                                mensajes.add("No se pudo insertar la orden No. "+numeroOrden+". "+e.message)
                            }

                        }else{
                            mensajes.add("La orden No. ${numeroOrden} ya existe en la base de datos. Error de validación")
                        }
                    }

                }
            }
        }
        mensajes.add("Se insertarón ${insertados} de ${numeroDeRegistros} registros ")
        session.mensajes=mensajes
        redirect(action: "index")
        return
    }
}
