package contable.nomina

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Prestamo
 */
class PrestamoController extends Shield {

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

}
