<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Rubros</title>
    <meta name="layout" content="main">
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-8 titulo-panel">
                    Rubros
                </div>
                <div class="col-md-4 titulo-panel" style="margin-top: -11px">
                    <div class="col-md-4">
                        <a href="${g.createLink(action: 'nuevoRubro')}" class="btn btn-verde btnCrear btn-sm">
                            <i class="fa fa-file-o"></i> Nuevo rubro
                        </a>
                    </div>
                    <div class="btn-group pull-right col-md-8">
                        <div class="input-group">
                            <input type="text" class="form-control input-sm input-search" placeholder="Buscar" value="${params.search}">
                            <span class="input-group-btn">
                                <g:link controller="rubros" action="rubros" class="btn btn-default btn-search btn-sm">
                                    <i class="fa fa-search"></i>&nbsp;
                                </g:link>
                            </span>
                        </div><!-- /input-group -->
                    </div>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <table class="table table-condensed table-bordered table-striped table-hover table-sm">
                        <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Código</th>
                            <th>Tipo</th>
                            <th>Valor</th>
                            <th>Fórmula</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:if test="${count > 0}">
                            <g:each in="${rubros}" status="i" var="r">
                                <tr data-id="${r.id}">
                                    <td>${r.nombre}</td>
                                    <td>${r.codigo}</td>
                                    <td style="text-align: center">${r.signo==1?'Ingreso':'Egreso'}</td>
                                    <td style="text-align: right"><g:formatNumber number="${r.valor}" currencySymbol="" type="currency"/></td>
                                    <td>${r.formula}</td>
                                </tr>
                            </g:each>
                        </g:if>
                        <g:else>
                            <tr class="danger">
                                <td class="text-center" colspan="11">
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
                    <elm:pagination total="${count}" params="${params}"/>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $("tbody>tr").contextMenu({
        items  : {
            header   : {
                label  : "Acciones",
                header : true
            },
            editar   : {
                label  : "Ver - Editar",
                icon   : "fa fa-pencil",
                action : function ($element) {
                    var id = $element.data("id");

                    location.href="${g.createLink(action: 'nuevoRubro')}/"+id
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
</script>
</body>
</html>