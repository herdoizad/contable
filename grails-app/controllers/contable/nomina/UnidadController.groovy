package contable.nomina

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Unidad
 */
class UnidadController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }


    def arbol(){
        return [arbol: makeTree(params), params: params]
    }

    def loadTreePart_ajax() {
//        println "load parte "+params
        render(imprimeHijos(params))
//        println "acabo"
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
        println "params arbol "+params
        def txt = ""

        def hijos
        if(params.id=="#") {
            def padres = Unidad.findAllByPadreIsNull()
            padres.each {p->
                txt += "<li id='${p.id}' data-level='0' class='root jstree-closed hasChildren' data-jstree='{\"type\":\"pys\"}'>"
                txt += "<a href='#' class='label_arbol'>${p.nombre}</a>"

                txt += "</li>"
            }

        } else {
            if(params.tipo=="dep" || params.tipo=="pys"){
                def unidad =Unidad.get(params.id)

                hijos = Unidad.findAllByPadre(unidad)

                hijos.each { h ->
                    def hi = Unidad.countByPadre(h)
                    hi+=Empleado.countByUnidad(h)
                    txt += "<ul>"
                    txt += "<li class='${hi > 0 ? 'hasChildren jstree-closed' : ''} ' id='${h.id}' data-jstree='{\"type\":\"dep\"}'>"
                    txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                    txt += h.nombre
                    txt += "</span></a>"
                    txt += "</li>"
                    txt += "</ul>"
                }

                def emps
                if(!params.state || params.state=="1")
                    emps= Empleado.findAllByUnidadAndEstado(unidad,"A",[sort:"apellido"])
                else
                    emps= Empleado.findAllByUnidadAndEstadoNotEqual(unidad,"A",[sort:"apellido"])
                if(emps.size()>0){
                    txt += "<ul>"
                }
                emps.each {e->
                    txt += "<li class='hasChildren jstree-closed emp ${e.estado=='A'?'':'inactivo'}  ' id='e${e.id}' data-jstree='{\"type\":\"empleado\"}'>"
                    txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                    txt += e.apellido + " "+e.nombre
                    txt += "</span></a>"
                    txt += "</li>"
                }
                if(emps.size()>0){
                    txt += "</ul>"
                }
            }
            if(params.tipo=="empleado"){
                def id = params.id.replaceAll("e","")
                txt += "<ul>"
                txt += "<li class='hasChildren jstree-closed' id='c${id}' data-jstree='{\"type\":\"cargas\"}'>"
                txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                txt += "Cargas familiares"
                txt += "</span></a>"
                txt += "</li>"
                txt += "<li class='hasChildren jstree-closed ' id='f${id}' data-jstree='{\"type\":\"contratos\"}'>"
                txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                txt += "Contratos"
                txt += "</span></a>"
                txt += "</li>"
                txt += "<li class='hasChildren jstree-closed' id='g${id}' data-jstree='{\"type\":\"capacitaciones\"}'>"
                txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                txt += "Instrucción"
                txt += "</span></a>"
                txt += "</li>"
                txt += "</ul>"
            }
            if(params.tipo=="cargas"){
                def id = params.id.replaceAll("c","")
                def empleado = Empleado.get(id)
                def cargas = CargaFamiliar.findAllByEmpleado(empleado)
                cargas.each {c->
                    txt += "<li class='car' id='ca${c.id}' data-jstree='{\"type\":\"carga\"}'  empleado='${empleado.id}'>"
                    txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                    txt += c.nombre+" "+c.apellido
                    txt += "</span></a>"
                    txt += "</li>"
                }
            }
            if(params.tipo=="contratos"){
                def id = params.id.replaceAll("f","")
                def empleado = Empleado.get(id)
                def cons = Contrato.findAllByEmpleado(empleado)
                cons.each {c->
                    txt += "<li class='con' id='co${c.id}' data-jstree='{\"type\":\"contrato\"}'   empleado='${empleado.id}'>"
                    txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                    txt += c.tipo.descripcion+" No."+c.numero
                    txt += "</span></a>"
                    txt += "</li>"
                }
            }
            if(params.tipo=="capacitaciones"){
                def id = params.id.replaceAll("g","")
                def empleado = Empleado.get(id)
                def caps = Capacitacion.findAllByEmpleado(empleado)
                caps.each {c->
                    txt += "<li class='cap' id='cp${c.id}' data-jstree='{\"type\":\"capacitacion\"}'  empleado='${empleado.id}' >"
                    txt += "<a href='#' ><span style='color:#006EB7;font-weight: bold'>"
                    txt += c.titulo
                    txt += "</span></a>"
                    txt += "</li>"
                }
            }


        }
        return  txt

    }


    def detalle_ajax(){
        def red =""
        switch (params.tipo){
            case "empleado":
                red="detalle_empleado_ajax"
                break;
            case "carga":
                red="detalle_carga_ajax"
                break;
            case "contrato":
                red="detalle_contrato_ajax"
                break;
            case "capacitacion":
                red="detalle_cap_ajax"
                break;
            case "dep":
                red="detalle_dep_ajax"
                break;
        }
        redirect(action: red,id: params.id)
        return
    }

    def detalle_empleado_ajax(){
        def id = params.id.replaceAll("e","")
        def empleado = Empleado.get(id)
        def sueldo = Sueldo.findAllByEmpleado(empleado,[sort:"inicio"])
        if(sueldo.size()>0)
            sueldo=sueldo.pop()
        else
            sueldo=null
        [empleado:empleado,sueldo:sueldo]
    }
    def detalle_carga_ajax(){
        println "params "+params
        def id = params.id.replaceAll("ca","")
        def carga = CargaFamiliar.get(id)
        [carga:carga]
    }

    def detalle_contrato_ajax(){
        def id = params.id.replaceAll("co","")
        def con = Contrato.get(id)
        [con:con]
    }

    def detalle_cap_ajax(){
        def id = params.id.replaceAll("cp","")
        def cap = Capacitacion.get(id)
        [cap:cap]
    }
    def detalle_dep_ajax(){

        def dep = Unidad.get(params.id)

        [dep:dep]
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
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Unidad.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("lugar", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                }
            }
        } else {
            list = Unidad.list(params)
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
        def unidadInstanceList = getList(params, false)
        def unidadInstanceCount = getList(params, true).size()
        return [unidadInstanceList: unidadInstanceList, unidadInstanceCount: unidadInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                render "ERROR*No se encontró Unidad."
                return
            }
            return [unidadInstance: unidadInstance]
        } else {
            render "ERROR*No se encontró Unidad."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def unidadInstance = new Unidad()
        if (params.id) {
            unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                render "ERROR*No se encontró Unidad."
                return
            }
        }
        unidadInstance.properties = params
        def padre = null
        if(params.padre){
            padre=Unidad.get(params.padre)
        }
        return [unidadInstance: unidadInstance,padre:padre]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def unidadInstance = new Unidad()
        if (params.id) {
            unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                render "ERROR*No se encontró Unidad."
                return
            }
        }
        unidadInstance.properties = params
        if (!unidadInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Unidad: " + renderErrors(bean: unidadInstance)
            return
        }
        redirect(action: 'arbol')
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def unidadInstance = Unidad.get(params.id)
            if (!unidadInstance) {
                render "ERROR*No se encontró Unidad."
                return
            }
            try {
                unidadInstance.delete(flush: true)
                render "ok"
                return
            } catch (DataIntegrityViolationException e) {
                render "Ha ocurrido un error al eliminar Unidad"
                return
            }
        } else {
            render "No se encontró Unidad."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigo
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigo_ajax() {
        params.codigo = params.codigo.toString().trim()
        if (params.id) {
            def obj = Unidad.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Unidad.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Unidad.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

    def cambiaDep_ajax(){
        def emp = Empleado.get(params.id.replaceAll("e",""))
        def dep = Unidad.get(params.padre)
        emp.unidad=dep
        emp.save(flush: true)
        render "ok"
    }

    def buscar_ajax(){
        println "search "+params
        def empleados = Empleado.withCriteria {
            or{
                ilike("nombre","%"+params.str+"%")
                ilike("apellido","%"+params.str+"%")
                ilike("cedula","%"+params.str+"%")
            }
        }
        // println "cuentas "+cuentas
        def res = []
        empleados.each {c->
            //println "cuenta "+c
            def u = c.unidad
            if (!res.contains(c.unidad.id))
                res.add(u.id)
            while (u.padre!=null){
                u=u.padre
                if (!res.contains(u.id))
                    res.add(u.id)

            }
        }
        res=res.sort()
        def str ='["0"'
        if(res.size()>0)
            str+=","
        res.eachWithIndex {r,i->
            str+='"'+r+'"'
            if(i<res.size()-1)
                str+=","
        }
        str+="]"
        println str
        render str
    }


    def cambiarFac_ajax(){
//        println "cambiar "+params
        def empleado = Empleado.get(params.id)
//        println "empleado "+empleado.sistemaDeFacturacion
        if(empleado.sistemaDeFacturacion=="S")
            empleado.sistemaDeFacturacion="N"
        else
            empleado.sistemaDeFacturacion="S"
        if(!empleado.save(flush: true))
            println "error "+empleado.errors
        redirect(action: 'detalle_empleado_ajax',id: empleado.id)
    }

}
