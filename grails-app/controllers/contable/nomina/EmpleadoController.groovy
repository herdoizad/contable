package contable.nomina

import contable.core.Cuenta
import contable.nomina.Capacitacion
import contable.nomina.CargaFamiliar
import contable.nomina.Contrato
import contable.nomina.Empleado
import contable.nomina.Sueldo
import contable.seguridad.Shield

class EmpleadoController extends Shield {

    def index() {

    }

    def nuevoEmpleado(){
        def empleado
        def sueldo = null
        if(params.id){
            empleado=Empleado.get(params.id)
            sueldo = Sueldo.findByEmpleadoAndFinIsNull(empleado)
            if(!sueldo){
                sueldo=Sueldo.findAllByEmpleado(empleado,[sort:"fin"])
                if(sueldo.size()>0)
                    sueldo=sueldo.pop()
                else
                    sueldo=null
            }


        }else{
            empleado=new Empleado(params)
        }
        [empleado:empleado,sueldo:sueldo]
    }

    def saveEmpleado_ajax(){
        def empleado
        params.nombre=params.nombre.toUpperCase()
        params.apellido=params.apellido.toUpperCase()
        params.nacionalidad=params.nacionalidad.toUpperCase()
        params.direccion=params.direccion.toUpperCase()
        params.cargo=params.cargo.toUpperCase()
        params.fechaNacimiento = new Date().parse("dd-MM-yyyy",params.fechaNacimiento_input)
        if(params.id){
            empleado=Empleado.get(params.id)
            empleado.properties=params
        }else{
            empleado=new Empleado(params)
        }
        if(params.cuentaContable.id!=""){

            empleado.cuentaContable=Cuenta.findByNumeroAndEmpresa(params.cuentaContable.id,session.empresa)
//            println "entro "+empleado.cuentaContable
        }
        if(!empleado.save(flush: true)){
            println "error save empleado "+empleado.errors
            flash.obj = empleado
            flash.message="Error al guardar el empleado. Por favor, corrija la información ingresada"
        }else{
            flash.message="Datos guardados"
        }

        try{
            if(params.sueldoId){
                def sueldo = Sueldo.get(params.sueldoId)
                def s = params.sueldo.toDouble()
                if(s!=sueldo.sueldo){
                    sueldo.fin=new Date()
                    sueldo.save()
                    def ns = new Sueldo()
                    ns.empleado=empleado
                    ns.sueldo=s
                    ns.inicio=new Date()
                    ns.save(flush: true)
                }else{
                    if(params.sueldoInicio_input)
                        sueldo.inicio=new Date().parse("dd-MM-yyyy",params.sueldoInicio_input)
                    else
                        sueldo.inicio=new Date()
                    if(params.sueldoFin_input)
                        sueldo.fin=new Date().parse("dd-MM-yyyy",params.sueldoFin_input)
                    sueldo.save(flush: true)
                }
            }else{
                if(params.sueldo!=""){
                    def sueldo = new Sueldo()
                    sueldo.empleado=empleado
                    sueldo.sueldo=params.sueldo.toDouble()
                    if(params.sueldoInicio_input)
                        sueldo.inicio=new Date().parse("dd-MM-yyyy",params.sueldoInicio_input)
                    else
                        sueldo.inicio=new Date()
                    if(params.sueldoFin_input)
                        sueldo.fin=new Date().parse("dd-MM-yyyy",params.sueldoFin_input)
                    sueldo.save(flush: true)
                }
            }
        }catch (e){
            println "error sueldo "+e
        }



        redirect(action: 'nuevoEmpleado',id: empleado.id)
    }

    def capacitacion(){
        if(!params.id)
            response.sendError(403)
        def  empleado=Empleado.get(params.id)
        def caps = Capacitacion.findAllByEmpleado(empleado)
        [empleado:empleado,caps:caps]
    }

    def cargas(){
        if(!params.id)
            response.sendError(403)
        def  empleado=Empleado.get(params.id)
        def cargas = CargaFamiliar.findAllByEmpleado(empleado)
        [empleado:empleado,cargas:cargas]
    }
    def contratos(){
        if(!params.id)
            response.sendError(403)
        def  empleado=Empleado.get(params.id)
        def contratos = Contrato.findAllByEmpleado(empleado)
        [empleado:empleado,contratos:contratos]
    }

    def saveCap_ajax(){
//        println "saveCap_ajax "+params
        def empleado = Empleado.get(params.empleado.id)
        def cap = new Capacitacion()
        if(params.id)
            cap=Capacitacion.get(params.id)
        cap.properties=params
        def f = request.getFile('archivo')
        def ext2
        if(f && !f.empty){

            def nombre = f.getOriginalFilename()
            def parts2 = nombre.split("\\.")
            nombre = ""
            parts2.eachWithIndex { obj, i ->
                if (i < parts2.size() - 1) {
                    nombre += obj
                } else {
                    ext2 = obj
                }
            }
            def path = servletContext.getRealPath("/") + "hojasDeVida/" + empleado.cedula + "/"
            def pathLocal = "hojasDeVida/" + empleado.cedula + "/"
            if(ext2 == 'pdf' || ext2 == 'PDF'){
                /* upload */
                new File(path).mkdirs()
                if (f && !f.empty) {

                    def fileName = f.getOriginalFilename()
                    def ext

                    def parts = fileName.split("\\.")
                    fileName = ""
                    parts.eachWithIndex { obj, i ->
                        if (i < parts.size() - 1) {
                            fileName += obj
                        }
                    }
                    def name = "capacitacion_" + empleado.cedula+"_"+new Date().format("ddMMyyyyHHssmm")+"."+ext2
                    def pathFile = path + name
                    def fn = fileName
                    def src = new File(pathFile)
                    def i = 1
                    while (src.exists()) {
                        nombre = fn + "_" + i + "." + ext2
                        pathFile = path + nombre
                        src = new File(pathFile)
                        i++
                    }
                    try {
                        f.transferTo(new File(pathFile))
                        cap.path=pathLocal+name


                    } catch (e) {
                        println "????????\n" + e + "\n???????????"
                    }
                }

            }

        }
        if(!cap.save(flush: true))
            println "error cap "+cap.errors
        flash.message="Datos guardados"
        redirect(action: "capacitacion",id: empleado.id)
    }

    def subirArchivo_ajax(){
        def f = request.getFile('hojaDeVida')
        def empleado = Empleado.get(params.id)
        def ext2
        if(f && !f.empty){
            println "no es empty "+f
            def nombre = f.getOriginalFilename()
            def parts2 = nombre.split("\\.")
            nombre = ""
            parts2.eachWithIndex { obj, i ->
                if (i < parts2.size() - 1) {
                    nombre += obj
                } else {
                    ext2 = obj
                }
            }
            def path = servletContext.getRealPath("/") + "hojasDeVida/" + empleado.cedula + "/"
            def pathLocal = "hojasDeVida/" + empleado.cedula + "/"
            if(ext2 == 'pdf' || ext2 == 'PDF'){
                /* upload */
                new File(path).mkdirs()
                if (f && !f.empty) {

                    def fileName = f.getOriginalFilename()
                    def ext

                    def parts = fileName.split("\\.")
                    fileName = ""
                    parts.eachWithIndex { obj, i ->
                        if (i < parts.size() - 1) {
                            fileName += obj
                        }
                    }
                    def name = "hojaDeVida_" + empleado.cedula+"_"+new Date().format("ddMMyyyyHHssmm")+"."+ext2
                    def pathFile = path + name
                    def fn = fileName
                    def src = new File(pathFile)
                    def i = 1
                    while (src.exists()) {
                        nombre = fn + "_" + i + "." + ext2
                        pathFile = path + nombre
                        src = new File(pathFile)
                        i++
                    }
                    try {
                        f.transferTo(new File(pathFile))
                        empleado.path=pathLocal+name
                        empleado.save(flush: true)

                    } catch (e) {
                        println "????????\n" + e + "\n???????????"
                    }
                }
                flash.message = 'El archivo cargado correctamente'
                flash.estado = "success"
                flash.icon = "alert"
                redirect(action: 'capacitacion',id: empleado.id)
                return

            }else{
                flash.message = 'El archivo a cargar debe ser del tipo PDF'
                flash.estado = "error"
                flash.icon = "alert"
                redirect(action: 'capacitacion',id: empleado.id)
                return
            }
        }else{
            flash.message = 'No se ha seleccionado ningun archivo para cargar'
            flash.estado = "error"
            flash.icon = "alert"
            redirect(action: 'capacitacion',id: empleado.id)
            return
        }
    }


    def saveCar_ajax(){
        def empleado = Empleado.get(params.empleado.id)
        def car = new CargaFamiliar()
        if(params.id)
            car=CargaFamiliar.get(params.id)
        car.properties=params
        if(!car.inicio)
            car.inicio=new Date()


        def f = request.getFile('archivo')
        def ext2
        if(f && !f.empty){

            def nombre = f.getOriginalFilename()
            def parts2 = nombre.split("\\.")
            nombre = ""
            parts2.eachWithIndex { obj, i ->
                if (i < parts2.size() - 1) {
                    nombre += obj
                } else {
                    ext2 = obj
                }
            }
            def path = servletContext.getRealPath("/") + "cargas/" + empleado.cedula + "/"
            def pathLocal = "cargas/" + empleado.cedula + "/"
            if(ext2 == 'pdf' || ext2 == 'PDF'){
                /* upload */
                new File(path).mkdirs()
                if (f && !f.empty) {

                    def fileName = f.getOriginalFilename()
                    def ext

                    def parts = fileName.split("\\.")
                    fileName = ""
                    parts.eachWithIndex { obj, i ->
                        if (i < parts.size() - 1) {
                            fileName += obj
                        }
                    }
                    def name = "carga_" + empleado.cedula+"_"+new Date().format("ddMMyyyyHHssmm")+"."+ext2
                    def pathFile = path + name
                    def fn = fileName
                    def src = new File(pathFile)
                    def i = 1
                    while (src.exists()) {
                        nombre = fn + "_" + i + "." + ext2
                        pathFile = path + nombre
                        src = new File(pathFile)
                        i++
                    }
                    try {
                        f.transferTo(new File(pathFile))
                        car.path=pathLocal+name


                    } catch (e) {
                        println "????????\n" + e + "\n???????????"
                    }
                }

            }

        }



        if(!car.save(flush: true))
            println "error save car "+car.errors
        redirect(action: 'cargas',id: empleado.id)

    }

    def saveCon_ajax(){
        flash.message=""

        def empleado = Empleado.get(params.empleado.id)
        def cap = new Contrato()
        if(params.fin_input==""){
            params.remove("fin_day")
            params.remove("fin_month")
            params.remove("fin_year")
            params.remove("fin")
            params.remove("fin_input")
            params["fin"]=null
        }
        println "saveCon_ajax "+params
        if(params.id)
            cap=Contrato.get(params.id)
        cap.properties=params
        def f = request.getFile('archivo')
        def ext2
        if(f && !f.empty){

            def nombre = f.getOriginalFilename()
            def parts2 = nombre.split("\\.")
            nombre = ""
            parts2.eachWithIndex { obj, i ->
                if (i < parts2.size() - 1) {
                    nombre += obj
                } else {
                    ext2 = obj
                }
            }
            def path = servletContext.getRealPath("/") + "contratos/" + empleado.cedula + "/"
            def pathLocal = "contratos/" + empleado.cedula + "/"
            if(ext2 == 'pdf' || ext2 == 'PDF'){
                /* upload */
                new File(path).mkdirs()
                if (f && !f.empty) {

                    def fileName = f.getOriginalFilename()
                    def ext

                    def parts = fileName.split("\\.")
                    fileName = ""
                    parts.eachWithIndex { obj, i ->
                        if (i < parts.size() - 1) {
                            fileName += obj
                        }
                    }
                    def name = "contrato_" + empleado.cedula+"_"+new Date().format("ddMMyyyyHHssmm")+"."+ext2
                    def pathFile = path + name
                    def fn = fileName
                    def src = new File(pathFile)
                    def i = 1
                    while (src.exists()) {
                        nombre = fn + "_" + i + "." + ext2
                        pathFile = path + nombre
                        src = new File(pathFile)
                        i++
                    }
                    try {
                        f.transferTo(new File(pathFile))
                        cap.path=pathLocal+name


                    } catch (e) {
                        println "????????\n" + e + "\n???????????"
                    }
                }

            }

        }
        if(!cap.save(flush: true))
            println "error cap "+cap.errors
        else{
            def rubrosContrato = RubroContrato.findAllByTipoContrato(cap.tipo)
            if(rubrosContrato.size()==0) {
                flash.tipo = "warning"
                flash.message = "El tipo de contrato ${cap.tipo.descripcion} no tiene rubros asignados. Se deberá asignar manualmente los rubros del empleado ${cap.empleado} antes de generar el rol"
            }
//            rubrosContrato.each {rc->
//                def r = RubroEmpleado.findByRubroAndEmpleado(rc.rubro,cap.empleado)
//                if(!r){
//                    r = new RubroEmpleado()
//                    r.empleado=cap.empleado
//                    if(rc.mes)
//                        r.mes=rc.mes
//                    else
//                        r.mes=0
//                    r.inicio=cap.empleado.registro
//                    r.rubro=rc.rubro
//                    r.save(flush: true)
//                }
//            }
        }
        if(flash.message=="")
            flash.message="Datos guardados"
        redirect(action: "contratos",id: empleado.id)
    }

    def sueldos_ajax(){
//        println "sueldos "+params
        def empleado = Empleado.get(params.id)
        def sueldos = Sueldo.findAllByEmpleado(empleado,[sort:"id"])
        [sueldos: sueldos,empleado: empleado]
    }

    def desactivar_ajax(){
        def emp = Empleado.get(params.id.replaceAll("e",""))
        emp.estado="D"
        emp.save(flush: true)
        render "ok"
    }

    def activar_ajax(){
        def emp = Empleado.get(params.id.replaceAll("e",""))
        emp.estado="A"
        emp.save(flush: true)
        render "ok"
    }


    def fotoEmpleado(){
        def empleado = Empleado.get(params.id)
        [empleado:empleado]
    }



    def saveFoto_ajax(){
        def empleado = Empleado.get(params.id)
        def f = request.getFile('file')
        def ext2
        if(f && !f.empty){

            def nombre = f.getOriginalFilename()
            def parts2 = nombre.split("\\.")
            nombre = ""
            parts2.eachWithIndex { obj, i ->
                if (i < parts2.size() - 1) {
                    nombre += obj
                } else {
                    ext2 = obj
                }
            }
            ext2=ext2.toUpperCase()
            def path = servletContext.getRealPath("/") + "fotos/"
            def pathLocal = "fotos/"
            if(ext2 == 'JPG' || ext2 == 'JPEG' || ext2=="PNG"){
                /* upload */
                new File(path).mkdirs()
                if (f && !f.empty) {

                    def fileName = f.getOriginalFilename()
                    def ext

                    def parts = fileName.split("\\.")
                    fileName = ""
                    parts.eachWithIndex { obj, i ->
                        if (i < parts.size() - 1) {
                            fileName += obj
                        }
                    }
                    def name = "foto_" + empleado.cedula+"_"+new Date().format("ddMMyyyyHHssmm")+"."+ext2
                    def pathFile = path + name
                    def fn = fileName
                    def src = new File(pathFile)
                    def i = 1
                    while (src.exists()) {
                        nombre = fn + "_" + i + "." + ext2
                        pathFile = path + nombre
                        src = new File(pathFile)
                        i++
                    }
                    try {
                        f.transferTo(new File(pathFile))
                        empleado.foto=pathLocal+name
                        empleado.save(flush: true)

                    } catch (e) {
                        println "????????\n" + e + "\n???????????"
                    }
                }

            }

        }

        redirect(action: "fotoEmpleado",id: empleado.id)
    }
}
