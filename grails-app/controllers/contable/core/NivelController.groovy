package contable.core

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Nivel
 */
class NivelController extends Shield {

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
            def c = Nivel.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("nivelDesc1", "%" + params.search + "%")
                    ilike("nivelDesc2", "%" + params.search + "%")
                    ilike("nivelDesc3", "%" + params.search + "%")
                    ilike("nivelDesc4", "%" + params.search + "%")
                    ilike("nivelDesc5", "%" + params.search + "%")
                    ilike("nivelDesc6", "%" + params.search + "%")
                    ilike("usuario", "%" + params.search + "%")
                }
            }
        } else {
            list = Nivel.list(params)
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
        def nivelInstanceList = getList(params, false)
        def nivelInstanceCount = getList(params, true).size()
        return [nivelInstanceList: nivelInstanceList, nivelInstanceCount: nivelInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def nivelInstance = Nivel.findByCodigo(params.id)
            if (!nivelInstance) {
                render "ERROR*No se encontró Nivel."
                return
            }
            return [nivelInstance: nivelInstance]
        } else {
            render "ERROR*No se encontró Nivel."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def nivelInstance = new Nivel()
        if (params.id) {
            nivelInstance = Nivel.findByCodigo(params.id)
            if (!nivelInstance) {
                render "ERROR*No se encontró Nivel."
                return
            }
        }
        nivelInstance.properties = params
        return [nivelInstance: nivelInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def nivelInstance = new Nivel()
        if (params.id) {
            nivelInstance = Nivel.findByCodigo(params.id)
            if (!nivelInstance) {
                render "ERROR*No se encontró Nivel."
                return
            }
        }
        nivelInstance.properties = params
        nivelInstance.usuario=session.usuario.login
        if(!nivelInstance.creacion)
            nivelInstance.creacion=new Date()
        if (!nivelInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Nivel: " + renderErrors(bean: nivelInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Nivel exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def nivelInstance = Nivel.findByCodigo(params.id)
            if (!nivelInstance) {
                render "ERROR*No se encontró Nivel."
                return
            }
            try {
                nivelInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Nivel exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Nivel"
                return
            }
        } else {
            render "ERROR*No se encontró Nivel."
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
            def obj = Nivel.findByCodigo(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Nivel.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Nivel.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
