package contable.nomina

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de MesNomina
 */
class MesNominaController extends Shield {

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
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 12
        params.offset = params.offset ?: 0
        params.sort="codigo"
        params.order="desc"
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = MesNomina.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = MesNomina.list(params)
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
        def mesNominaInstanceList = getList(params, false)
        def mesNominaInstanceCount = getList(params, true).size()
        return [mesNominaInstanceList: mesNominaInstanceList, mesNominaInstanceCount: mesNominaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def mesNominaInstance = MesNomina.get(params.id)
            if (!mesNominaInstance) {
                render "ERROR*No se encontró MesNomina."
                return
            }
            return [mesNominaInstance: mesNominaInstance]
        } else {
            render "ERROR*No se encontró MesNomina."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def mesNominaInstance = new MesNomina()
        if (params.id) {
            mesNominaInstance = MesNomina.get(params.id)
            if (!mesNominaInstance) {
                render "ERROR*No se encontró MesNomina."
                return
            }
        }
        mesNominaInstance.properties = params
        return [mesNominaInstance: mesNominaInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def mesNominaInstance = new MesNomina()
        if (params.id) {
            mesNominaInstance = MesNomina.get(params.id)
            if (!mesNominaInstance) {
                render "ERROR*No se encontró MesNomina."
                return
            }
        }
        mesNominaInstance.properties = params
        if (!mesNominaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar MesNomina: " + renderErrors(bean: mesNominaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de MesNomina exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def mesNominaInstance = MesNomina.get(params.id)
            if (!mesNominaInstance) {
                render "ERROR*No se encontró MesNomina."
                return
            }
            try {
                mesNominaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de MesNomina exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar MesNomina"
                return
            }
        } else {
            render "ERROR*No se encontró MesNomina."
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
            def obj = MesNomina.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render MesNomina.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render MesNomina.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
