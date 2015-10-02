package contable.nomina

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Prestamo
 */
class PrestamoController extends Shield {

    def mailService

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        def empleado=null
        if(params.empleado)
            empleado =   Empleado.get(params.empleado)
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Prestamo.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                }
            }
        } else {
            if(empleado)
                list=Prestamo.findAllByEmpleado(empleado)
            else
                list = Prestamo.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     */
    def list() {
        def prestamoInstanceList = getList(params, false)
        def prestamoInstanceCount = getList(params, true).size()
        def empleado=null
        if(params.empleado)
            empleado =   Empleado.get(params.empleado)
        return [prestamoInstanceList: prestamoInstanceList, prestamoInstanceCount: prestamoInstanceCount,empleado:empleado]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def prestamoInstance = Prestamo.get(params.id)
            if (!prestamoInstance) {
                render "ERROR*No se encontró Prestamo."
                return
            }
            return [prestamoInstance: prestamoInstance]
        } else {
            render "ERROR*No se encontró Prestamo."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        println "params "+params
        def prestamoInstance = new Prestamo()
        if (params.id) {
            prestamoInstance = Prestamo.get(params.id)
            if (!prestamoInstance) {
                render "ERROR*No se encontró Prestamo."
                return
            }
        }
        prestamoInstance.properties = params
        def empleado = null
        if(params.empleado && params.empleado!=""){
            empleado=Empleado.get(params.empleado)
        }
        return [prestamoInstance: prestamoInstance,empleado: empleado]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def prestamoInstance = new Prestamo()
        if (params.id) {
            prestamoInstance = Prestamo.get(params.id)
            if (!prestamoInstance) {
                render "ERROR*No se encontró Prestamo."
                return
            }
        }
        prestamoInstance.properties = params
        if (!prestamoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Prestamo: " + renderErrors(bean: prestamoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Prestamo exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def prestamoInstance = Prestamo.get(params.id)
            if (!prestamoInstance) {
                render "ERROR*No se encontró Prestamo."
                return
            }
            try {
                prestamoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Prestamo exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Prestamo"
                return
            }
        } else {
            render "ERROR*No se encontró Prestamo."
            return
        }
    } //delete para eliminar via ajax


    def solicitar(){

    }


    def formSolicitud_ajax(){
        def tipo = TipoPrestamo.get(params.id)
        switch (tipo.codigo){
            case "ANTC":
                redirect(action: 'formAnticipo_ajax',id:tipo.id)
                break;
            case "EMRG":
                redirect(action: 'formEmergente_ajax',id:tipo.id)
                break;
            case "CSMO":
                redirect(action: 'formConsumo_ajax',id:tipo.id)
                break;
        }
    }

    def formAnticipo_ajax(){
        def empleado = Empleado.findByUsuario(session.usuario.login)
        def tipo = TipoPrestamo.get(params.id)
        if(!empleado){
            render "El usuario ${session.usuario} no está registrado como empleado de la institución"
            return
        }else{
            def sueldo = Sueldo.findAllByEmpleado(empleado,[sort:"inicio"])
            if(sueldo.size()>0)
                sueldo=sueldo.pop()
            else{
                render "El usuario ${session.usuario} no tiene un sueldo vigente"
                return
            }
            [sueldo:sueldo,empleado: empleado,tipo:tipo]
        }


    }

    def saveAnticipo_ajax(){
        def empleado = Empleado.findByUsuario(session.usuario.login)
        def tipo = TipoPrestamo.findByCodigo("ANTC")
        def valor =params.monto
        def prestamo = new Prestamo()
        prestamo.empleado=empleado
        prestamo.tipo=tipo
        prestamo.monto=valor.toDouble()
        prestamo.plazo=1
        prestamo.valorCuota=prestamo.monto
        if(!prestamo.save(flush: true)){
            println "error save prestamo"
        }else{
            def email = "susana.barriga@petroleosyservicios.com"
            mailService.sendMail {
                multipart true
                to "valentinsvt@hotmail.com"
//                to r.empleado.email
                cc "valentinsvt@hotmail.com"
//                cc email
                subject "Solicitud de anticipo"
                body( view:"mailSolicitud",
                        model:[prestamo:prestamo,usuario:session.usuario.login,titulo:'Solicitud de anticipo'])
                inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
            }
        }

        redirect(action: "historialPrestamos")

    }

    def historialPrestamos(){
        def empleado = Empleado.findByUsuario(session.usuario.login)
        if(!empleado)
            response.sendError(403)
        def prestamos = Prestamo.findAllByEmpleado(empleado)
        [empleado:empleado,prestamos:prestamos]
    }

    def formEmergente_ajax(){
        def empleado = Empleado.findByUsuario(session.usuario.login)
        def tipo = TipoPrestamo.get(params.id)
        if(!empleado){
            render "El usuario ${session.usuario} no está registrado como empleado de la institución"
            return
        }else{
            def sueldo = Sueldo.findAllByEmpleado(empleado,[sort:"inicio"])
            if(sueldo.size()>0)
                sueldo=sueldo.pop()
            else{
                render "El usuario ${session.usuario} no tiene un sueldo vigente"
                return
            }
            [sueldo:sueldo,empleado: empleado,tipo:tipo]
        }
    }

    def saveEmergente_ajax(){
        def empleado = Empleado.findByUsuario(session.usuario.login)
        def tipo = TipoPrestamo.findByCodigo("EMRG")
        def valor =params.monto
        def prestamo = new Prestamo()
        prestamo.empleado=empleado
        prestamo.tipo=tipo
        prestamo.monto=valor.toDouble()
        prestamo.plazo=params.plazo.toInteger()
        prestamo.valorCuota=(prestamo.monto/prestamo.plazo).toDouble().round(2)
        if(!prestamo.save(flush: true)){
            println "error save prestamo"
        }else{
            def email = "susana.barriga@petroleosyservicios.com"
            mailService.sendMail {
                multipart true
                to "valentinsvt@hotmail.com"
//                to r.empleado.email
                cc "valentinsvt@hotmail.com"
//                cc email
                subject "Solicitud de prestamo emergente"
                body( view:"mailSolicitud",
                        model:[prestamo:prestamo,usuario:session.usuario.login,titulo:'Solicitud de prestamo emergente'])
                inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
            }
        }

        redirect(action: "historialPrestamos")
    }
    def saveConsumo_ajax(){
        def empleado = Empleado.findByUsuario(session.usuario.login)
        def tipo = TipoPrestamo.findByCodigo("CSMO")
//        println "tipo "+tipo
        def valor =params.monto
        def prestamo = new Prestamo()
        prestamo.empleado=empleado
        prestamo.tipo=tipo
        prestamo.monto=valor.toDouble()
        prestamo.plazo=params.plazo.toInteger()
        prestamo.interes=params.interes.toDouble()
        def interes = prestamo.interes/prestamo.plazo/100
        def cuota = interes*Math.pow(1+interes,prestamo.plazo)
        cuota=cuota/(Math.pow(1+interes,prestamo.plazo)-1)
        cuota=cuota*prestamo.monto
        prestamo.valorCuota=cuota
        if(!prestamo.save(flush: true)){
            println "error save prestamo"
        }else{
            def email = "susana.barriga@petroleosyservicios.com"
            mailService.sendMail {
                multipart true
                to "valentinsvt@hotmail.com"
//                to r.empleado.email
                cc "valentinsvt@hotmail.com"
//                cc email
                subject "Solicitud de prestamo de consumo"
                body( view:"mailSolicitud",
                        model:[prestamo:prestamo,usuario:session.usuario.login,titulo:'Solicitud de prestamo emergente'])
                inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
            }
        }

        redirect(action: "historialPrestamos")
    }

    def formConsumo_ajax(){
        def empleado = Empleado.findByUsuario(session.usuario.login)
        def tipo = TipoPrestamo.get(params.id)
        def interes = Variable.findByCodigo("TINT")
        if(!empleado){
            render "El usuario ${session.usuario} no está registrado como empleado de la institución"
            return
        }else{
            def sueldo = Sueldo.findAllByEmpleado(empleado,[sort:"inicio"])
            if(sueldo.size()>0)
                sueldo=sueldo.pop()
            else{
                render "El usuario ${session.usuario} no tiene un sueldo vigente"
                return
            }
            [sueldo:sueldo,empleado: empleado,tipo:tipo,interes:interes.valor]
        }

    }

    def tabla_ajax(){


        def monto = params.monto.toDouble()
        def taza = params.interes.toDouble()
        def plazo = params.plazo.toInteger()
        def interes = taza/plazo/100
        def cuota = interes*Math.pow(1+interes,plazo)
//        println "cuota "+cuota
        cuota=cuota/(Math.pow(1+interes,plazo)-1)
//        println "cuota "+cuota
        cuota=cuota*monto
//        println "cuota --> "+cuota
        def datos=[]
        def inicio = new Date()
        def tmp = [:]
        def saldo = monto
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, inicio.format("yyyy").toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
        inicio  = cal.getTime();
        tmp["fecha"]=inicio
        tmp["saldo"]=monto
        tmp["taza"]=0
        tmp["interes"]=0
        tmp["cuota"]=0
        tmp["capital"]=0
        datos.add(tmp)
        inicio = inicio.plus(1)
        /*Todo calcular el interes primero! (con las fechas) no depende de la cuota!!!!*/
        plazo.times{
            cal = Calendar.getInstance();
            cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
            cal.set(Calendar.YEAR, inicio.format("yyyy").toInteger());
            cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
            cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
            def fin  = cal.getTime();
            println "inicio "+inicio.format("dd-MM-yyyy")+" - "+fin.format("dd-MM-yyyy")+" (${fin-inicio}) saldo "+saldo
            tmp = [:]
            tmp["fecha"]=fin
            tmp["taza"]=taza
            tmp["interes"]=(saldo*((fin-inicio)+1)*((taza/100)/360)).toDouble().round(2)
            tmp["cuota"]=cuota
            tmp["capital"]=(cuota-tmp["interes"]).toDouble().round(2)
            tmp["saldo"]=(saldo-tmp["capital"]).toDouble().round(2)

            inicio = fin
            inicio = inicio.plus(1)
            saldo-=tmp["capital"]
            saldo = saldo.toDouble().round(2)
            if(it==plazo-1){
                if(saldo!=0){
                    tmp["cuota"]+=saldo
                    tmp["capital"]+=saldo
                    tmp["saldo"]=0
                }
            }
            datos.add(tmp)
        }



        [ monto:monto,taza:taza,plazo:plazo,cuota:cuota,datos:datos]

    }

    def pendientesAnticipos(){
        def tipo = TipoPrestamo.findByCodigo("ANTC")
        def sol = Prestamo.findAllByEstadoAndTipo("S",tipo)
        [sol:sol]
    }

    def pendientesEmergentes(){
        def tipo = TipoPrestamo.findByCodigo("EMRG")
        def sol = Prestamo.findAllByEstadoAndTipo("S",tipo)
        [sol:sol]
    }

    def pendientesConsumo(){
        def tipo = TipoPrestamo.findByCodigo("CSMO")
        def sol = Prestamo.findAllByEstadoAndTipo("S",tipo)
        [sol:sol]
    }

    def aprobar_ajax(){
        def prestamo = Prestamo.get(params.id)
        if(prestamo.estado=="A"){
            render "error"
            return
        }else{
            prestamo.estado="A"
            if(params.observaciones)
                prestamo.observaciones=params.observaciones
            if(params.inicio)
                prestamo.inicio=new Date().parse("dd-MM-yyyy",params.inicio)
            if(prestamo.tipo.codigo=="ANTC")
                prestamo.fin=prestamo.inicio
            else{
                def fin
                def inicio = prestamo.inicio
                prestamo.plazo.times {
                    def cal = Calendar.getInstance();
                    cal.set(Calendar.MONTH, inicio.format("MM").toInteger() - 1);
                    cal.set(Calendar.YEAR, inicio.format("yyyy").toInteger());
                    cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
                    cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
                    fin = cal.getTime();
                    inicio=fin
                    inicio=inicio.plus(1)
                }
                prestamo.fin=fin
            }
            prestamo.usuarioAprueba=session.usuario.login
            prestamo.fechaRevision = new Date()
            prestamo.save(flush: true)
            mailService.sendMail {
                multipart true
                to "valentinsvt@hotmail.com"
//                to prestamo.empleado.email
                subject "Prestamo aprobado"
                body( view:"mailResultado",
                        model:[prestamo:prestamo,usuario:session.usuario.login,titulo:'Prestamo aprobado'])
                inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
//            inline 'logo','image/png', new File('./web-app///images/logo-login.png').readBytes()
            }
            render "ok"
        }
    }

    def negar_ajax(){
        def prestamo = Prestamo.get(params.id)
        if(prestamo.estado!="S"){
            render "error"
            return
        }else{
            prestamo.estado="N"
            prestamo.observaciones=params.observaciones
            prestamo.usuarioAprueba=session.usuario
            prestamo.fechaRevision = new Date()
            prestamo.fin=new Date()
            prestamo.save(flush: true)
            render "ok"
        }
    }

    def revisar(){
        def sol = Prestamo.get(params.id)
        if(sol.estado!="S")
            response.sendError(403)
        def sueldo = Sueldo.findAllByEmpleado(sol.empleado,[sort:"inicio"])
        if(sueldo.size()>0)
            sueldo=sueldo.pop()
        def roles = Rol.findAllByEmpleado(sol.empleado,[sort: "registro",order:"desc",max:2])
        def prestamos = Prestamo.findAllByEmpleado(sol.empleado)
        [sol:sol,sueldo: sueldo,roles:roles,prestamos:prestamos]
    }

    def revisar_ajax(){
        def prestamo = Prestamo.get(params.id)
        if(prestamo.estado!="S"){
            render "error"
            return
        }else{
            prestamo.estado="R"
            prestamo.observaciones=params.observaciones
            if(params.inicio)
                prestamo.inicio=new Date().parse("dd-MM-yyyy",params.inicio)
            prestamo.usuarioAprueba=session.usuario.login
            prestamo.fechaRevision = new Date()
            prestamo.save(flush: true)
            render "ok"
        }
    }



    def historial(){

    }


    def historialTipo_ajax(){
        def tipo = TipoPrestamo.findByCodigo(params.tipo)
        def solicitados = Prestamo.findAllByTipoAndEstadoInList(tipo,["S","R"])
        def aprobados = Prestamo.findAllByTipoAndEstado(tipo,"A")
        def negados = Prestamo.findAllByTipoAndEstado(tipo,"N")
        [solicitados:solicitados,aprobados:aprobados,negados:negados]
    }

    def pendientes(){
        def prestamos = Prestamo.findAllByEstado("R")
        [prestamos:prestamos]
    }


    def revisar_presidencia(){
        def sol = Prestamo.get(params.id)
        if(sol.estado!="R")
            response.sendError(403)
        def sueldo = Sueldo.findAllByEmpleado(sol.empleado,[sort:"inicio"])
        if(sueldo.size()>0)
            sueldo=sueldo.pop()
        def roles = Rol.findAllByEmpleado(sol.empleado,[sort: "registro",order:"desc",max:2])
        def prestamos = Prestamo.findAllByEmpleado(sol.empleado)
        [sol:sol,sueldo: sueldo,roles:roles,prestamos:prestamos]
    }


    def verPrestamo(){
        def prestamo = Prestamo.get(params.id)
        def det = DetallePrestamo.findAllByPrestamoAndEstado(prestamo,"A",[sort:"fechaDePago"])
        def taza = Variable.findByCodigo("TINT")?.valor
        def lastCuota = new Date().parse("yyyyMMdd",prestamo.inicio.format("yyyyMM")+"01")
        if(det.size()>0){
            lastCuota=det.last().fechaDePago
        }

        if(prestamo.tipo.codigo!="CSMO")
            taza=0
        [prestamo:prestamo,det:det,taza:taza,lastCuota:lastCuota]
    }


    def savePago_ajax(){
        def pretamo = Prestamo.get(params.prestamo)
        def last = DetallePrestamo.findAllByPrestamoAndEstado(pretamo,"A",[sort: "fechaDePago"])
        def saldo = pretamo.monto
        if(last.size()>0) {
            last = last.last()
            saldo = last.saldo
        }
        def dp = new DetallePrestamo()
        def taza = Variable.findByCodigo("TINT")?.valor
        dp.prestamo=pretamo
        dp.fechaDePago=new Date()
        dp.usuario=session.usuario.login
        dp.registro=new Date()
        dp.estado="A"
        dp.cuota=params.valor.toDouble().round(2)
        dp.interes=params.interes.toDouble().round(2)
        dp.taza=taza
        dp.capital=(dp.cuota-dp.interes).toDouble().round(2)
        dp.saldo= (saldo-dp.capital).toDouble().round(2)
        dp.save(flush: true)
        render "ok"
    }




}
