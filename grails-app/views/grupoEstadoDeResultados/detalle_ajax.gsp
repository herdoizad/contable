<table class="table table-darkblue table-bordered table-hover table-sm">
    <thead>
    <tr>
        <th colspan="4">Detalle</th>
    </tr>
    <tr>
        <th>#</th>
        <th style="width: 25%">Cuenta</th>
        <th style="width: 70%">Descripción</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td></td>
        <td>
            <g:select name="cuenta" id="cuenta" from="${contable.core.Cuenta.findAllByNivel(3)}" class="form-control input-sm"/>
        </td>
        <td>
            <input type="text" id="desc" class="form-control input-sm">
        </td>
        <td style="text-align: center">
            <a href="#" class="btn btn-info btn-xs" title="Agregar" grupo="${grupo.id}">
                <i class="fa fa-plus"></i>
            </a>
        </td>
    </tr>
    <g:each in="${detalle}" var="d">
        <tr>
            <td style="text-align: center">${d.grupo.id}</td>
            <td>${d.cuenta.numero}</td>
            <td>${d.descripcion}</td>
            <td style="text-align: center">
                <a href="#" class="btn btn-xs btn-danger" title="Borrar"><i class="fa fa-trash"></i></a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>