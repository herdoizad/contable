package contable

import contable.seguridad.Permiso


class MenuTagLib {
//    static defaultEncodeAs = 'html'
    //static encodeAsForTags = [tagName: 'raw']

    static namespace = 'mn'

    def barraTop = {attrs->
        def titulo = attrs['titulo']
        def html = '<nav class="default navbar">\n' +
                '    <div class="row">\n' +
                '        <div class="col-md-1 col-xs-2 col-sm-1" style="width: 50px">\n' +
                '            <a href="#" class="btn btn-verde " id="control-menu">\n' +
                '                <i class="fa fa-bars"></i>\n' +
                '            </a>\n' +
                '        </div>\n' +
                '        <div class="col-md-2 hidden-xs hidden-md">\n' +
                '          <img src="'+resource(dir: 'images/favicons',file: 'favicon-32x32.png')+'">\n' +
                '            <span style="color: #006EB7">Petroleos y Servicios</span>\n' +
                '        </div>\n' +
                '        <div class="col-md-4 titulo hidden-sm hidden-xs ">\n' +titulo+
                '        </div>\n' +
                '        <div class="col-md-2 hidden-xs text-right" style="margin-top: 10px">\n' +
                '          <li class="fa fa-user"></li> ' +session.usuario.login+
                '        </div>\n' +
                '        <div class="col-md-1 hidden-xs" style="width: 50px;margin-top: 10px">\n' +
                '            <a href="#" class="item" title="Alertas" >\n' +
                '                <i class="fa fa-bell"></i>\n' +
                '            </a>\n' +
                '        </div>\n' +
                '        <div class="col-md-1 col-xs-2 col-sm-2 " style="margin-top: 10px">\n' +
                '            <a href="'+g.createLink(controller: 'login',action: 'logout')+'" class="item" >\n' +
                '                <i class="fa fa-sign-out"></i> Salir\n' +
                '            </a>\n' +
                '        </div>\n' +
                '        <div class="col-md-1 col-xs-2 col-sm-2 " style="margin-top: 10px;text-align:rigth">\n' +
                '            <a href="'+g.createLink(controller: 'login',action: 'cambiaColor_ajax')+'" class="item cambiar-color"  >\n' +
                '                <i class="fa fa-desktop"></i>' +
                '            </a>\n' +
                '        </div>\n' +
                '    </div>\n' +
                '</nav>'
        out<<html
    }

    def stickyFooter = { attrs ->
        def html = ""
        html += "<footer class='footer ${attrs['class']}'>"
        html += "<div class='container text-center'>"
        html += "Petróleos y servicios - 2015 Todos los derechos reservados"
        html += "</div>"
        html += "</footer>"
        out << html
    }

    def bannerTop = { attrs ->

        def large = attrs.large ? "banner-top-lg" : ""

        def html = ""
        html += "<div class='banner-top ${large}'>"
        html += "<div class='banner-esquina'>"
        html += "</div>"
        html += "<div class='banner-title'>PETRÓLEOS Y SERVICIOS - Sistema documental de gestión ambiental integral</div>"
        html += "<div class='banner-logo'>"
        html += "</div>"
        html += "<div class='banner-esquina der'>"
        html += "</div>"

        html += "</div>"

        out << html
    }


    def menuVertical = {attrs->
        def permisos = Permiso.findAllByUsuario(session.usuario)
        def menu = [:]
        permisos.each {
            if(it.accion.tipo.codigo=="M"){
                if(!menu[it.accion.modulo.nombre]){
                    menu[it.accion.modulo.nombre]=[:]
                    menu[it.accion.modulo.nombre]["icono"]=it.accion.modulo.icono
                    menu[it.accion.modulo.nombre]["acciones"]=[it.accion]
                }else{
                    menu[it.accion.modulo.nombre]["acciones"].add(it.accion)
                }
            }

        }
        session.menu = menu
        def html = "<ul class=' menu-vertical${session.color}'>\n"
        session.menu.each{m->
            def acciones = ''
            def active =""
            m.value.acciones.each{a->
//                println " "+a.nombre+"  "+actionName+" --- "+a.control.nombre+"  "+controllerName
                if(actionName==a.nombre && controllerName.toLowerCase().trim()==a.control.nombre.toLowerCase().trim()) {
                    active = ""
                    acciones += ' <li class="' + active + '"><a href="' + g.createLink(controller: a.control.nombre, action: a.nombre) + '" class="active"> <i class="fa-menu ' + a.icono + '"></i> ' + a.descripcion + '</a></li>\n'
                }else{
                    acciones += ' <li class=""><a href="' + g.createLink(controller: a.control.nombre, action: a.nombre) + '" class=""> <i class="fa-menu ' + a.icono + '"></i> ' + a.descripcion + '</a></li>\n'
                }
            }
            html+=  '        <li class="menu-item'+session.color+'  dropdown '+active+'">\n'
            html+=  '            <a href="#" class="dropdown-toggle '+active+' " style="width:150px">\n'
            html+=  '                <i class="fa-menu '+m.value["icono"]+'"></i>\n'
            html+=  '                <span class="toggle-menu">'+m.key+'</span>\n'
            html+=  '                <span class="caret toggle-menu"></span></a>\n'
            html+=  '            <ul class="submenu'+session.color+' " style="margin-top: 0px">\n'
            html+=acciones
            html+=  '            </ul>\n'
            html+=  '        </li>\n'
        }
        html +=  '    </ul>'
        out<<html
//        def html = '<ul class="nav menu-vertical">\n' +
//                '\n' +
//                '        <li class="menu-item">\n' +
//                '            <a href="'+g.createLink(controller: 'inicio',action: 'index')+'" title="Inicio">\n' +
//                '                <i class="fa-menu fa fa-home"></i>\n' +
//                '                <span class="toggle-menu"> Inicio</span>\n' +
//                '            </a>\n' +
//                '        </li>\n' +
//                '        <li class="menu-item active dropdown">\n' +
//                '            <a href="#" class="dropdown-toggle active " title="Comprobantes">\n' +
//                '                <i class="fa-menu fa fa-money"></i>\n' +
//                '                <span class="toggle-menu">Comprobantes</span>\n' +
//                '                <span class="caret toggle-menu"></span></a>\n' +
//                '            <ul class="submenu " style="margin-top: 0px">\n' +
//                '                <li><a href="'+g.createLink(controller: 'inicio',action: 'contenido')+'" class="active">Ingreso</a></li>\n' +
//                '                <li><a href="#">Egreso</a></li>\n' +
//                '                <li><a href="#">Diarios</a></li>\n' +
//                '            </ul>\n' +
//                '        </li>\n' +
//                '        <li class="menu-item">\n' +
//                '            <a href="#" title="Reportes">\n' +
//                '                <i class="fa-menu fa fa-file-pdf-o"></i>\n' +
//                '                <span class="toggle-menu"> Reportes</span>\n' +
//                '            </a>\n' +
//                '        </li>\n' +
//                '        <li class="menu-item">\n' +
//                '            <a href="#" title="Proveedores">\n' +
//                '                <i class="fa-menu fa fa-truck"></i>\n' +
//                '                <span class="toggle-menu"> Proveedores</span>\n' +
//                '            </a>\n' +
//                '        </li>\n' +
//                '        <li class="menu-item">\n' +
//                '            <a href="#">\n' +
//                '                <i class="fa-menu fa fa-user"></i>\n' +
//                '                <span class="toggle-menu">  Clientes</span>\n' +
//                '            </a>\n' +
//                '        </li>\n' +
//                '        <li class="menu-item">\n' +
//                '            <a href="#">\n' +
//                '                <i class="fa-menu fa fa-building"></i>\n' +
//                '                <span class="toggle-menu"> Activos fijos</span>\n' +
//                '            </a>\n' +
//                '        </li>\n' +
//                '        <li class="menu-item">\n' +
//                '            <a href="#">\n' +
//                '                <i class="fa-menu fa fa-cogs"></i>\n' +
//                '                <span class="toggle-menu"> Parámetros</span>\n' +
//                '            </a>\n' +
//                '        </li>\n' +
//                '\n' +
//                '    </ul>'
//        out<<html
    }

    def menu = { attrs ->

        def items = [:]
        def usuario, perfil, dpto,sistema
        if (session.usuario) {
            usuario = session.usuario
            perfil = session.perfil
//            dpto = session.departamento
            sistema=session.sistema
        }
        def strItems = ""
        if (!attrs.title) {
            attrs.title = sistema.descripcion
        }
        if (usuario) {
            def acciones = Permiso.withCriteria {
                eq("perfil", perfil)
                accion {
                    modulo {
                        order("orden", "asc")
                    }
                    if(sistema.codigo!="T"){
                        or{
                            eq("sistema",sistema)
                            eq("sistema",Sistema.findByCodigo("T"))
                        }
                    }else{
                        eq("sistema",sistema)
                    }


                    order("orden", "asc")
                }
            }.accion

            acciones.each { ac ->
                if (ac.tipo.codigo == 'M' && ac.modulo.nombre != 'noAsignado') {
                    if (!items[ac.modulo.id]) {
                        items[ac.modulo.id] = [
                                label: ac.modulo.nombre,
                                icon : ac.modulo.icono,
                                items: [:]
                        ]
                    }
                    def acc = [
                            controller: ac.control.nombre,
                            action    : ac.nombre,
                            label     : ac.descripcion,
                            icon      : ac.icono
                    ]
                    items[ac.modulo.id]["items"][ac.id] = acc
                }
            }

            items.each { k, v ->
                if (v.items.size() == 1) {
                    v.items.each { ki, vi ->
                        if (vi.label == v.label) {
                            v.controller = vi.controller
                            v.action = vi.action
                            if (!v.icon) {
                                v.icon = vi.icon
                            }
                            v.items = null
                        }
                    }
                }
            }

        } else {
            items = [
                    "Inicio": [
                            controller: "inicio",
                            action    : "index",
                            label     : "Inicio",
                            icon      : "fa-home"
                    ],
                    admin   : [
                            label: "Administración",
                            icon : "fa-cog",
                            items: [
                                    alergia: [
                                            controller: "test1",
                                            action    : "list",
                                            label     : "Test 1",
                                            icon      : "fa-stethoscope"
                                    ],
                                    clinica: [
                                            controller: "test2",
                                            action    : "list",
                                            label     : "Test 2",
                                            icon      : "fa-hospital"
                                    ]
                            ]
                    ]
            ]
        }

        items.each { k, item ->
            strItems += renderItem(item)
        }

        def alertas = "("
        def count
//        if(session.tipo=="usuario")
        count= Alerta.countByPersonaAndFechaRecibidoIsNull(usuario)
//        else
//            count= Alerta.countByEstacionAndFechaRecibidoIsNull(usuario)

        alertas += count
        alertas += ")"

        def html = "<nav class=\"navbar navbar-default navbar-fixed-top\" role=\"navigation\">"

        html += "<div class=\"container-fluid\">"

        // Brand and toggle get grouped for better mobile display
        html += '<div class="navbar-header">'
        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">'
        html += '<span class="sr-only">Toggle navigation</span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</button>'
        html += '<a class="navbar-brand navbar-logo" href="#">'
        html += '<img src="' + resource(dir: 'images/barras', file: 'logo-menu.png') + '" />'
        html += '</a>'
        html += '</div>'

        // Collect the nav links, forms, and other content for toggling
        html += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'
        html += '<ul class="nav navbar-nav">'
        html += strItems
        html += '</ul>'

        html += '<ul class="nav navbar-nav navbar-right">'
        html += '<li><a href="' + g.createLink(controller: 'alerta', action: 'list') + '" ' + ((count > 0) ? ' style="color:#ab623a" class="annoying"' : "") + '><i class="fa fa-exclamation-triangle"></i> Alertas ' + alertas + '</a></li>'
        html += '<li class="dropdown">'
        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + session.usuario + ' (' + session.perfil + ')' + ' <b class="caret"></b></a>'
        html += '<ul class="dropdown-menu">'
        // println "tipo "+session.tipo
        if(session.tipo=="usuario")
            html += '<li><a href="' + g.resource(file: 'manual.pdf') + '" target="_blank"><i class="fa fa-file-pdf-o"></i> Manual de usuario</a></li>'
        else
            html += '<li><a href="' + g.resource(file: 'manual_estacion.pdf') + '" target="_blank"><i class="fa fa-file-pdf-o"></i> Manual de usuario</a></li>'
        html += '<li class="divider"></li>'
        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-power-off"></i> Salir</a></li>'
        html += '</ul>'
        html += '</li>'
        html += '</ul>'

        html += '</div><!-- /.navbar-collapse -->'

        html += "</div>"

        html += "</nav>"

        out << html
    }

    /**
     * Función que genera una porción de un item del menú
     * @param item
     * @return String con el elemento "<li>" del item
     */
    def renderItem(item) {
        def str = "", clase = ""
        if (session.cn == item.controller && session.an == item.action) {
            clase = "active"
        }
        if (item.items) {
            clase += " dropdown"
        }
        str += "<li class='" + clase + "'>"
        if (item.items) {
            str += "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>"
            if (item.icon) {
                str += "<i class='fa ${item.icon}'></i>"
                str += " "
            }
            str += item.label
            str += "<b class=\"caret\"></b></a>"
            str += '<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">'
            item.items.each { t, i ->
                str += renderItem(i)
            }
            str += "</ul>"
        } else {
            str += "<a href='" + createLink(controller: item.controller, action: item.action, params: item.params) + "'>"
            if (item.icon) {
                str += "<i class='fa ${item.icon}'></i>"
                str += " "
            }
            str += item.label
            str += "</a>"
        }
        str += "</li>"

        return str
    }

}
