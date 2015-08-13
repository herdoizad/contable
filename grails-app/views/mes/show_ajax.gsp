
<%@ page import="contable.core.Mes" %>

<g:if test="${!mesInstance}">
    <elm:notFound elem="Mes" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:if test="${mesInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>

                <div class="col-sm-4">
                  ${mesInstance.codigo}
                </div>

            </div>
        </g:if>

        <g:if test="${mesInstance?.estado}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Estado
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${mesInstance}" field="estado"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${mesInstance?.periodoSri}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Periodo Sri
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${mesInstance}" field="periodoSri"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${mesInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${mesInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    


    
        <g:if test="${mesInstance?.empresa}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empresa
                </div>
                
                <div class="col-sm-4">
                    ${mesInstance?.empresa?.descripcion?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>

        <g:if test="${mesInstance?.inicio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Inicio
                </div>

                <div class="col-sm-4">
                    <g:formatDate date="${mesInstance?.inicio}" format="dd-MM-yyyy" />
                </div>

            </div>
        </g:if>

        <g:if test="${mesInstance?.fin}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fin
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${mesInstance?.fin}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    


    
    </div>
</g:else>