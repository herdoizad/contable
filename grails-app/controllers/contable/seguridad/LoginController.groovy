package contable.seguridad

import contable.alertas.Alerta
import contable.core.Empresa


class LoginController {

    def index() {
        redirect(action: 'login')
    }


    def login() {
        def usu = session.usuario
        def cn = "inicio"
        def an = "index"
//        println "eval "+ Eval.me(' (12535.25 /30)*21')
        if (usu) {
            if (session.cn && session.an) {
                cn = session.cn
                an = session.an
            }
            redirect(controller: cn, action: an)
        }
    }

    def validar() {
        if (!params.user || !params.pass) {
            redirect(controller: "login", action: "login")
            return
        }
        def user = Usuario.withCriteria {
            eq("login", params.user)
        }
        if (user.size() == 0) {
            flash.message = "No se ha encontrado el usuario"
            flash.tipo = "error"
            redirect(controller: 'login', action: "login")
            return
        } else if (user.size() > 1) {
            flash.message = "Ha ocurrido un error grave"
            flash.tipo = "error"
            redirect(controller: 'login', action: "login")
            return
        } else {
            user=user.pop()
            //println "pass " +params.pass+" "+params.pass.encodeAsMD5()+"  "+user.password
            if (params.pass.encodeAsMD5() != user.password) {

                flash.message = "Contraseña incorrecta"
                flash.tipo = "error"
                flash.icon = "icon-warning"
                session.usuario = null
                redirect(controller: 'login', action: "login")
                return
            }else{
                if(verificaHorario(user)) {
                    session.usuario = user
                    session.usuarioKerberos = user.login
                    session.ip = request.remoteAddr
                    session.empresa = Empresa.findByPrincipal("S")
                    session.color=""
                    doLogin()
                }else{
                    flash.message = "No puede ingresar al sistema"
                    flash.tipo = "error"
                    flash.icon = "icon-warning"
                    session.usuario = null
                    session.color=""
                    redirect(controller: 'login', action: "login")
                    return
                }


            }


        }
    }

    def doLogin() {
        cargarPermisos()
        def count = Alerta.countByParaAndRevisadoIsNull(session.usuario.login)
        if (count > 0) {
            redirect(controller: 'alerta', action: 'list')
            return
        } else {
            if (session.an && session.cn) {
                redirect(controller: session.cn, action: session.an, params: session.pr)
            } else {
                redirect(controller: "inicio", action: "index")
            }
            return
        }
    }



    def verificaHorario(user) {
        def now = new Date()
        Calendar c = Calendar.getInstance()
        c.setTime(now)
        def dia = c.get(Calendar.DAY_OF_WEEK)-1
        println "dia "+dia
        def horario = Horario.findByUsuarioAndDia(user,dia)
        if(!horario)
            return false
       // println "horario "+horario.dia+" "+horario.inicio+" "+horario.fin
        def inicio = new Date().parse("dd-MM-yy HH:mm:ss",now.format("dd-MM-yy "+horario.inicio))
        def fin = new Date().parse("dd-MM-yy HH:mm:ss",now.format("dd-MM-yy "+horario.fin))
        if(now.before(fin) && now.after(inicio)){
            return true
        }
        return  false
    }



    def logout() {
        session.usuario = null
        session.permisos = null
        session.menu = null
        session.an = null
        session.cn = null
        session.invalidate()
        redirect(controller: 'login',action: 'login')
    }


    def cargarPermisos() {
        def permisos = Permiso.findAllByUsuario(session.usuario)
        def hp = [:]
        permisos.each {
            if (hp[it.accion.control.nombre.toLowerCase()]) {
                hp[it.accion.control.nombre.toLowerCase()].add(it.accion.nombre.toLowerCase())
            } else {
                hp.put(it.accion.control.nombre.toLowerCase(), [it.accion.nombre.toLowerCase()])
            }
        }

        session.permisos = hp
        //println "session permisos "+session.permisos
    }

    def cambiaColor_ajax(){
        if(session.color=="-1")
            session.color=""
        else
            session.color="-1"
        redirect(uri: "/")
    }

}
