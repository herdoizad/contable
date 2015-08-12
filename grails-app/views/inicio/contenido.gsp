<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Inicio</title>
    <meta name="layout" content="main" />
</head>
<body>
<div class="panel-completo">
    <div class="row">
        <div class="col-md-4">
            <h1>Contenido de la página</h1>
        </div>
    </div>
    <div class="row fila">
        <div class="col-md-1">
            <label>Campo</label>
        </div>
        <div class="col-md-3">
            <input type="text" class="form form-control input-sm" placeholder="Ejemplo">
        </div>
        <div class="col-md-1">
            <label>Campo</label>
        </div>
        <div class="col-md-3">
            <input type="text" class="form form-control input-sm" placeholder="Ejemplo">
        </div>
    </div>
    <div class="row fila">
        <div class="col-md-1">
            <label>Combo</label>
        </div>
        <div class="col-md-3">
            <g:select name="test" from="${1..5}" class="form-control input-sm"></g:select>
        </div>
    </div>
    <div class="row fila">
        <div class="col-md-1">
            <label>Date</label>
        </div>
        <div class="col-md-3">
            <elm:datepicker class="form-control input-sm" name="date"></elm:datepicker>
        </div>
    </div>
    <div class="row fila" style="margin-top: 30px">
        <div class="col-md-7">
            <a href="#"class="btn btn-darkblue btn-sm">Principal</a>
            <a href="#"class="btn btn-verde btn-sm">Secundario</a>
        </div>
    </div>
    <div class="row fila" style="margin-top: 30px">
        <div class="col-md-7">
            <a href="#"class="btn btn-default">Default</a>
            <a href="#"class="btn btn-info">Info</a>
            <a href="#"class="btn btn-primary">Primary</a>
            <a href="#"class="btn btn-danger">Danger</a>
            <a href="#"class="btn btn-warning">Warning</a>
            <a href="#"class="btn btn-success">Success</a>

        </div>
    </div>
</div>
<div class="row" style="margin-top: 20px">
    <div class="col-md-1"></div>
    <div class="col-md-3">
        <div class="panel-completo">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Panel pequeño
                </div>
            </div>
            <table class="table table-bordered darkblue" style="margin-top: 20px">
                <thead>
                <tr>
                    <th>Col1</th>
                    <th>Col2</th>
                    <th>Col3</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>datos</td>
                    <td>datos</td>
                    <td>datos</td>
                </tr>
                <tr>
                    <td>datos</td>
                    <td>datos</td>
                    <td>datos</td>
                </tr>
                <tr>
                    <td>datos</td>
                    <td>datos</td>
                    <td>datos</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="col-md-6">
        <div class="panel-completo">
            <div class="row">
                <div class="col-md-12 titulo-panel">
                    Panel mediano
                </div>
            </div>
            <table class="table table-bordered verde" style="margin-top: 20px">
                <thead>
                <tr>
                    <th>Col1</th>
                    <th>Col2</th>
                    <th>Col3</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>