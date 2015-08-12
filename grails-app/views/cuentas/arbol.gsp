<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Plan de cuentas</title>
    <imp:js src="${resource(dir: 'js/plugins/jstree-3.0.9/dist', file: 'jstree.min.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/jstree-3.0.9/dist/themes/default', file: 'style.min.css')}"/>
    <imp:css src="${resource(dir: 'css/custom', file: 'jstree-context.css')}"/>

    <imp:js src="${resource(dir: 'js/plugins/pdfObject', file: 'pdfobject.min.js')}"/>

    <imp:js src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.min.js')}"/>
    <imp:css src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.min.css')}"/>
    <style type="text/css">


    .jstree-search {
        color : #f7ea57 !important;
    }

    .treePart {
        overflow-y : auto;
        height     : 440px;
    }
    </style>
</head>
<body>

<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-9 titulo-panel">
                    Plan de cuentas
                </div>
                <div class="btn-group pull-right col-md-3 titulo-panel" style="margin-top: -11px">
                    <div class="input-group">
                        <input type="text" id="searchArbol" class="form-control input-search input-sm" placeholder="Buscar" value="${params.search}">
                        <span class="input-group-btn">
                            <a href="#" id="btnSearchArbol" class="btn btn-sm btn-default btn-search ">
                                <i class="fa fa-search"></i>&nbsp;
                            </a>
                        </span>
                    </div><!-- /input-group -->
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <div id="tree">
                        ${raw(arbol)}
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var searchRes = [];
    var posSearchShow = 0;
    var $treeContainer = $("#tree");
    function scrollToNode($scrollTo) {
//        $treeContainer.jstree("deselect_all").jstree("select_node", $scrollTo).animate({
//            scrollTop : $scrollTo.offset().top - $treeContainer.offset().top + $treeContainer.scrollTop() - 50
//        });
    }

    function scrollToRoot() {
        var $scrollTo = $("#estacion");
        scrollToNode($scrollTo);
    }

    function scrollToSearchRes() {
        var $scrollTo = $(searchRes[posSearchShow]).parents("li").first();
        $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
        scrollToNode($scrollTo);
    }

    function createContextMenu(node) {

        var nodeStrId = node.id;
        var $node = $("#" + nodeStrId);
        var movimiento = $node.hasClass("movimiento");
        var nodeId = nodeStrId.split("_")[1];
        var nodeType = $node.data("jstree").type;
        var estado = $node.hasClass("A");
        //console.log("estado",estado,$node);

        var nodeText = $node.children("a").first().text();
        var esEditable = $node.hasClass("editable");
        var cantHijos = parseInt($node.data("hijos"));
        var esDoc = nodeType == "doc";
        var verDetalles = {
            label: "Ver Detalles",
            icon: "fa fa-search",
            action: function () {
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'cuentas', action:'verDetalles_ajax')}",
                    data: {
                        id: nodeStrId
                    },
                    success: function (msg) {
                        closeLoader()
                        var b = bootbox.dialog({
                            id: "dlgDetalles",
                            title: "Detalles de la cuenta",
                            message: msg,
                            buttons: {
                                cerrar: {
                                    label: "Cerrar",
                                    className: "btn-primary",
                                    callback: function () {

                                    }
                                }
                            } //buttons
                        }); //dialog
                    } //success
                }); //ajax
                return false
            }
        };
        var editar = {
            label: "Editar",
            icon: "fa fa-pencil",
            action: function () {
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'cuentas', action:'form_ajax')}",
                    data: {
                        id: nodeStrId
                    },
                    success: function (msg) {
                        closeLoader()
                        var b = bootbox.dialog({
                            id: "dlgDetalles",
                            title: "Editar cuenta",
                            message: msg,
                            buttons: {
                                cerrar: {
                                    label: "Cerrar",
                                    className: "btn-default",
                                    callback: function () {

                                    }
                                },
                                guardar: {
                                    label: "Guardar",
                                    className: "btn-success",
                                    callback: function () {
                                        openLoader()
                                        $("#frmCuenta").submit()
                                    }
                                }
                            } //buttons
                        }); //dialog
                    } //success
                }); //ajax
                return false
            }
        };
        var hija = {
            label: "Crear cuenta hija",
            icon: "fa fa-level-down",
            action: function () {
                openLoader()
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller:'cuentas', action:'form_ajax')}",
                    data: {
                        padre: nodeStrId
                    },
                    success: function (msg) {
                        closeLoader()
                        var b = bootbox.dialog({
                            id: "dlgDetalles",
                            title: "Agregar cuanta hija de: "+nodeStrId,
                            message: msg,
                            buttons: {
                                cerrar: {
                                    label: "Cerrar",
                                    className: "btn-default",
                                    callback: function () {

                                    }
                                },
                                guardar: {
                                    label: "Guardar",
                                    className: "btn-success",
                                    callback: function () {
                                        if($("#frmCuenta").valid()){
                                            openLoader()
                                            $("#frmCuenta").submit()
                                        }
                                        return false

                                    }
                                }
                            } //buttons
                        }); //dialog
                    } //success
                }); //ajax
                return false
            }
        };
        var items = {};
        items.verDetalles = verDetalles;
        items.editar = editar;
        if(!movimiento)
            items.hija=hija
        return items;
    }

    $(function () {

        $('.select').selectpicker();
        $treeContainer.on("loaded.jstree", function () {
            $("#loading").hide();
            $treeContainer.removeClass("hidden");
        }).on("select_node.jstree", function (node, selected, event) {
            var nodeId = selected.selected[0];
            var $node = $("#" + nodeId);
            var nodeType = $node.data("jstree").type;

//                    $('#tree').jstree('toggle_node', selected.selected[0]);
        }).on('search.jstree', function (nodes, str, res) {
//                console.log(nodes, str, res);
            searchRes = $(".jstree-search");
            var cantRes = searchRes.length;
            posSearchShow = 0;
            $("#divSearchRes").removeClass("hidden");
            $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);
            scrollToSearchRes();
        }).jstree({
            plugins     : ["types", "contextmenu", "search"],
            core        : {
                multiple       : false,
                check_callback : true,
                data           : {
                    async : false,
                    url   : '${createLink(action:"loadTreePart_ajax")}',
                    data  : function (node) {
                        return {
                            id    : node.id
                        };
                    }
                }
            },
            contextmenu : {
                show_at_node : false,
                items        : createContextMenu
            },
            search      : {
                fuzzy             : false,
                show_only_matches : false,
                ajax              : {
                    url     : "${createLink(action:'buscarCuenta')}",
                    success : function (msg) {
                        closeLoader()
                        console.log(msg)
                        var json = $.parseJSON(msg);
                        console.log("json")
                        $.each(json, function (i, obj) {
                            $('#tree').jstree("open_node", obj);
                            console.log("each",obj)
                        });
                        setTimeout(function () {
                            console.log("timeout")
                            searchRes = $(".jstree-search");
                            var cantRes = searchRes.length;
                            posSearchShow = 0;
                            $("#divSearchRes").removeClass("hidden");
                            $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);

                        }, 300);

                    }
                }
            },
            types       : {
                1 : {
                    icon : "${resource(dir:'images/tree', file:'Building_16.png')}"
                },
                2      : {
                    icon : "fa fa-credit-card"
                },
                3     : {
                    icon : "fa fa-institution"
                },
                4    : {
                    icon : "fa fa-money"
                },
                5    : {
                    icon : "fa fa-shopping-cart"
                },
                6  : {
                    icon : "fa fa-briefcase"
                },
                pys:{
                    icon : "${resource(dir:'images/favicons', file:'favicon-16x16.png')}"
                }
            }
        });

        $("#btnExpandAll").click(function () {
            $treeContainer.jstree("open_all");
            scrollToRoot();
            return false;
        });

        $("#btnCollapseAll").click(function () {
            $treeContainer.jstree("close_all");
            scrollToRoot();
            return false;
        });

        $('#btnSearchArbol').click(function () {
            openLoader()
            $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
            return false;
        });
        $("#searchArbol").keypress(function (ev) {
            if (ev.keyCode == 13) {
                openLoader()
                $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
                return false;
            }
        });

        $("#btnPrevSearch").click(function () {
            if (posSearchShow > 0) {
                posSearchShow--;
            } else {
                posSearchShow = searchRes.length - 1;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnNextSearch").click(function () {
            if (posSearchShow < searchRes.length - 1) {
                posSearchShow++;
            } else {
                posSearchShow = 0;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnClearSearch").click(function () {
            $treeContainer.jstree("clear_search");
            $("#searchArbol").val("");
            posSearchShow = 0;
            searchRes = [];
            scrollToRoot();
            $("#divSearchRes").addClass("hidden");
            $("#spanSearchRes").text("");
        });

    });
</script>

</body>
</html>
