package contable.seguridad

import contable.seguridad.Accion
import contable.seguridad.Controlador
import contable.seguridad.Modulo
import contable.seguridad.Permiso
import contable.seguridad.TipoAccion
import contable.seguridad.Usuario

class AccionesController extends Shield {

    def mailService

    static final sistema="T"  //todos

    /**
     * Acción que redirecciona a acciones
     */
    def index() {
        redirect(action: "acciones")
    }

    /**
     * Acción que muestra un listado de acciones ordenadas por módulo
     */
    def acciones() {
        def modulos = Modulo.findAllByOrdenIsNotNull([sort: "orden"])
        return [modulos: modulos]
    }

    /**
     * Acción que muestra una lista de acciones filtrando por módulo y tipo para editar las acciones
     */
    def acciones_ajax() {
//        println "acc aj "+params
        def usuario = Usuario.findByLogin(params.usuario)
        def modulo = Modulo.get(params.id)
        def acciones = Accion.withCriteria {
            eq("modulo", modulo)
            not {
                ilike("nombre", "%ajax%")
                ilike("nombre", "%old%")
            }
            order("tipo", "asc")
            order("orden", "asc")
        }

        def acp = acciones.findAll { Permiso.countByAccionAndUsuario(it, usuario) > 0 }
        def acnp = acciones.findAll { Permiso.countByAccionAndUsuario(it, usuario) == 0 }

        return [acciones: acp + acnp, usuario: usuario, modulo: modulo]
    }

    /**
     * Acción llamada con ajax que cambia el tipo de una acción entre Menú y Proceso
     */
    def accionCambiarTipo_ajax() {
        def accion = Accion.get(params.id)
        accion.tipo = TipoAccion.findByCodigo(params.tipo)
        if (!accion.save(flush: true)) {
            render "ERROR*" + renderErrors(bean: accion)
        } else {
            render "SUCCESS*Tipo de acción modificado exitosamente"
        }
    }

    /**
     * Acción llamada con ajax que cambia el nombre de varias acciones
     */
    def accionCambiarNombre_ajax() {
        def errores = ""
        def cont = 0

        params.each { k, v ->
            if (k.toString().startsWith("desc")) {
                def parts = k.split("_")
                if (parts.size() == 2) {
                    def id = parts[1].toLong()
                    def accion = Accion.get(id)
                    accion.descripcion = v.trim()
                    if (!accion.save(flush: true)) {
                        errores += renderErrors(bean: accion)
                    } else {
                        cont++
                    }
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Nombre de ${cont} acci${cont == 1 ? 'ón' : 'ones'} modificado${cont == 1 ? '' : 's'} exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción llamada con ajax que cambia el módulo al que pertenecen varias acciones
     */
    def accionCambiarModulo_ajax() {
        def errores = ""
        def cont = 0

        params.each { k, v ->
            if (k.toString().startsWith("mod")) {
                def parts = k.split("_")
                if (parts.size() == 2) {
                    def id = parts[1].toLong()
                    def accion = Accion.get(id)
                    accion.modulo = Modulo.get(v.toLong())
                    if (!accion.save(flush: true)) {
                        errores += renderErrors(bean: accion)
                    } else {
                        cont++
                    }
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Módulo de ${cont} acci${cont == 1 ? 'ón' : 'ones'} modificado${cont == 1 ? '' : 's'} exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }



    /**
     * Acción llamada con ajax que cambia el orden de una acción
     */
    def accionCambiarOrden_ajax() {
        println params
        def accion = Accion.get(params.id)
        println accion
        accion.orden = params.orden.toInteger()
        println accion.orden
        if (accion.save(flush:true)) {
            render "SUCCESS*Se ha cambiado el orden exitosamente"
        } else {
            println renderErrors(bean: accion)
            render "ERROR*" + renderErrors(bean: accion)
        }
    }
    /**
     * Acción llamada con ajax que cambia el icono de una acción
     */
    def accionCambiarIcono_ajax() {
        def accion = Accion.get(params.id)
        accion.icono = params.icono
//        println "cambiar ico: " + params
        if (accion.save(flush: true)) {
            render "SUCCESS*Se ha cambiado el icono exitosamente"
        } else {
            render "ERROR*" + renderErrors(bean: accion)
        }
    }

    /**
     * Función que busca si un elemento existe con ilike
     * @param lista
     * @param elemento
     */
    def containsIlike(lista, String elemento) {
        def existe = false
        lista.each { String item ->
            if (item.matches("(?i).*" + elemento + ".*")) {
                existe = true
            }
        }
        return existe
    }

    /**
     * Acción llamada con ajax que itera sobre todos los controladores creados en el proyecto, analiza las acciones de cada controlador, las busca en la base de datos y si no las encuentra las inserta en la tabla representada por el dominio Accn
     */
    def cargarAcciones_ajax() {
//        println "cargar acciones"
        def ac = []
        def accs = [:]
        def ok = 0
        def okc = 0
        def total = 0
        def ignoreAcciones = ["afterInterceptor", "beforeInterceptor", "getList"]
        def ignoreAccionesLike = ["ajax", "old"]
        def ignoreControladores = ["Assets", "Dbdoc", "Shield", "Login", "Pdf","Pruebas"]
        def errores = ""
        grailsApplication.controllerClasses.each { ct ->

            if (!ignoreControladores.contains(ct.getName())) {
                def t = []
                ct.getURIs().each {
                    def s = it.split("/")
                    if (s.size() > 2) {
                        if (!t.contains(s[2])) {
                            if (!ignoreAcciones.contains(s[2])) {
                                if (!containsIlike(ignoreAccionesLike, s[2])) {
                                    if (!(s[2] =~ "Service")) {
                                        def ctrl = Controlador.findByNombreIlike(s[1])
                                        if (!ctrl) {
                                            ctrl = new Controlador()
                                            ctrl.nombre = s[1].toString().capitalize()
                                            if (ctrl.save()) {
                                                okc++
                                                println "\tAgregado controlador " + ctrl.nombre
                                            } else {
                                                errores += renderErrors(bean: ctrl)
                                                println "errores " + ctrl.errors
                                            }
                                        }
                                        def accn = Accion.findByNombreAndControl(s[2], ctrl)
                                        //println "si service "+ s[2]+" accion "+accn.id+" url "+it
                                        if (accn == null) {
//                                    println "if 2";
                                            accn = new Accion()
                                            accn.nombre = s[2]
                                            accn.control = Controlador.findByNombre(ct.getName())
                                            accn.descripcion = s[2]
                                            accn.accnAuditable = 1
                                            accn.orden = 1
//                                    if (s[2] =~ "save" || s[2] =~ "update" || s[2] =~ "delete" || s[2] =~ "guardar")
                                            accn.tipo = TipoAccion.findByCodigo("P")
//                                    else
//                                        accn.tipo = TipoAccion.findByCodigo("M")
                                            accn.modulo = Modulo.findByNombre("noAsignado")
                                            if (accn.save()) {
                                                accn.orden = accn.id
                                                accn.icono = ""
                                                accn.save()
                                                ok++
                                            } else {
                                                errores += renderErrors(bean: accn)
                                                println "errores " + accn.errors
                                            }
                                            total++
                                        }else{
//                                            if(accn.sistema!=sistema){
//                                                println "${accn} cambio de sistema --> "+sistema
//                                                accn.sistema=sistema
//                                                accn.save(flush: true)
//                                            }
                                        }
                                        t.add(s.getAt(2))
                                    } else {
//                                println "no sale por el service "+s[2]+" "+it
                                    }
                                } else {
//                                    println s[2] + " no sale por el ignoreAccionesLike " + ignoreAccionesLike
                                }
                            } else {
//                                println s[2] + " no sale por el ignoreAcciones " + ignoreAcciones
                            }
                        } else {
                            //println "no sale por el contains t  "+it+"   "+t
                        }
                    } else {
                        // println "no sele por el size "+it
                    }
                }
                accs.put(ct.getName(), t)
                t = null
            } else {
//                println ct.getName() + " no sale por el ignoreControladores " + ignoreControladores
            }
        }
        if (errores == "") {
            render("SUCCESS*Se ha${(ok + okc) == 1 ? '' : 'n'} agregado ${ok} acci${ok == 1 ? 'ón' : 'ones'} ${okc == 0 ? '' : (' y ' + okc + ' controlador' + (okc == 1 ? '' : 'es'))}")
        } else {
            render "ERROR*Se insert${ok == 1 ? 'ó' : 'aron'} ${ok} de ${total} acci${ok == 1 ? 'ón' : 'ones'}: " + errores
        }
    }

    /**
     * Acción llamada con ajax que guarda los permisos de un perfil
     */
    def guardarPermisos_ajax() {
//        println "guardar " + params
        def usuario = Usuario.findByLogin(params.usuario)
        def modulo = Modulo.get(params.modulo.toLong())

        //todos los permisos actuales de este perfil en este modulo
        def permisosOld = Permiso.withCriteria {
            eq("usuario", usuario)
            accion {
                eq("modulo", modulo)
            }
        }
        def accionesSelected = []
        def accionesInsertar = []
        (params.accion.split(",")).each { accionId ->
            def accion = Accion.get(accionId.toLong())
            if (!permisosOld.accion.id.contains(accion.id)) {
                accionesInsertar += accion
            } else {
                accionesSelected += accion
            }
        }

        def commons = permisosOld.accion.intersect(accionesSelected)
        def accionesDelete = permisosOld.accion.plus(accionesSelected)
        accionesDelete.removeAll(commons)

        def errores = ""

        accionesInsertar.each { accion ->
            def perm = new Permiso()
            perm.accion = accion
            perm.usuario = usuario
            if (!perm.save(flush: true)) {
                errores += renderErrors(bean: perm)
                println "error al guardar permiso: " + perm.errors
            }
        }
        accionesDelete.each { accion ->
            println "delete "+accion
            def perm = Permiso.findAllByUsuarioAndAccion(usuario, accion)
            try {
                if (perm.size() == 1) {
                    perm.first().delete(flush: true)
                } else {
                    errores += "Existen ${perm.size()} registros del permiso " + accion.nombre
                }
            } catch (Exception e) {
                errores += "Ha ocurrido un error al eliminar el permiso " + accion.nombre
                println "error al eliminar permiso: " + e
            }
        }
        if (errores == "") {
            render "SUCCESS*${accionesInsertar.size()} acci${accionesInsertar.size() == 1 ? 'ón' : 'ones'} insertada${accionesInsertar.size() == 1 ? '' : 's'}" +
                    " y ${accionesDelete.size()} acci${accionesDelete.size() == 1 ? 'ón' : 'ones'} eliminada${accionesDelete.size() == 1 ? '' : 's'} exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    def resetPassword_ajax(){
        def usuario = Usuario.findByLogin(params.usu)
        def r = new Random()
        def chars = ["!","#","\$","%","&","-","_"]
        def pass=usuario.login[0..2]
        6.times{
            def num = r.nextInt(120)
            def c = Character.toChars(num)
            if(num<56)
                c=num.toString()[0..0]
            if(c==" " || c=="" || c==null) {
                c = chars[r.nextInt(6)]
            }
            pass+=c
        }
//        println "pass "+pass
        usuario.password=pass.encodeAsMD5()
        if(!usuario.save(flush: true))
            println "error save usu "+usuario.errors
        def email = usuario.nombre.split(" ")
        email=email[0]+"."+email[1]+"@petroleosyservicios.com".toUpperCase()
        mailService.sendMail {
            multipart true
            to email
            subject "[CONTABLE]Nueva contraseña"
            body( view:"cambioPass",
                    model:[pass:pass,usuario:usuario.login,genera:session.usuario.login])
            inline 'logo','image/png',grailsApplication.mainContext.getResource('/images/logo-login.png').getFile().readBytes()
        }
        render "ok"

    }
}
