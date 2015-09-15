package contable.seguridad

class InicioController extends Shield{

    def index() {

    }

    def contenido(){

    }

    def personal(){

    }

    def cambiarPass_ajax(){
        def usuario = session.usuario
//        println "pass "+usuario.password +"  "+params.old.encodeAsMD5()
        if(usuario.password==params.old.encodeAsMD5()){
            usuario.password=params.new.encodeAsMD5()
            if(usuario.save(flush:true)) {
                flash.message="Contraseña actualizada"
                redirect(action: "personal")
            }
        }else{
            flash.message="Contraseña incorrecta"
            redirect(action: "personal")
        }
    }

}
