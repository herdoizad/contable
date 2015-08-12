package contable.seguridad

class Shield {
    def beforeInterceptor = [action: this.&auth, except: 'login']
    /**
     * Verifica si se ha iniciado una sesión
     * Verifica si el usuario actual tiene los permisos para ejecutar una acción
     */
    def auth() {
        if (!actionName.contains("ajax")) {
            session.an = actionName
            session.cn = controllerName
            session.pr = params
        }
//        return true
        /** **************************************************************************/
        if (!session.usuario) {
            redirect(controller: 'login', action: 'logout')
            session.finalize()
            return false
        } else {
            def band = isAllowed()
            if(!band) {
                response.sendError(403)
                return false
            }else {
                return true
            }
        }
        /*************************************************************************** */
    }

    boolean isAllowed() {
        try {

//            println "method: " + request.method
            if (request.method == "POST") {
//                println "es post no audit"
                return true
            }
            if(actionName=~"_ajax"){
                return true
            }
//            println "0 " + session.permisos
//            println "1 " + session.permisos[controllerName.toLowerCase()]
//            println "2 " + controllerName.toLowerCase()
//            println "3 " + actionName.toLowerCase()
//            println "4 " + session.permisos[controllerName.toLowerCase()].contains(actionName.toLowerCase())


//            println "is allowed Accion: ${actionName.toLowerCase()} ---  Controlador: ${controllerName.toLowerCase()} --- Permisos de ese controlador: "+session.permisos[controllerName.toLowerCase()]
            if (!session.permisos[controllerName.toLowerCase()]) {
                return false
            } else {
                if (session.permisos[controllerName.toLowerCase()].contains(actionName.toLowerCase())) {
                    return true
                } else {
                    return false
                }
            }

        } catch (e) {
            println "Shield execption e: " + e
            return false
        }
    }


}
 
