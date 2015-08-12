package contable.core

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Banco
 */
class BancoController extends Shield {

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
            def c = Banco.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                    ilike("numero", "%" + params.search + "%")
                    ilike("tipo", "%" + params.search + "%")
                    ilike("usuario", "%" + params.search + "%")
                }
            }
        } else {
            list = Banco.list(params)
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
        def bancoInstanceList = getList(params, false)
        def bancoInstanceCount = getList(params, true).size()
        return [bancoInstanceList: bancoInstanceList, bancoInstanceCount: bancoInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def bancoInstance = Banco.findByCodigo(params.id)
            if (!bancoInstance) {
                render "ERROR*No se encontró Banco."
                return
            }
            return [bancoInstance: bancoInstance]
        } else {
            render "ERROR*No se encontró Banco."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def bancoInstance = new Banco()
        if (params.id) {
            bancoInstance = Banco.findByCodigo(params.id)
            if (!bancoInstance) {
                render "ERROR*No se encontró Banco."
                return
            }
        }
        bancoInstance.properties = params
        def cuentas =  Cuenta.findAllByAgrupa(1,[sort:"numero"])
        return [bancoInstance: bancoInstance,cuentas:cuentas]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def bancoInstance = new Banco()
        if (params.id) {
            bancoInstance = Banco.findByCodigo(params.id)
            if (!bancoInstance) {
                render "ERROR*No se encontró Banco."
                return
            }
        }
        bancoInstance.properties = params
        bancoInstance.usuario=session.usuario.login
        if (!bancoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Banco: " + renderErrors(bean: bancoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Banco exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def bancoInstance = Banco.findByCodigo(params.id)
            if (!bancoInstance) {
                render "ERROR*No se encontró Banco."
                return
            }
            try {
                bancoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Banco exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Banco"
                return
            }
        } else {
            render "ERROR*No se encontró Banco."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigo
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigo_ajax() {
        params.id = params.id.toString().trim()
        if (params.id) {
            def obj = Banco.findByCodigo(params.id)
            if (obj.codigo.toLowerCase() == params.id.toLowerCase()) {
                render true
                return
            } else {
                render Banco.countByCodigoIlike(params.id) == 0
                return
            }
        } else {
            render Banco.countByCodigoIlike(params.id) == 0
            return
        }
    }

}
