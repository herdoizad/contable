package contable.core

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Mes
 */
class MesController extends Shield {

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
        params.max = 20
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Mes.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                    ilike("estado", "%" + params.search + "%")
                    ilike("periodoSri", "%" + params.search + "%")
                    ilike("usuario", "%" + params.search + "%")
                }
            }
        } else {
            list = Mes.list(params)
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
        def mesInstanceList = getList(params, false)
        def mesInstanceCount = getList(params, true).size()
        return [mesInstanceList: mesInstanceList, mesInstanceCount: mesInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def mesInstance = Mes.findByCodigo(params.id)
            if (!mesInstance) {
                render "ERROR*No se encontró Mes."
                return
            }
            return [mesInstance: mesInstance]
        } else {
            render "ERROR*No se encontró Mes."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def mesInstance = new Mes()
        if (params.id) {
            mesInstance = Mes.findByCodigo(params.id)
            if (!mesInstance) {
                render "ERROR*No se encontró Mes."
                return
            }
        }else{
            def last = Mes.list([sort: "codigo",order: "desc",max: 1])
            if(last.size()>0){
                last=last.pop()
                last=last.codigo.toString()
                def anio = last[0..3].toInteger()
                def mes = last[4..5].toInteger()
                if(mes==12){
                    mes="01"
                    anio=anio+1
                }else{
                    mes=mes+1
                }
                def inicio = new Date().parse("ddMMyyyy","01${mes}${anio}")
                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.MONTH, inicio.format("MM").toInteger()-1);
                cal.set(Calendar.YEAR, anio.toInteger());
                cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
                cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
                def fin  = cal.getTime();
//            println "last "+last+"  "+anio+"  "+mes+" "+inicio+"  "+fin
                mesInstance.codigo=(""+anio+mes).toInteger()
                mesInstance.inicio=inicio
                mesInstance.estado="A"
                mesInstance.fin=fin
            }

        }
        mesInstance.properties = params
        return [mesInstance: mesInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def mesInstance = new Mes()
        if (params.id) {
            mesInstance = Mes.findByCodigo(params.id)
            if (!mesInstance) {
                render "ERROR*No se encontró Mes."
                return
            }
        }
        mesInstance.properties = params
        mesInstance.usuario=session.usuario.login
        mesInstance.empresa=session.empresa
        if(mesInstance.creacion==null)
            mesInstance.creacion=new Date()
        if (!mesInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Mes: " + renderErrors(bean: mesInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Mes exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def mesInstance = Mes.findByCodigo(params.id)
            if (!mesInstance) {
                render "ERROR*No se encontró Mes."
                return
            }
            try {
                mesInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Mes exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Mes"
                return
            }
        } else {
            render "ERROR*No se encontró Mes."
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
            def obj = Mes.findByCodigo(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Mes.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Mes.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
