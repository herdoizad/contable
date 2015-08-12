package contable.core

import org.springframework.dao.DataIntegrityViolationException
import contable.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Empresa
 */
class EmpresaController extends Shield {

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
            def c = Empresa.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("casilla", "%" + params.search + "%")
                    ilike("cedulaContador", "%" + params.search + "%")
                    ilike("cedulaRepresentante", "%" + params.search + "%")
                    ilike("codigo", "%" + params.search + "%")
                    ilike("comodin", "%" + params.search + "%")
                    ilike("contador", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                    ilike("direccion", "%" + params.search + "%")
                    ilike("email", "%" + params.search + "%")
                    ilike("fax", "%" + params.search + "%")
                    ilike("moneda", "%" + params.search + "%")
                    ilike("principal", "%" + params.search + "%")
                    ilike("representante", "%" + params.search + "%")
                    ilike("ruc", "%" + params.search + "%")
                    ilike("telefono", "%" + params.search + "%")
                    ilike("tipoRepresentante", "%" + params.search + "%")
                }
            }
        } else {
            list = Empresa.list(params)
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
        println "lista  "
        def empresaInstanceList = getList(params, false)
        def empresaInstanceCount = getList(params, true).size()
        return [empresaInstanceList: empresaInstanceList, empresaInstanceCount: empresaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def empresaInstance = Empresa.findByCodigo(params.id)
            if (!empresaInstance) {
                render "ERROR*No se encontró Empresa."
                return
            }
            return [empresaInstance: empresaInstance]
        } else {
            render "ERROR*No se encontró Empresa."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def empresaInstance = new Empresa()
        if (params.id) {
            empresaInstance = Empresa.findByCodigo(params.id)
            if (!empresaInstance) {
                render "ERROR*No se encontró Empresa."
                return
            }
        }
        empresaInstance.properties = params
        return [empresaInstance: empresaInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def empresaInstance = new Empresa()
        if (params.id) {
            empresaInstance = Empresa.findByCodigo(params.id)
            if (!empresaInstance) {
                render "ERROR*No se encontró Empresa."
                return
            }
        }
        empresaInstance.properties = params
        if (!empresaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Empresa: " + renderErrors(bean: empresaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Empresa exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def empresaInstance = Empresa.findByCodigo(params.id)
            if (!empresaInstance) {
                render "ERROR*No se encontró Empresa."
                return
            }
            try {
                empresaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Empresa exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Empresa"
                return
            }
        } else {
            render "ERROR*No se encontró Empresa."
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
            def obj = Empresa.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Empresa.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Empresa.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad email
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_email_ajax() {
        params.email = params.email.toString().trim()
        if (params.id) {
            def obj = Empresa.get(params.id)
            if (obj.email.toLowerCase() == params.email.toLowerCase()) {
                render true
                return
            } else {
                render Empresa.countByEmailIlike(params.email) == 0
                return
            }
        } else {
            render Empresa.countByEmailIlike(params.email) == 0
            return
        }
    }

}
