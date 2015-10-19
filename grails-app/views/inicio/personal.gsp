<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Datos del usuario ${session.usuario.login}</title>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row fila">
    <div class="col-md-10">
        <div class="panel-completo" style="margin-left: 10px">
            <g:form action="cambiarPass_ajax" class="frm-pass">
                <div class="row">
                    <div class="col-md-12 titulo-panel">
                        Contraseña
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>
                            Contraseña actual:
                        </label>
                    </div>
                    <div class="col-md-3">
                        <input type="password" name="old" id="old" class="form-control input-sm required">
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>
                            Nueva contraseña:
                        </label>
                    </div>
                    <div class="col-md-3">
                        <input type="password" id="new" name="new" maxlength="12" class="form-control input-sm required">
                    </div>
                    <div class="col-md-7">
                        Entre 7 y 12 caracteres
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <label>
                            Confirmar contraseña:
                        </label>
                    </div>
                    <div class="col-md-3">
                        <input type="password" id="check"  maxlength="12" class="form-control input-sm required">
                    </div>
                </div>
                <div class="row fila">
                    <div class="col-md-2">
                        <a href="#" class="btn btn-verde" id="guardar">
                            <i class="fa fa-save"></i> Guardar
                        </a>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#guardar").click(function(){
        var pass = $("#new").val()
        var old = $("#old").val()
        var check = $("#check").val()
        var msg =""
        if(pass.length<7 || pass.length>12){
            msg+="La contraseña debe tener entre 7 y 12 caracteres<br/>"
        }

        if(old==""){
            msg+="Ingrese su contraseña actual<br/>"
        }
        if(pass!=check) {
            msg += "La contraseña y la verificación no coinciden<br/>"
        }
        if(msg==""){
            $(".frm-pass").submit()
        }else{
            bootbox.alert(msg)
        }
    });
</script>
</body>
</html>