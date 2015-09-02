package contable.nomina

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de PrevisionGastos
 */
class PrevisionGastosController extends Shield {

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
            def c = PrevisionGastos.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                }
            }
        } else {
            if(empleado)
                list=PrevisionGastos.findAllByEmpleado(empleado)
            else
                list = PrevisionGastos.list(params)
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
        def previsionGastosInstanceList = getList(params, false)
        def previsionGastosInstanceCount = getList(params, true).size()
        def empleado=null
        if(params.empleado)
            empleado =   Empleado.get(params.empleado)
        return [previsionGastosInstanceList: previsionGastosInstanceList, previsionGastosInstanceCount: previsionGastosInstanceCount,empleado:empleado]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def previsionGastosInstance = PrevisionGastos.get(params.id)
            if (!previsionGastosInstance) {
                render "ERROR*No se encontró PrevisionGastos."
                return
            }
            return [previsionGastosInstance: previsionGastosInstance]
        } else {
            render "ERROR*No se encontró PrevisionGastos."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def previsionGastosInstance = new PrevisionGastos()
        if (params.id) {
            previsionGastosInstance = PrevisionGastos.get(params.id)
            if (!previsionGastosInstance) {
                render "ERROR*No se encontró PrevisionGastos."
                return
            }
        }
        previsionGastosInstance.properties = params
        def empleado = null
        if(params.empleado && params.empleado!=""){
            empleado=Empleado.get(params.empleado)
        }
        return [previsionGastosInstance: previsionGastosInstance,empleado: empleado]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def previsionGastosInstance = new PrevisionGastos()
        if (params.id) {
            previsionGastosInstance = PrevisionGastos.get(params.id)
            if (!previsionGastosInstance) {
                render "ERROR*No se encontró PrevisionGastos."
                return
            }
        }
        previsionGastosInstance.properties = params
        if (!previsionGastosInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar PrevisionGastos: " + renderErrors(bean: previsionGastosInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de PrevisionGastos exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def previsionGastosInstance = PrevisionGastos.get(params.id)
            if (!previsionGastosInstance) {
                render "ERROR*No se encontró PrevisionGastos."
                return
            }
            try {
                previsionGastosInstance.delete(flush: true)
                render "SUCCESS*Eliminación de PrevisionGastos exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar PrevisionGastos"
                return
            }
        } else {
            render "ERROR*No se encontró PrevisionGastos."
            return
        }
    } //delete para eliminar via ajax

}
