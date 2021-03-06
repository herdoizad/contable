package contable.nomina

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de DetalleRol
 */
class DetalleRolController extends Shield {

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
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = DetalleRol.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                    ilike("usuario", "%" + params.search + "%")
                }
            }
        } else {
            list = DetalleRol.list(params)
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
        def detalleRolInstanceList = getList(params, false)
        def detalleRolInstanceCount = getList(params, true).size()
        return [detalleRolInstanceList: detalleRolInstanceList, detalleRolInstanceCount: detalleRolInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def detalleRolInstance = DetalleRol.get(params.id)
            if (!detalleRolInstance) {
                render "ERROR*No se encontró DetalleRol."
                return
            }
            return [detalleRolInstance: detalleRolInstance]
        } else {
            render "ERROR*No se encontró DetalleRol."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def detalleRolInstance = new DetalleRol()
        if (params.id) {
            detalleRolInstance = DetalleRol.get(params.id)
            if (!detalleRolInstance) {
                render "ERROR*No se encontró DetalleRol."
                return
            }
        }
        detalleRolInstance.properties = params
        return [detalleRolInstance: detalleRolInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def detalleRolInstance = new DetalleRol()
        if (params.id) {
            detalleRolInstance = DetalleRol.get(params.id)
            if (!detalleRolInstance) {
                render "ERROR*No se encontró DetalleRol."
                return
            }
        }
        detalleRolInstance.properties = params
        if (!detalleRolInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar DetalleRol: " + renderErrors(bean: detalleRolInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de DetalleRol exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def detalleRolInstance = DetalleRol.get(params.id)
            if (!detalleRolInstance) {
                render "ERROR*No se encontró DetalleRol."
                return
            }
            try {
                detalleRolInstance.delete(flush: true)
                render "SUCCESS*Eliminación de DetalleRol exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar DetalleRol"
                return
            }
        } else {
            render "ERROR*No se encontró DetalleRol."
            return
        }
    } //delete para eliminar via ajax

}
