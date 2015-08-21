<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Empleados</title>
    <link href="${g.resource(dir: 'css/custom/', file: 'dashboard.css')}" rel="stylesheet" type="text/css">
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="row">
    <div class="col-md-12">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel-body" style="padding:0px">
                        <div class="header-flow">
                            <div class="header-flow-item before">
                                <span class="badge before">1</span> Datos personales
                                <span class="arrow"></span>
                            </div>
                            <g:link controller="empleado" action="capacitacion">
                                <div class="header-flow-item active">
                                    <span class="badge active">2</span>
                                    Instrucción
                                    <span class="arrow"></span>
                                </div>
                            </g:link>
                            <g:link controller="empleado" action="capacitacion">
                                <div class="header-flow-item active">
                                    <span class="badge active">3</span>
                                    Cargas familiares
                                    <span class="arrow"></span>
                                </div>
                            </g:link>
                            <g:link controller="empleado" action="contratos">
                                <div class="header-flow-item active">
                                    <span class="badge active">4</span>
                                    Contratos
                                    <span class="arrow"></span>
                                </div>
                            </g:link>
                        </div>
                        <div class="flow-body">

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>