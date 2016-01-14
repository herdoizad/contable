package contable.core

import contable.seguridad.Shield

class ComprobantesController extends Shield {
    def mailService
    def diarios(){
        def meses = ["Enero":"01","Febrero":"02","Marzo":"03","Abril":"04","Mayo":"05","Junio":"06","Juilo":"07","Agosto":"08","Septiembre":"09","Octubre":"10","Noviembre":"11","Diciembre":"12"]
        def anio = session.empresa.anio //new Date().format("yyyy")
        def inicio = Comprobante.findAllByMesAndEmpresa((anio+"00").toInteger(),session.empresa)
        [anio:anio,meses:meses,inicio:inicio,mes:params.mes,numero:params.numero]
    }


    def ingresos(){
        //def empresa = Empresa.findAllByCodigo(session.empresa.codigo)
        def meses = ["Enero":"01","Febrero":"02","Marzo":"03","Abril":"04","Mayo":"05","Junio":"06","Juilo":"07","Agosto":"08","Septiembre":"09","Octubre":"10","Noviembre":"11","Diciembre":"12"]
        def anio = session.empresa.anio //new Date().format("yyyy")
        [anio:anio,meses:meses,mes:params.mes,numero:params.numero]
    }

    def egresos(){
        //def empresa = Empresa.findAllByCodigo(session.empresa.codigo)
        def meses = ["Enero":"01","Febrero":"02","Marzo":"03","Abril":"04","Mayo":"05","Junio":"06","Juilo":"07","Agosto":"08","Septiembre":"09","Octubre":"10","Noviembre":"11","Diciembre":"12"]
        def anio = session.empresa.anio //new Date().format("yyyy")
        [anio:anio,meses:meses,mes:params.mes,numero:params.numero]
    }

    def getComprobantesMes_ajax(){
        def anio = session.empresa.anio //new Date().format("yyyy")
        println "anio " + anio
        def comps = Comprobante.findAll("from Comprobante where mes=${(anio+params.mes).toInteger()} and empresa='${session.empresa.codigo}' and tipo=${params.tipo} order by fecha desc ,numero asc")
        println "from Comprobante where mes=${(anio+params.mes).toInteger()} and empresa='${session.empresa.codigo}' and tipo=${params.tipo} order by fecha desc ,numero asc"
        def mes = Mes.findByCodigo((anio+params.mes).toInteger())
        def editable = Empresa.findByCodigo(session.empresa.codigo)?.editable
        [anio:anio,comps:comps,numero: params.numero,mes:params.mes,mesObj:mes,editable:editable]
    }

    def getDetalle_ajax(){
//        println "params "+params
        def  com = Comprobante.findAll("from Comprobante where empresa='${params.empresa}' and numero=${params.numero} and tipo=${params.tipo} and mes=${params.mes}")
//        println "comp "+com
        def detalles = DetalleComprobante.findAll("from DetalleComprobante where empresa='${params.empresa}' and numero=${params.numero} and tipo=${params.tipo} and mes=${params.mes}")
        if(com.size()>0)
            com=com.pop()
        def ing = null
        if(com.tipo==1){
            ing = Ingreso.findAll("from Ingreso where empresa='${params.empresa}' and numero=${params.numero} and tipo=${params.tipo} and mes=${params.mes}")
            if(ing.size()>0)
                ing=ing.pop()
        }
        [detalles:detalles,com:com,ing:ing]
    }

    def anular_ajax(){
        println "params "+params
        //def  com = Comprobante.findAll("from Comprobante where empresa='${params.empresa}' and numero=${params.numero} and tipo=${params.tipo} and mes=${params.mes}")
        def detalles = DetalleComprobante.findAll("from DetalleComprobante where empresa='${params.empresa}' and numero=${params.numero} and tipo=${params.tipo} and mes=${params.mes}")
        def band = true
        detalles.each {
            if(band) {
                it.valor = 0
                it.ipMod=session.ip
                it.usuario=session.ip
                if (!it.save(flush: true)) {
                    println "error save detalle comprobante " + it.errors
                    band = false
                }
            }
        }
        if(band)
            render "ok"
        else
            render "error"
    }

    def nuevoCash(){
        def mesSolo = params.mes
        def anio = session.empresa.anio
        def mes
        if(params.mes.size()==2)
            mes =""+anio+params.mes
        else
            mes=params.mes
        def mesObj = Mes.findByCodigo(mes.toInteger())
        if(mesObj.estado=="C") {
            flash.message="El mes ${mesObj.descripcion} está cerrado"
            response.sendError(403)
        }
        def tipoString
        switch (params.tipo){
            case "1":
                tipoString="Ingreso"
                break;
            case "2":
                tipoString="Egreso"
                break;
            case "3":
                tipoString="Diario"
                break;
            case "4":
                tipoString="Ajuste"
                break;

        }

        def inicio = new Date().parse("yyyyMMdd",mes+"01")
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, anio.toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
        def fin  = cal.getTime();
        def comp = null
        def detalles = []
        def rets = []
        def cheque = null
        def cliente=null
//        println "inicio "+inicio
        def ultimo = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and numero>${inicio.format('yy')+'0000'} and tipoProcesamiento=4 order by numero desc",["max":1])
//        println "ultimo "+ultimo.numero
        def siguiente=(""+inicio.format("yy")+"0001").toInteger()
        if(ultimo.size()>0) {
            ultimo = ultimo.pop()
            siguiente=ultimo.numero+1
        }
        if(params.numero) {
            comp=Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes}and numero=${params.numero} order by numero desc",["max":1])
            if(comp.size()>0) {
                comp = comp.pop()
                siguiente=comp.numero
                detalles = DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                rets = DetalleFacturaEgresos.findAll("from DetalleFacturaEgresos where empresa='${comp.empresa.codigo}' and comprobante=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                cheque = Cheque.findAll("from Cheque where empresa='${comp.empresa.codigo}' and comprobante=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                if(cheque.size()>0) {
                    cheque = cheque.pop()
                    cliente=Cliente.findByCp(cheque.beneficiario)
                }else
                    cheque=null
            }else
                comp=null
        }
        def tipos = ["01":"Ahorros","00":"Corriente"]
        def tiposRet = Tabla.findAllByPadre("PS01")
        def tipoIva = Tabla.findAllByPadre("PS02")
        def tipoComp = TipoDocumento.findAllByDescripcionNotEqual("----------")
        def cuentas = Cuenta.findAllByAgrupa(1)
        def clientes = Cliente.list([sort: 'cp'])
        cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_MONTH, new Date().format("dd").toInteger());
        cal.set(Calendar.YEAR,new Date().format("yyyy").toInteger())
        def fecha = cal.getTime()
        if(fecha>fin)
            fecha=fin
//        println "fecha2 "+fecha+"  fin "+fin+"  inicio "+inicio
        [mes:mes,mesSolo:mesSolo,tipo:params.tipo,tipoString:tipoString,siguiente:siguiente,inicio: inicio,fin:fin,tipos:tipos,tiposRet:tiposRet,tipoIva:tipoIva,tipoComp:tipoComp,cuentas:cuentas,clientes:clientes,comp:comp,cheque:cheque,detalles:detalles,rets:rets,cliente:cliente,fecha:fecha]
    }


    def nuevo(){
        def mesSolo = params.mes
        def anio = session.empresa.anio
        def mes
        if(params.mes.size()==2)
            mes =""+anio+params.mes
        else
            mes=params.mes
        def mesObj = Mes.findByCodigo(mes.toInteger())
        if(mesObj.estado=="C") {
            flash.message="El mes ${mesObj.descripcion} está cerrado"
            response.sendError(403)
        }
        def tipoString
        switch (params.tipo){
            case "1":
                tipoString="Ingreso"
                break;
            case "2":
                tipoString="Egreso"
                break;
            case "3":
                tipoString="Diario"
                break;
            case "4":
                tipoString="Ajuste"
                break;

        }
        def ultimo = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and tipoProcesamiento=2 order by numero desc",["max":1])
        def siguiente=1
        if(ultimo.size()>0) {
            ultimo = ultimo.pop()
            siguiente=ultimo.numero+1
        }
        def inicio = new Date().parse("yyyyMMdd",mes+"01")
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, anio.toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
        def fin  = cal.getTime();
        def comp = null
        def detalles = []
        if(params.numero) {
            comp=Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes}and numero=${params.numero} order by numero desc",["max":1])
            if(comp.size()>0) {
                comp = comp.pop()
                siguiente=comp.numero
                detalles = DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${params.numero} and tipo=${params.tipo} and mes=${mes}")
            }else
                comp=null
        }
//        println "inicio "+inicio+"  fin "+fin
        [mes:mes,mesSolo:mesSolo,tipo:params.tipo,tipoString:tipoString,siguiente:siguiente,inicio: inicio,fin:fin,comp:comp,detalles: detalles]
    }


    def nuevoEgreso(){
        def mesSolo = params.mes
        def anio = session.empresa.anio
        def mes
        if(params.mes.size()==2)
            mes =""+anio+params.mes
        else
            mes=params.mes
        def mesObj = Mes.findByCodigo(mes.toInteger())
        if(mesObj.estado=="C") {
            flash.message="El mes ${mesObj.descripcion} está cerrado"
            response.sendError(403)
        }
        def tipoString
        switch (params.tipo){
            case "1":
                tipoString="Ingreso"
                break;
            case "2":
                tipoString="Egreso"
                break;
            case "3":
                tipoString="Diario"
                break;
            case "4":
                tipoString="Ajuste"
                break;

        }
        def ultimo = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and tipoProcesamiento=2 order by numero desc",["max":1])
        def siguiente=1
        def siguiente2=1
        if(ultimo.size()>0) {
            ultimo = ultimo.pop()
            siguiente=ultimo.numero+1
        }
        def inicio = new Date().parse("yyyyMMdd",mes+"01")
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, anio.toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
        def fin  = cal.getTime();
        def comp = null
        def detalles = []
        def rets = []
        def cheque = null
        def cliente=null

        if(params.numero) {
            comp=Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes}and numero=${params.numero} order by numero desc",["max":1])
            if(comp.size()>0) {
                comp = comp.pop()
                siguiente=comp.numero
                detalles = DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                rets = DetalleFacturaEgresos.findAll("from DetalleFacturaEgresos where empresa='${comp.empresa.codigo}' and comprobante=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                cheque = Cheque.findAll("from Cheque where empresa='${comp.empresa.codigo}' and comprobante=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                if(cheque.size()>0) {
                    cheque = cheque.pop()
                    cliente=Cliente.findByCp(cheque.beneficiario)
                }else
                    cheque=null
            }else
                comp=null
        }
        def tipos = [2:"Manual",1:"Automático"]
        def tiposRet = Tabla.findAllByPadre("PS01")
        def tipoIva = Tabla.findAllByPadre("PS02")
        def tipoComp = TipoDocumento.findAllByDescripcionNotEqual("----------")
        def cuentas = Cuenta.findAllByAgrupa(1)
        def clientes = Cliente.list([sort: 'nombre'])
        [mes:mes,mesSolo:mesSolo,tipo:params.tipo,tipoString:tipoString,siguiente:siguiente,inicio: inicio,fin:fin,tipos:tipos,tiposRet:tiposRet,tipoIva:tipoIva,tipoComp:tipoComp,cuentas:cuentas,clientes:clientes,comp:comp,cheque:cheque,detalles:detalles,rets:rets,cliente:cliente]
    }

    def nuevoIngreso(){
        def mesSolo = params.mes
        def anio = session.empresa.anio
        def mes
        if(params.mes.size()==2)
            mes =""+anio+params.mes
        else
            mes=params.mes
        def mesObj = Mes.findByCodigo(mes.toInteger())
        if(mesObj.estado=="C") {
            flash.message="El mes ${mesObj.descripcion} está cerrado"
            response.sendError(403)
        }
        def tipoString
        switch (params.tipo){
            case "1":
                tipoString="Ingreso"
                break;
            case "2":
                tipoString="Egreso"
                break;
            case "3":
                tipoString="Diario"
                break;
            case "4":
                tipoString="Ajuste"
                break;

        }
        def ultimo = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and tipoProcesamiento=2 order by numero desc",["max":1])
        def siguiente=1
        def siguiente2=1
        if(ultimo.size()>0) {
            ultimo = ultimo.pop()
            siguiente=ultimo.numero+1
        }
        def comp = null
        def detalles = []
        def ingreso = null
        if(params.numero) {
            comp=Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes}and numero=${params.numero} order by numero desc",["max":1])
            if(comp.size()>0) {
                comp = comp.pop()
                siguiente=comp.numero
                detalles = DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                ingreso = Ingreso.findAll("from Ingreso where empresa='${comp.empresa.codigo}' and numero=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                if(ingreso.size()>0)
                    ingreso=ingreso.pop()
                else
                    ingreso=null
            }else
                comp=null
        }
        def inicio = new Date().parse("yyyyMMdd",mes+"01")
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, anio.toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
        def fin  = cal.getTime();
//        println "inicio "+inicio+"  fin "+fin
        [mes:mes,mesSolo:mesSolo,tipo:params.tipo,tipoString:tipoString,siguiente:siguiente,inicio: inicio,fin:fin,comp:comp,detalles: detalles,ingreso:ingreso]
    }

    def save(){
        println "params !! "+params
        def mes = params.mes.toInteger()
        def ultimo = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and tipoProcesamiento=2 order by numero desc",["max":1])
        def numero =1
        def sendMail=false
        if(ultimo.size()>0) {
            ultimo = ultimo.pop()
            numero=ultimo.numero+1
        }
        def comp=[]
        if(params.numero){
            comp=Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and numero=${params.numero} order by numero desc",["max":1])
        }
        if(comp.size()>0) {
            sendMail=true
            comp = comp.pop()
            numero = comp.numero
            DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${numero} and tipo=${params.tipo} and mes=${mes}").each {d->
                d.delete(flush: true)
            }
        }else{
            comp = new Comprobante()
        }
        comp.mes=mes
        comp.numero=numero
        comp.empresa=session.empresa
        comp.tipo=params.tipo.toInteger()
        comp.concepto=params.concepto
        comp.fecha=new Date().parse("dd-MM-yyyy",params.fecha_input)
        comp.usuario=session.usuario.login
        println "ip "+session.ip
        comp.ipMod = session.ip
        comp.control=9
        comp.tipoProcesamiento=2
        if(!comp.save(flush: true))
            println "error save comp "+comp.errors
        else{
            if(comp.tipo==1){
                println "es ingreso "
                try{
                    params.efectivo=params.efectivo.toDouble()
                }catch (e){
                    params.efectivo=0
                }
                try{
                    params.cheques=params.cheques.toDouble()
                }catch (e){
                    params.cheques=0
                }
                try{
                    params.notas=params.notas.toDouble()
                }catch (e){
                    params.notas=0
                }
                def ingreso = []
                if(params.numero)
                    ingreso = Ingreso.findAll("from Ingreso where empresa='${comp.empresa.codigo}' and numero=${params.numero} and tipo=${params.tipo} and mes=${mes}")
                if(ingreso.size()>0)
                    ingreso=ingreso.pop()
                else
                    ingreso= new Ingreso()
                ingreso.tipo=1
                ingreso.numero=comp.numero
                ingreso.empresa=comp.empresa
                ingreso.mes=comp.mes
                ingreso.recibi=params.recibi
                ingreso.efectivo=params.efectivo
                ingreso.cheques=params.cheques
                ingreso.notas=params.notas
                ingreso.total=(ingreso.efectivo+ingreso.cheques+ingreso.notas).round(2)
                ingreso.usuario=comp.usuario
                if(!ingreso.save(flush: true)){
                    println "error save ingreso "+ingreso.errors
                }
            }
            def data = params.data.split("\\|")
            // println "data "+data
            data.each {d->
                if(d!=""){
                    def parts = d.split(";")
                    //println "parts "+parts
                    def det = new DetalleComprobante()
                    def valor = 0
                    det.numero=numero
                    det.empresa=session.empresa
                    det.tipo=params.tipo.toInteger()
                    det.mes=mes
                    def cuenta =  Cuenta.findByNumeroAndEmpresa(parts[1],session.empresa)
                    det.cuenta = cuenta
                    if(parts[4].size()>35)
                        parts[4]=parts[4][1..33]
                    det.descripcion=parts[4].toUpperCase()
                    if(parts[2].toDouble()>0){
                        valor=parts[2].toDouble()
                        det.signo=1
                    }else{
                        valor=parts[3].toDouble()
                        det.signo=-1
                    }
                    det.valor=valor
                    det.creacion=new Date()
                    det.secuencial=parts[0].toDouble()
                    det.usuario = session.usuario.login
                    det.ipMod=session.ip
//                    println "cuenta "+det.cuenta+"  "+det.valor+"  "+det.tipo
                    if(!det.save(flush: true))
                        println "error save det "+det.errors
                }
            }
            if(sendMail){
                def email = "ana.duque@petroleosyservicios.com"
                def det = DetalleComprobante.findAll("from DetalleComprobante  where mes=${comp.mes} " +
                        "and numero=${comp.numero} " +
                        "and tipo=${comp.tipo} " +
                        "and empresa='${session.empresa.codigo}'")
                mailService.sendMail {
                    multipart true
                    to email
                    subject "[CONTABLE]Edición de comprobante resultado final"
                    body( view:"mailComprobanteFinal",
                            model:[comp:comp,detalle:det,genera:session.usuario.login])
                    inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
                }
            }

        }
        switch (comp.tipo){
            case 1:
                redirect(action:"nuevoIngreso",params:[mes:comp.fecha.format("MM"),tipo: 1])
                return
                break;
            case 2:
                redirect(action:"nuevoEgreso",params:[mes:comp.fecha.format("MM"),tipo: 2])
                return
                break;
            case 3:

                redirect(action:"nuevo",params:[mes:comp.fecha.format("MM"),tipo:3])
                return
                break;


        }

    }

    def saveEgreso(){
        println "params "+params
        def mes = params.mes.toInteger()
        def ultimo = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and tipoProcesamiento=2 order by numero desc",["max":1])
        def numero =1
        def cq = null
        if(ultimo.size()>0) {
            ultimo = ultimo.pop()
            numero=ultimo.numero+1
        }
        def comp = []
        if(params.numero)
            comp=Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and numero=${params.numero} order by numero desc",["max":1])
        if(comp.size()>0) {
            comp = comp.pop()
            numero = comp.numero
            DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${numero} and tipo=${params.tipo} and mes=${mes}").each {d->
                d.delete(flush: true)
            }
            DetalleFacturaEgresos.findAll("from DetalleFacturaEgresos where empresa='${comp.empresa.codigo}' and comprobante=${params.numero} and tipo=${params.tipo} and mes=${mes}").each {
                it.delete(flush: true)
            }
        }else{
            comp = new Comprobante()
        }
        comp.mes=mes
        comp.numero=numero
        comp.empresa=session.empresa
        comp.tipo=params.tipo.toInteger()
        comp.concepto=params.concepto
        comp.fecha=new Date().parse("dd-MM-yyyy",params.fecha_input)
        comp.usuario=session.usuario.login
        println "ip "+session.ip
        comp.ipMod=session.ip
        comp.control=9
        comp.tipoProcesamiento=params.tipoEgreso.toInteger()
        if(comp.tipoProcesamiento==1)
            comp.numero=params.numero.toDouble()
        if(!comp.save(flush: true))
            println "error save comp "+comp.errors
        else{


            def banco =  Banco.findByCodigoAndEmpresa(params.cheque.banco,session.empresa)
            def cliente = Cliente.findByCodigoAndEmpresa(params.cheque.cliente,session.empresa)
            def cheque = []
            if(params.numero)
                cheque = Cheque.findAll("from Cheque where empresa='${comp.empresa.codigo}' and comprobante=${params.numero} and tipo=${params.tipo} and mes=${mes}")
            if(cheque.size()>0)
                cheque=cheque.pop()
            else {
                cheque = new Cheque()
                banco.ultimoCheque=banco.ultimoCheque+1
                cheque.numero=banco.ultimoCheque.toInteger()

                if(!banco.save(flush: true))
                    println "error update banco "+banco.errors

            }
            cheque.empresa=comp.empresa
            cheque.tipo=comp.tipo
            cheque.mes=comp.mes
            cheque.comprobante = comp.numero
            cheque.banco =banco
            cheque.beneficiario =cliente.cp
            cheque.cuenta=banco.numero.trim()
            cheque.emision=new Date().parse("dd-MM-yyyy",params.chequefecha_input)
            cheque.usuario=comp.usuario
            cheque.codigoBeneficiario=cliente.codigo
            session.cheque=cheque
            cheque.valor=params.cheque.valor.toDouble()
            if(!cheque.save(flush: true)){
                println "error save cliente "+cheque.errors
            }
            def data = params.data2.split("W")
            def cont = 1
            data.each {d->
                if(d!=""){
                    def parts = d.split(";")
                    println "parts d2 "+parts
                    def det = new DetalleFacturaEgresos()
                    det.empresa=comp.empresa
                    det.usuario=comp.usuario
                    det.creacion=new Date()
                    det.comprobante=comp.numero
                    det.tipo=comp.tipo
                    det.mes=comp.mes
                    det.tipoDocumento=TipoDocumento.findByCodigo(parts[0].toInteger())
                    det.numeroFactura=parts[1]
                    if(parts[2]!="")
                        det.fechaDocumento=new Date().parse("dd-MM-yyyy",parts[2])
                    det.valor=parts[3].toDouble()
                    det.secuencialRetencion=cont
                    cont++
                    if(parts[4]!="" && parts[4]!=" " ){
                        det.tipoRetencion=parts[4]
                        det.retencion=parts[5].toDouble()
                    }else{
                        det.retencion=0
                    }
                    if(parts[6]!="" && parts[6]!=" " ){
                        det.tipoIva=parts[6]
                        if(parts[8]=="1"){
                            det.valorIva=parts[7].toDouble()
                            det.retencionIva = 1
                        }else{
                            det.valorIva=0
                            det.retencionIva=0
                        }
                    }else{
                        det.valorIva=0
                        det.retencionIva=0
                    }
                    det.pagar=parts[9].toDouble()

                    if(!det.save(flush: true)){
                        println "error save det "+det.errors
                    }
                }
            }


            data = params.data.split("\\|")
            cont=1
            // println "data "+data
            data.each {d->
                if(d!=""){
                    def parts = d.split(";")
                    //println "parts "+parts
                    def det = new DetalleComprobante()
                    def valor = 0
                    det.numero=comp.numero
                    det.empresa=session.empresa
                    det.tipo=params.tipo.toInteger()
                    det.mes=mes
                    def cuenta =  Cuenta.findByNumeroAndEmpresa(parts[1],session.empresa)
                    det.cuenta = cuenta
                    if(parts[4].size()>35)
                        parts[4]=parts[4][1..33]
                    det.descripcion=parts[4].toUpperCase()
                    if(parts[2].toDouble()>0){
                        valor=parts[2].toDouble()
                        det.signo=1
                    }else{
                        valor=parts[3].toDouble()
                        det.signo=-1
                    }
                    det.valor=valor
                    det.creacion=new Date()
                    det.secuencial=cont
                    cont++
                    det.usuario = session.usuario.login
                    det.ipMod=session.ip
//                    println "cuenta "+det.cuenta+"  "+det.valor+"  "+det.tipo
                    if(!det.save(flush: true))
                        println "error save det "+det.errors
                }
            }
        }
        session.comprobante=comp

        redirect(action: "showEgreso")
    }


    def saveCash(){
        println "params "+params
        def mes = params.mes.toInteger()
        def inicio = new Date().parse("yyyyMMdd",mes+"01")
        def ultimo = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and tipoProcesamiento=4 and mes>=201510 order by numero desc",["max":1])
        def numero=(""+inicio.format("yy")+"0001").toInteger()
        if(ultimo.size()>0) {
            ultimo = ultimo.pop()
            numero=ultimo.numero+1
        }
        def comp
        comp=Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and tipo=${params.tipo} and mes=${mes} and numero=${params.numero} order by numero desc",["max":1])
        if(comp.size()>0) {
            comp = comp.pop()
            numero = comp.numero
            DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${numero} and tipo=${params.tipo} and mes=${mes}").each {d->
                // d.delete(flush: true)
            }
            DetalleFacturaEgresos.findAll("from DetalleFacturaEgresos where empresa='${comp.empresa.codigo}' and comprobante=${params.numero} and tipo=${params.tipo} and mes=${mes}").each {
                //it.delete(flush: true)
            }
        }else{
            comp = new Comprobante()
        }
        comp.mes=mes
        comp.numero=numero
        comp.empresa=session.empresa
        comp.tipo=params.tipo.toInteger()
        comp.concepto=params.concepto
        comp.fecha=new Date().parse("dd-MM-yyyy",params.fecha_input)
        comp.usuario=session.usuario.login
        comp.ipMod=session.ip
        comp.control=9
        comp.numeroCheque=0
        comp.revisaAuditoria=0
        comp.bancoCliente=BancoOcp.findByCodigo(params.bancoCliente)
        comp.cuentaTransferencia=params.cuentaTransferencia
        comp.tipoCuenta=params.tipoCuenta
        comp.tipoProcesamiento=4

        if(!comp.save(flush: true)) {
            println "error save comp " + comp.errors
        }else{
            def banco =  Banco.findByCodigoAndEmpresa(params.cheque.banco,session.empresa)
            def cliente = Cliente.findByCodigoAndEmpresa(params.cheque.cliente,session.empresa)
            if(!cliente.numeroCuenta || cliente.numeroCuenta==""){
                cliente.banco=BancoOcp.findByCodigo(params.bancoCliente)
                cliente.tipoCuenta=params.tipoCuenta
                cliente.numeroCuenta=params.cuentaTransferencia
                cliente.save(flush: true)
            }
            def cheque
            cheque = new Cheque()
            banco.ultimoCheque=banco.ultimoCheque+1
            cheque.numero=banco.ultimoCheque.toInteger()
            println "cheque "+cheque.numero
            cheque.empresa=comp.empresa
            cheque.tipo=comp.tipo
            cheque.mes=comp.mes
            cheque.comprobante = comp.numero
            cheque.banco =banco
            cheque.beneficiario =cliente.cp
            cheque.cuenta=banco.numero.trim()
            cheque.emision=new Date().parse("dd-MM-yyyy",params.chequefecha_input)
            cheque.usuario=comp.usuario
            cheque.codigoBeneficiario=cliente.codigo
            cheque.valor=params.cheque.valor.toDouble()
            if(!cheque.save(flush: true)){
                println "error save cheque!!!!!!!! "+cheque.errors
                mailService.sendMail {
                    multipart true
                    to "david.herdoiza@petroleosyservicios.com"
//                    to "pys@petroleosyservicios.com"
                    subject "[CONTABLE]Error al guardar el cheque"
                    body ""+cheque.errors
                    inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
                }
            }else{
                if(!banco.save(flush: true))
                    println "error update banco "+banco.errors
                session.cheque=cheque
            }
            def data = params.data2.split("W")
            def cont = 1
            data.each {d->
                if(d!=""){
                    def parts = d.split(";")
                    println "parts d2 "+parts
                    def det = new DetalleFacturaEgresos()
                    det.empresa=comp.empresa
                    det.usuario=comp.usuario
                    det.creacion=new Date()
                    det.comprobante=comp.numero
                    det.tipo=comp.tipo
                    det.mes=comp.mes
                    det.tipoDocumento=TipoDocumento.findByCodigo(parts[0].toInteger())
                    det.numeroFactura=parts[1]
                    if(parts[2]!="")
                        det.fechaDocumento=new Date().parse("dd-MM-yyyy",parts[2])
                    det.valor=parts[3].toDouble()
                    det.secuencialRetencion=cont
                    cont++
                    if(parts[4]!="" && parts[4]!=" " ){
                        det.tipoRetencion=parts[4]
                        det.retencion=parts[5].toDouble()
                    }else{
                        det.retencion=0
                    }
                    if(parts[6]!="" && parts[6]!=" " ){
                        det.tipoIva=parts[6]
                        if(parts[8]=="1"){
                            det.valorIva=parts[7].toDouble()
                            det.retencionIva = 1
                        }else{
                            det.valorIva=0
                            det.retencionIva=0
                        }
                    }else{
                        det.valorIva=0
                        det.retencionIva=0
                    }
                    det.pagar=parts[9].toDouble()
                    if(!det.save(flush: true)){
                        println "error save det "+det.errors
                    }
                }
            }


            data = params.data.split("\\|")
            cont=1
            // println "data "+data
            data.each {d->
                if(d!=""){
                    def parts = d.split(";")
                    //println "parts "+parts
                    def det = new DetalleComprobante()
                    def valor = 0
                    det.numero=comp.numero
                    det.empresa=session.empresa
                    det.tipo=params.tipo.toInteger()
                    det.mes=mes
                    def cuenta =  Cuenta.findByNumeroAndEmpresa(parts[1],session.empresa)
                    det.cuenta = cuenta
                    if(parts[4].size()>35)
                        parts[4]=parts[4][1..33]
                    det.descripcion=parts[4].toUpperCase()
                    if(parts[2].toDouble()>0){
                        valor=parts[2].toDouble()
                        det.signo=1
                    }else{
                        valor=parts[3].toDouble()
                        det.signo=-1
                    }
                    det.valor=valor
                    det.creacion=new Date()
                    det.secuencial=cont
                    cont++
                    det.usuario = session.usuario.login
                    det.ipMod=session.ip
                    println "cuenta "+det.cuenta+"  "+det.valor+"  "+det.tipo
                    if(!det.save(flush: true))
                        println "error save det "+det.errors
                }
            }
        }
        session.comprobante=comp

        redirect(action: "showEgreso")
        return

    }


    def showEgreso(){
        println "params show egreso "+params
        def comp = session.comprobante
        def cheque = session.cheque
        session.comprobante=null
        session.cheque=null
        if(!comp){
            comp = Comprobante.findAll("from Comprobante where mes=${params.mes} and numero=${params.numero} and tipo=${params.tipo} and empresa='${session.empresa.codigo}'")
            if(comp.size()>0)
                comp=comp.pop()
            if(!comp){
                flash.message="Comprobante no encontrado"
                redirect(action: "egresos")
                return
            }
            cheque = Cheque.findAll("from Cheque where mes=${comp.mes} and comprobante=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
            println "cheque "+cheque
            if(cheque.size()>0)
                cheque=cheque.pop()
            else
                cheque=null
        }
        def detComp = DetalleComprobante.findAll("from DetalleComprobante  where mes=${comp.mes} and numero=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
        def detFac = DetalleFacturaEgresos.findAll("from DetalleFacturaEgresos  where mes=${comp.mes} and comprobante=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
        [comp:comp,cheque:cheque,detComp:detComp,detFac:detFac]
    }
    def asientosEgreso(){
//        println "asientos "+params
        def banco = Banco.findByCodigo(params.banco)
        def valor = params.valor.toDouble().round(2)
        def cuentas = [:]
        cuentas.put(banco.cuenta,valor)
        params.data.split("W").each {p->
            if(p!="") {
                def parts = p.split(";")
                def ret
                if(parts[0]!=""){
                    ret = Tabla.findByCodigo(parts[0]).cuenta
                    if(ret) {
                        if(!cuentas[ret])
                            cuentas.put(ret, parts[1].toDouble())
                        else
                            cuentas[ret]+=parts[1].toDouble()
                    }
                }
                if(parts[2]!=""){
                    ret = Tabla.findByCodigo(parts[2]).cuenta
                    if(ret){
                        if(!cuentas[ret])
                            cuentas.put(ret,parts[3].toDouble())
                        else
                            cuentas[ret]+=parts[3].toDouble()
                    }

                }

            }
        }
//        println "cuentas "+cuentas
        [cuentas:cuentas,banco:banco,valor:valor]
    }


    def getDatosCliente_ajax(){
        def cli = Cliente.findByCodigo(params.cliente)
        render ""+cli.banco?.codigo+";"+cli.tipoCuenta+";"+(cli.numeroCuenta?cli.numeroCuenta:'')
    }

    def aplicarPrototipo_ajax(){
        def p = Prototipo.get(params.id)
        def dets = DetallePrototipo.findAllByCodigo(p.id)
        [dets:dets]
    }

    def enviarCorreo_ajax(){
//        println "enviar "+params
        def email = "ana.duque@petroleosyservicios.com"
        def comp = Comprobante.findAll("from Comprobante where mes=${params.mes} and numero=${params.numero} and tipo=${params.tipo} and empresa='${session.empresa.codigo}'")
        if(comp.size()>0) {
            comp = comp.pop()
            def det = DetalleComprobante.findAll("from DetalleComprobante  where mes=${comp.mes} and numero=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
            mailService.sendMail {
                multipart true
                to email
                subject "[CONTABLE]Edición de comprobante"
                body( view:"mailComprobante",
                        model:[comp:comp,detalle:det,genera:session.usuario.login])
                inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
            }

        }
        render "ok"
    }



}
