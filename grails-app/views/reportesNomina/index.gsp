<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Reportes</title>
    <meta name="layout" content="main">
    <style>
        .panel-completo{
            min-height: 150px;
        }
    </style>
</head>
<body>
<div class="row fila">
    <div class="col-md-3">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Detalle de descuentos
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Empleado</label>
                </div>
                <div class="col-md-9">
                    <g:select name="empleado_d" id="empleado_d" class="form-control input-sm"
                              from="${empleados}" optionKey="id" noSelection="['-1':'Todos']" />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Mes</label>
                </div>
                <div class="col-md-9">
                    <g:select name="mes" id="mes_d" class="form-control input-sm" optionValue="descripcion"
                              from="${meses}" optionKey="id"   />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm generar" id="generar-desc"  prefijo="d" >
                        <i class="fa fa-file-excel-o"></i> Generar
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                   Provisiones
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Empleado</label>
                </div>
                <div class="col-md-9">
                    <g:select name="empleado" id="empleado_p" class="form-control input-sm"
                              from="${empleados}" optionKey="id" noSelection="['-1':'Todos']" />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Mes</label>
                </div>
                <div class="col-md-9">
                    <g:select name="mes" id="mes_p" class="form-control input-sm" optionValue="descripcion"
                              from="${meses}" optionKey="id"   />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm generar" id="generar-p"  prefijo="p" >
                        <i class="fa fa-file-excel-o"></i> Generar
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Horas extra
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Empleado</label>
                </div>
                <div class="col-md-9">
                    <g:select name="empleado" id="empleado_h" class="form-control input-sm"
                              from="${empleados}" optionKey="id" noSelection="['-1':'Todos']" />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Mes</label>
                </div>
                <div class="col-md-9">
                    <g:select name="mes" id="mes_h" class="form-control input-sm" optionValue="descripcion"
                              from="${meses}" optionKey="id"  />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm generar" id="generar-h"  prefijo="h" >
                        <i class="fa fa-file-excel-o"></i> Generar
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!--
    <div class="col-md-3">
        <div class="panel-completo" style="margin-left: 10px">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Cuadre
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Empleado</label>
                </div>
                <div class="col-md-9">
                    <g:select name="empleado" id="empleado_c" class="form-control input-sm"
                              from="${empleados}" optionKey="id" noSelection="['-1':'Todos']" />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <label>Mes</label>
                </div>
                <div class="col-md-9">
                    <g:select name="mes" id="mes_c" class="form-control input-sm" optionValue="descripcion"
                              from="${meses}" optionKey="id"  />
                </div>
            </div>
            <div class="row fila">
                <div class="col-md-3">
                    <a href="#" class="btn btn-verde btn-sm generar" id="generar-c" prefijo="c" >
                        <i class="fa fa-file-excel-o"></i> Generar
                    </a>
                </div>
            </div>
        </div>
    </div>-->
</div>
<script>
    $(".generar").click(function(){
        var prefijo = $(this).attr("prefijo")
        location.href="${g.createLink(controller: 'reportesNomina',action: 'reportes')}/?mes="+$("#mes_"+prefijo).val()+"&empleado="+$("#empleado_"+prefijo).val()+"&tipo="+prefijo
    });
</script>
</body>
</html>