
<%@ page import="contable.nomina.MesNomina" %>

<g:if test="${!mesNominaInstance}">
    <elm:notFound elem="MesNomina" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${mesNominaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${mesNominaInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${mesNominaInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${mesNominaInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${mesNominaInstance?.diasLaborables}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Dias Laborables
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${mesNominaInstance}" field="diasLaborables"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>