package contable.core.migra

import contable.seguridad.Shield
import groovy.sql.Sql

class FacturasController  extends Shield {

    def dataSource_pys

    def index() {
        [mensajes: params.mensajes]
    }

    def subirArchivo_ajax(){
        def cn = new Sql(dataSource_pys)
        def f = request.getFile('file')
        def mensajes = []
        mensajes.add("")
        def insertados = 0
        def numeroDePrecios = 0
        if(f && !f.empty){
//            println "delete "+ cn.execute("delete from PRECIO_TEMPORAL")
            def file =  File.createTempFile('temp', '.txt')
            f.transferTo(file)
            file.eachLine {
//                println "tam "+it.length()
                if(it.length()>14){
                    numeroDePrecios++
                    def condicion = it.substring(0,1)
                    def sitio = it.substring(1,3)
                    def ciudad = it.substring(3,5)
                    def numero = it.substring(5,13)
                    def numSri = it.substring(13,26)
                    def fechaVenta = it.substring(26,34)
                    fechaVenta=new Date().parse("yyyyMMdd",fechaVenta)
                    def moneda = it.substring(34,35)

                    def cliente = it.substring(35,43)
                    def ruc = it.substring(43,56)
                    def tipoCliente = it.substring(56,57)

                    def plazo = it.substring(57,60)
//                    println "cond "+condicion+" sitio "+sitio+" ciudad "+ciudad+" numero "+numero+" num sri "+numSri
//                    println "vence "+fechaVenta+" moneda "+moneda+" tipoCli "+tipoCliente+" plazo "+plazo
                    def tipoVenta = it.substring(60,61)
                    def codigoDependencia = it.substring(61,63)
                    def pagoFactura = it.substring(63,75)
                    pagoFactura=pagoFactura.toDouble()/100
                    def fechaSistema = it.substring(75,83)
                    fechaSistema=new Date().parse("yyyyMMdd",fechaSistema)
                    def horaSistema = it.substring(83,89)
//                    println "pago "+pagoFactura+" fechaS "+fechaSistema+"  hora "+horaSistema
                    def codigoTerminal = it.substring(89,93)
                    def codigoUsuario = it.substring(93,100)
                    def totalProvincia = it.substring(100,102)
                    def producto = it.substring(102,106)
                    def volumenVendido = it.substring(106,116)
                    volumenVendido=volumenVendido.toDouble()
                    if(sitio=='36' || sitio=='37'){
                        volumenVendido=volumenVendido/1000
                    }else{
                        volumenVendido=volumenVendido/100
                    }
                    def unidadMedida =  it.substring(116,118)
                    def precioTotal = it.substring(118,125).toDouble()
                    def sumaTotal = it.substring(125,137).toDouble()
                    def codigoPrecio = it.substring(137,143)
                    def interes = it.substring(143,155).toDouble()
                    interes=interes/100
                    def valorND = it.substring(155,167).toDouble()
                    valorND=valorND/100
                    def valorNC=it.substring(167,179).toDouble()
                    valorNC=valorNC/100
                    def vencimiento=it.substring(179,187)
//                    println "vencimiento "+vencimiento
                    vencimiento=new Date().parse("yyyyMMdd",vencimiento)
                    def nuermoAutorizacion = it.substring(187,it.length())
//                    println "numaut "+nuermoAutorizacion
                    def existe=false
                    def sql ="SELECT NUMERO_FACTURA\n" +
                            "\t\t\t\tFROM FACTURA\n" +
                            "\t\t\t\tWHERE NUMERO_FACTURA='${numero}'"
                    cn.eachRow(sql.toString()){r->
                        println "r "+r
                        existe=true
                    }
                    if(!existe){
                        sql ="INSERT INTO FACTURA (NUMERO_FACTURA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tNUMERO_FACTURA_SRI,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_CLIENTE,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_BANCO,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_CONDICION,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_MEDIDA,\t\t\t\t\t\t\t\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_MONEDA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_PRODUCTO,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_TERMINAL,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCODIGO_PRECIO,\n" +
                                "\t\t\t\t\t\t\t\t\t\tCIUDAD_FACTURA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tFECHA_VENTA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tTIPO_CLIENTE,\n" +
                                "\t\t\t\t\t\t\t\t\t\tPLAZO_VENTA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tTIPO_VENTA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tFECHA_SISTEMA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tHORA_SISTEMA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tVOLUMEN_VENTA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tPAGO_FACTURA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tEMPLEADO_CREA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tFECHA_CREA,\n" +
                                "\t\t\t\t\t\t\t\t\t\tRUC,\n" +
                                "\t\t\t\t\t\t\t\t\t\tVAL_INTERES,\n" +
                                "\t\t\t\t\t\t\t\t\t\tNC,\n" +
                                "\t\t\t\t\t\t\t\t\t\tND,\n" +
                                "\t\t\t\t\t\t\t\t\t\tFECHA_VENCIMIENTO,\n" +
                                "\t\t\t\t\t\t\t\t\t\tNUM_AUTO_SRI,\n" +
                                "\t\t\t\t\t\t\t\t\t\tEMISION_FACELEC,\n" +
                                "\t\t\t\t\t\t\t\t\t\tIVA_FACELEC)\n" +
                                "\t\t\t\n" +
                                "\t\t\t\t\t\t\tVALUES ( ${numero}, \n" +
                                "\t\t\t\t\t\t\t\t\t\t'${numSri}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${cliente}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${sitio}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${condicion}', \n" +
                                "\t\t\t\t\t\t\t\t\t\t'${unidadMedida}', \n" +
                                "\t\t\t\t\t\t\t\t\t\t'${moneda}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${producto}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${codigoDependencia}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${codigoPrecio}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${ciudad}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${fechaVenta.format('MM-dd-yyyy')}', \n" +
                                "\t\t\t\t\t\t\t\t\t\t'${tipoCliente}', \n" +
                                "\t\t\t\t\t\t\t\t\t\t${plazo}, \n" +
                                "\t\t\t\t\t\t\t\t\t\t${tipoVenta}, \n" +
                                "\t\t\t\t\t\t\t\t\t\t'${fechaSistema?.format('MM-dd-yyyy')}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${horaSistema}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t${volumenVendido},\n" +
                                "\t\t\t\t\t\t\t\t\t\t${pagoFactura},\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${session.usuario.login}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${new Date().format('MM-dd-yyyy')}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${ruc}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t${interes},\n" +
                                "\t\t\t\t\t\t\t\t\t\t${valorNC},\n" +
                                "\t\t\t\t\t\t\t\t\t\t${valorND},\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${vencimiento.format('MM-dd-yyyy')}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t'${nuermoAutorizacion}',\n" +
                                "\t\t\t\t\t\t\t\t\t\t0,\n" +
                                "\t\t\t\t\t\t\t\t\t\t0)"
                        println sql
                        if(cn.execute(sql.toString())==false){
                            insertados++
                        }
                    }else{
                        mensajes.add("El precio ${codigoPrecio} ya existe en la base de datos")
                    }

                }

            }

        }
        mensajes.add("Se insertarón ${insertados} de ${numeroDePrecios} registros ")
        redirect(action: "index",params: [mensajes:mensajes])
    }

    def resultado(){

    }
}
