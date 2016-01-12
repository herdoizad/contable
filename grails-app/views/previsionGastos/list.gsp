
<%@ page import="contable.nomina.PrevisionGastos" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de PrevisionGastos</title>
    </head>
    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

    <div class="row fila">
        <div class="col-md-11">
            <div class="panel-completo" style="margin-left: 10px">
                <div class="row">
                    <div class="col-md-8 titulo-panel">
                        ${empleado?'Previsión del empleado: '+empleado:'Previsiones'}

                    </div>
                    <div class="col-md-4 titulo-panel" style="margin-top: -11px;text-align: right">

                        <a href="#" class="btn btn-verde btnCrear btn-sm">
                            <i class="fa fa-file-o"></i> Crear
                        </a>

                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-12">
        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>
                    
                    <g:sortableColumn property="anio" title="Anio" />
                    
                    <th>Empleado</th>
                    
                    <g:sortableColumn property="totalAlimentacion" title="Total Vivienda" />
                    
                    <g:sortableColumn property="totalEducacion" title="Total Educacion" />
                    
                    <g:sortableColumn property="totalSalud" title="Total Salud" />
                    
                    <g:sortableColumn property="totalVestimenta" title="Total Vestimenta" />

                    <g:sortableColumn property="totalAlimentacion" title="Total Alimentacion" />
                    
                </tr>
            </thead>
            <tbody>
                <g:if test="${previsionGastosInstanceCount > 0}">
                    <g:each in="${previsionGastosInstanceList}" status="i" var="previsionGastosInstance">
                        <tr data-id="${previsionGastosInstance.id}">
                            
                            <td style="text-align: center">${previsionGastosInstance.anio}</td>
                            
                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${previsionGastosInstance}" field="empleado"/></elm:textoBusqueda></td>
                            
                            <td style="text-align: right">
                                <g:formatNumber number="${previsionGastosInstance.totalVivienda}" type="currency" currencySymbol=""/>
                            </td>
                            
                            <td style="text-align: right">
                                <g:formatNumber number="${previsionGastosInstance.totalEducacion}" type="currency" currencySymbol=""/>
                            </td>
                            
                            <td style="text-align: right">
                                <g:formatNumber number="${previsionGastosInstance.totalSalud}" type="currency" currencySymbol=""/>
                            </td>
                            
                            <td style="text-align: right">
                                <g:formatNumber number="${previsionGastosInstance.totalVestimenta}" type="currency" currencySymbol=""/>
                            </td>

                            <td style="text-align: right">
                                <g:formatNumber number="${previsionGastosInstance.totalAlimentacion}" type="currency" currencySymbol=""/>
                            </td>
                            
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="7">
                            <g:if test="${params.search && params.search!= ''}">
                                No se encontraron resultados para su búsqueda
                            </g:if>
                            <g:else>
                                No se encontraron registros que mostrar
                            </g:else>
                        </td>
                    </tr>
                </g:else>
            </tbody>
        </table>

        <elm:pagination total="${previsionGastosInstanceCount}" params="${params}"/>
</div>
      </div>
            </div>
                  </div>
                        </div>


        <script type="text/javascript">
            var id = null;
            function submitFormPrevisionGastos() {
                var $form = $("#frmPrevisionGastos");
                var $btn = $("#dlgCreateEditPrevisionGastos").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando PrevisionGastos");
                    $.ajax({
                        type    : "POST",
                        url     : $form.attr("action"),
                        data    : $form.serialize(),
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            setTimeout(function() {
                                if (parts[0] == "SUCCESS") {
                                    location.reload(true);
                                } else {
                                    spinner.replaceWith($btn);
                                    closeLoader();
                                    return false;
                                }
                            }, 1000);
                        },
                        error: function() {
                            log("Ha ocurrido un error interno", "Error");
                            closeLoader();
                        }
                    });
            } else {
                return false;
            } //else
            }
            function deletePrevisionGastos(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el PrevisionGastos seleccionado? Esta acción no se puede deshacer.</p>",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-trash-o'></i> Eliminar",
                            className : "btn-danger",
                            callback  : function () {
                                openLoader("Eliminando PrevisionGastos");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'previsionGastos', action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("*");
                                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "SUCCESS") {
                                            setTimeout(function() {
                                                location.reload(true);
                                            }, 1000);
                                        } else {
                                            closeLoader();
                                        }
                                    },
                                    error: function() {
                                        log("Ha ocurrido un error interno", "Error");
                                        closeLoader();
                                    }
                                });
                            }
                        }
                    }
                });
            }
            function createEditPrevisionGastos(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? ({ id: id ,empleado:"${empleado?.id}"}) : ({empleado:"${empleado?.id}"});
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'previsionGastos', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgCreateEditPrevisionGastos",
                            title   : title + " PrevisionGastos",
                            
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                guardar  : {
                                    id        : "btnSave",
                                    label     : "<i class='fa fa-save'></i> Guardar",
                                    className : "btn-success",
                                    callback  : function () {
                                        return submitFormPrevisionGastos();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit

            function verPrevisionGastos(id) {
            $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'previsionGastos', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver PrevisionGastos",
                            
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }

            $(function () {

                $(".btnCrear").click(function() {
                    createEditPrevisionGastos();
                    return false;
                });

                $("tbody>tr").contextMenu({
                    items  : {
                        header   : {
                            label  : "Acciones",
                            header : true
                        },
                        ver      : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function ($element) {
                                var id = $element.data("id");
                                verPrevisionGastos(id);
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                createEditPrevisionGastos(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deletePrevisionGastos(id);
                            }
                        }
                    },
                    onShow : function ($element) {
                        $element.addClass("success");
                    },
                    onHide : function ($element) {
                        $(".success").removeClass("success");
                    }
                });
            });
        </script>

    </body>
</html>
