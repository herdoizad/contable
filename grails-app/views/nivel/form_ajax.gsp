<%@ page import="contable.core.Nivel" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!nivelInstance}">
    <elm:notFound elem="Nivel" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmNivel" id="${nivelInstance?.id}"
            role="form" controller="nivel" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-7">
            <g:textField name="codigo" maxlength="2" required="" class="form-control  required unique noEspacios" value="${nivelInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel Desc 1" claseField="col-sm-7">
            <g:textField name="nivelDesc1" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc1}"/>
        </elm:fieldRapido>
        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel 1" claseField="col-sm-3">
            <g:textField name="nivel1" value="${nivelInstance.nivel1}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel Desc 2" claseField="col-sm-7">
            <g:textField name="nivelDesc2" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc2}"/>
        </elm:fieldRapido>
        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel 2" claseField="col-sm-3">
            <g:textField name="nivel2" value="${nivelInstance.nivel2}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel Desc 3" claseField="col-sm-7">
            <g:textField name="nivelDesc3" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc3}"/>
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel 3" claseField="col-sm-3">
            <g:textField name="nivel3" value="${nivelInstance.nivel3}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel Desc 4" claseField="col-sm-7">
            <g:textField name="nivelDesc4" maxlength="15" required="" class="form-control  required" value="${nivelInstance?.nivelDesc4}"/>
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel 4" claseField="col-sm-3">
            <g:textField name="nivel4" value="${nivelInstance.nivel4}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>

        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel Desc 5" claseField="col-sm-7">
            <g:textField name="nivelDesc5" maxlength="15" class="form-control " value="${nivelInstance?.nivelDesc5}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel 5" claseField="col-sm-3">
            <g:textField name="nivel5" value="${nivelInstance.nivel5}" class="digits form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel Desc 6" claseField="col-sm-7">
            <g:textField name="nivelDesc6" maxlength="15" class="form-control " value="${nivelInstance?.nivelDesc6}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nivel 6" claseField="col-sm-3">
            <g:textField name="nivel6" value="${nivelInstance.nivel6}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmNivel").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }
            
            , rules          : {
                


                
            },
            messages : {
                
                codigo: {
                    remote: "Ya existe Codigo"
                }
                
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormNivel();
                return false;
            }
            return true;
        });
    </script>

</g:else>