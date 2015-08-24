package contable.nomina

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Variable
 */
class VariableController extends Shield {

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
            def c = Variable.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                    ilike("sql", "%" + params.search + "%")
                }
            }
        } else {
            list = Variable.list(params)
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
        def variableInstanceList = getList(params, false)
        def variableInstanceCount = getList(params, true).size()
        return [variableInstanceList: variableInstanceList, variableInstanceCount: variableInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def variableInstance = Variable.get(params.id)
            if (!variableInstance) {
                render "ERROR*No se encontró Variable."
                return
            }
            return [variableInstance: variableInstance]
        } else {
            render "ERROR*No se encontró Variable."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def variableInstance = new Variable()
        if (params.id) {
            variableInstance = Variable.get(params.id)
            if (!variableInstance) {
                render "ERROR*No se encontró Variable."
                return
            }
        }
        variableInstance.properties = params
        return [variableInstance: variableInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def variableInstance = new Variable()
        if (params.id) {
            variableInstance = Variable.get(params.id)
            if (!variableInstance) {
                render "ERROR*No se encontró Variable."
                return
            }
        }
        variableInstance.properties = params
        if (!variableInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Variable: " + renderErrors(bean: variableInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Variable exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def variableInstance = Variable.get(params.id)
            if (!variableInstance) {
                render "ERROR*No se encontró Variable."
                return
            }
            try {
                variableInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Variable exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Variable"
                return
            }
        } else {
            render "ERROR*No se encontró Variable."
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
            def obj = Variable.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Variable.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Variable.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
