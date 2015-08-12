package contable.core

import contable.seguridad.Shield

class CuentasController extends Shield {

    def index() {
        redirect(action: 'list')
    }

    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 30
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Cuenta.createCriteria()
            list = c.list(params) {
                or {

                    ilike("numero", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = Cuenta.list(params)
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
        params.max=19
        def lista = getList(params, false)
        def count = getList(params, true).size()
        return [lista: lista, count: count]
    }

    def arbol(){

        return [arbol: makeTree(params), params: params]
    }

    def loadTreePart_ajax() {
        println "load parte "+params
        render(imprimeHijos(params))
        println "acabo"
    }
    private String makeTree(params) {
        def res = ""
        res += "<ul>"
        res += "<li id='l-0' data-level='0' class='root jstree-open hasChildren' data-jstree='{\"type\":\"pys\"}'>"
        res += "<a href='#' class='label_arbol'>Petroleos y servicios</a>"
        res += "</li>"
        res += "</ul>"
        return res
    }

    private String imprimeHijos(params) {
        def txt = ""

        def hijos
        if(params.id=="#") {
            txt += "<li id='0' data-level='0' class='root jstree-closed hasChildren' data-jstree='{\"type\":\"pys\"}'>"
            txt += "<a href='#' class='label_arbol'>Petroleos y servicios</a>"
            txt += "</li>"
        } else {
            if(params.id=="0"){
                hijos = Cuenta.findAllByNivelAndEmpresa(1, session.empresa)
            }else{
                hijos = Cuenta.findAllByPadreAndEmpresa(params.id, session.empresa)
            }
            hijos.each { h ->
                def hi = Cuenta.countByPadreAndEmpresa(h.numero, session.empresa)
                txt += "<ul>"
                txt += "<li class='${hi > 0 ? 'hasChildren jstree-closed' : ''}  ${h.agrupa==1?'movimiento':''} ' id='${h.numero.trim()}' data-jstree='{\"type\":\"${h.clase}\"}'>"
                txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                txt += h
                txt += "</span></a>"
                txt += "</li>"
                txt += "</ul>"
            }

        }

        return  txt

    }

    def verDetalles_ajax() {
//        println "ver detalles "+params
        def cuenta = Cuenta.findByNumeroAndEmpresa(params.id,session.empresa)
        return [cuenta: cuenta]
    }


    def form_ajax() {
        def cuentaInstance = new Cuenta()
        def clases = ["1":"Activo","2":"Pasivo","3":"Patrimonio","4":"Ingresos","5":"Gastos","6":"Orden"]
        if (params.id) {
            cuentaInstance = Cuenta.findByNumeroAndEmpresa(params.id,session.empresa)
            if (!cuentaInstance) {
                render "ERROR*No se encontró Cuenta."
                return
            }
        }
        def padre = null
        if(params.padre){
            padre=Cuenta.findByNumeroAndEmpresa(params.padre,session.empresa)

        }
        def limites=[1:"1",2:"1",3:"1",4:"2",5:"3",6:"4",7:"5"]
        cuentaInstance.properties = params
        return [cuentaInstance: cuentaInstance,clases:clases,padre:padre,limites:limites]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
//        println "save "+params
        def cuentaInstance = new Cuenta()
        if (params.id) {
            cuentaInstance = Cuenta.findByNumeroAndEmpresa(params.id,session.empresa)
            if (!cuentaInstance) {
                render "ERROR*No se encontró Cuenta."
                return
            }
        }
        if(params.prefijo!="")
            params.numero=params.prefijo+params.numero
        cuentaInstance.properties = params
        cuentaInstance.empresa=session.empresa
        if(!params.id)
            cuentaInstance.creacion=new Date()
        if (!cuentaInstance.save(flush: true)) {
            flash.message="Error"
            println "error save cuenta "+cuentaInstance.errors
            redirect(action: "arbol")
            return
        }
        flash.message="Datos guardados"
        redirect(action: "arbol")
        return
    } //save para grabar desde ajax

    def verificaNumero_ajax(){
        println "verfifica "+params
        def num = params.id
        def cuentas = Cuenta.findAllByNumeroAndEmpresa(num,session.empresa)
        if(cuentas.size()>0){
            render "error"
        }else{
            render "ok"
        }
        return
    }

    def buscarCuenta(){
        println "search "+params
        def cuentas = Cuenta.withCriteria {
            eq("empresa",session.empresa)
            or{
                ilike("numero","%"+params.str+"%")
                ilike("descripcion","%"+params.str+"%")
            }
        }
        // println "cuentas "+cuentas
        def res = []
        cuentas.each {c->
            //println "cuenta "+c
            def cu = c
            while (cu.padre!=null){

                cu=Cuenta.findByNumeroAndEmpresa(cu.padre,session.empresa)
                if(!cu)
                    break
                else {
                    if (!res.contains(cu.numero) && cu.agrupa==2)
                        res.add(cu.numero)
                }
            }
        }
        res=res.sort()
        def str ='["0"'
        if(res.size()>0)
            str+=","
        res.eachWithIndex {r,i->
            str+='"'+r.trim()+'"'
            if(i<res.size()-1)
                str+=","
        }
        str+="]"
        println str
        render str
    }



    def fixCuentas(){
        Cuenta.list([sort: "nivel"]).each {c->
            if(c.nivel>1){
                println "------------- cuenta "+c.numero
                def numero
                switch (c.nivel){
                    case 2:
                        numero=c.numero.trim().substring(0,1)
                        break;
                    case 3:
                        numero=c.numero.trim().substring(0,2)
                        break;
                    case 4:
                        numero=c.numero.trim().substring(0,3)
                        break;
                    case 5:
                        numero=c.numero.trim().substring(0,5)
                        break;
                    case 6:
                        numero=c.numero.trim().substring(0,6)
                        break;
                    default:
                        println "WTF "+c.nivel
                        break

                }
                println "numero "+numero
                def padre = Cuenta.findByNumero(numero)
                println "padre "+padre
                if(padre){
                    c.padre=padre.numero.trim()
                    if(!c.save(flush: true))
                        println "error save cuenta "+c.errors
                }

            }
        }
    }

}
