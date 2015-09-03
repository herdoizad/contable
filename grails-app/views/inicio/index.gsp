<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Inicio</title>
    <meta name="layout" content="main" />
</head>
<body>
<div class="row" style="margin-top: 20px">
    <div class="col-md-3 col-md-offset-1">
        <div class="card-verde">
            <div class="row">
                <div class="col-xs-4">
                    <i class="fa fa-usd fa-5x"></i>
                </div>
                <div class="col-xs-8 text-right">
                    <h2 style="margin-top: 0px">Comprobantes</h2>
                    <ul style="list-style: none">
                        <li><g:link controller="comprobantes" action="ingresos" style="color: inherit">Ingreso</g:link></li>
                        <li><g:link controller="comprobantes" action="egresos" style="color: inherit">Egreso</g:link></li>
                        <li><g:link controller="comprobantes" action="diarios" style="color: inherit">Diarios</g:link></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card-verde2">
            <div class="row">
                <div class="col-xs-4">
                    <i class="fa fa-file-pdf-o fa-5x"></i>
                </div>
                <div class="col-xs-8 text-right">
                    <h2 style="margin-top: 0px">
                        <g:link controller="reportes" action="index" style="color: inherit">Reportes</g:link>
                    </h2>
                    <ul style="list-style: none">
                        <li>Balance</li>
                        <li>Resultados</li>
                        <li>Auxiliares</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card-naranja">
            <div class="row">
                <div class="col-xs-4">
                    <i class="fa fa-cogs  fa-5x"></i>
                </div>
                <div class="col-xs-8 text-right">
                    <h2 style="margin-top: 0px">Parámetos</h2>
                    <ul style="list-style: none">
                        <li><g:link controller="cuentas" action="arbol" style="color: inherit">Plan de cuentas</g:link></li>
                        <li><g:link controller="cliente" action="index" style="color: inherit">Proveedores</g:link></li>
                        <li><g:link controller="banco" action="index" style="color: inherit">Bancos</g:link></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>