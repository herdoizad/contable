<%@ page contentType="text/html"%>
<html>
<head>
    <title>${titulo}</title>

</head>
<body>
<table style="width: 650px;height: 60px;border: none;border-collapse: collapse">
    <tr>
        <td>
            <img src="cid:logo" style="height: 60px;float: left">
        </td>
        <td style="height: 60px">
            <h1 style="color:#006EB7;margin-top: 0px;width: 310px;text-align: center;font-weight: bold;font-size: 22px">
                PETROLEOS Y SERVICIOS<br/>
            </h1>
            Av. 6 de Diciembre N30-182 y Alpallana, Quito (593) (2) 381-9680
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="border-top:1px solid #E03F23;height: 20px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" style="background: #82A640;color: #ffffff;font-weight: bold;padding-left: 10px;width: 600px">
            ${titulo}
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 20px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
         Su prestamo de ${prestamo.monto} ha sido APROBADO.
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            La primera cuota de ${prestamo.valorCuota} será descontada  el ${prestamo.inicio?.format("dd-MM-yyyy")}
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Generado por: ${usuario}
        </td>
    </tr>

</table>


</body>
</html>