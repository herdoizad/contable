<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Egresos -  ${anio}</title>
    <meta name="layout" content="main">
    <style>
    .pestania{
        width: 85px;
    }
    .pestania a{
        background: #EFEFF0;
    }


    </style>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-8 titulo-panel">
                    Comprobantes de egreso del ${anio}
                </div>
                <div class="col-md-2 titulo-panel" style="margin-top: -11px">
                    <a href="#" class="btn btn-sm btn-verde" id="nuevo" activo="00">
                        <i class="fa fa-plus"></i>
                        Nuevo
                    </a>
                    <a href="#" class="btn btn-sm btn-verde">
                        <i class="fa fa-file-excel-o"></i>
                        Exportar
                    </a>
                    <a href="#" id="fs" class="btn btn-verde btn-sm" title="Pantalla completa">
                        <i class="fa fa-desktop"></i>
                    </a>
                </div>
                <div class="col-md-2 titulo-panel" style="margin-top: -11px">
                    <div class="input-group">
                        <input type="text" id="txt_buscar" class="form-control input-sm">
                        <span class="input-group-addon btn btn-verde"  id="buscar" style="border: 1px solid #19AA8D">
                            <i class="fa fa-search"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-12">
                    <ul class="nav nav-tabs" role="tablist">
                        <g:each in="${meses}" var="m">
                            <li role="presentation" class="pestania">
                                <a href="#${m.value}" class="mes m-${m.value}" mes="${m.value}" aria-controls="${m.value}" role="tab" data-toggle="tab">${m.key}</a>
                            </li>
                        </g:each>
                    </ul>
                    <div class="tab-content" style="margin-top: 10px" id="contenedor">
                        <g:each in="${meses}" var="m">
                            <div role="tabpanel" class="tab-pane fade" id="${m.value}"></div>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    String.prototype.contains = function(it) { return this.indexOf(it) != -1; };
    function showTablaYComprobante(mes,numero){
        var btn = $(".m-"+mes)
        var div = $(btn.attr("href"))
        $("#nuevo").attr("activo",mes)
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'comprobantes', action:'getComprobantesMes_ajax')}",
            data: {
                mes: mes,
                tipo:2,
                numero:numero
            },
            success: function (msg) {

                div.html(msg)
                btn.tab('show')
            } //success
        }); //ajax
    }

    <g:if test="${numero && numero!=''}">
    showTablaYComprobante('${mes}',${numero})
    </g:if>

    $(".mes").click(function(){
        var div = $($(this).attr("href"))
        var mes = $(this).attr("mes")
        $("#nuevo").attr("activo",mes)
        openLoader()
        $.ajax({
            type: "POST",
            url: "${createLink(controller:'comprobantes', action:'getComprobantesMes_ajax')}",
            data: {
                mes: $(this).attr("mes"),
                tipo:2
            },
            success: function (msg) {
                closeLoader()
                div.html(msg)
            } //success
        }); //ajax
    })

    $("#buscar").click(function(){
        var search = $("#txt_buscar").val().toUpperCase()
        if(search==""){
            $(".buscar").removeClass("resaltado")
        }else{
            $(".buscar").each(function(){
                $(this).removeClass("resaltado")
                if($(this).html().contains(search)){
                    $(this).addClass("resaltado")
                }
            });
        }

    })
    $("#nuevo").click(function(){
        location.href="${g.createLink(controller: 'comprobantes',action: 'nuevoEgreso')}/?mes="+$(this).attr("activo")+"&tipo=2"
    })
    $("#fs").click(function(){
        document.getElementById("contenedor").webkitRequestFullscreen();
        $("#contenedor").css({"overflow":"auto",width:"100%"})


    })
    $(".m-01").click()
</script>
</body>
</html>