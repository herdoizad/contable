<%@ page contentType="text/html"%>
<html>
<head>
    <title>Rol de pagos</title>

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
            Rol de pagos, mes de ${rol.mes.descripcion} del ${new Date().format("yyyy")}
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 20px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            Detalle de ingresos y descuentos
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            Apellidos y nombres: ${rol.empleado}
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" >
            <table style="border: none;border-collapse: collapse;width: 100%">
                <g:set var="band" value="${false}"></g:set>
                <g:each in="${detalle}" var="d" status="i">
                    <g:if test="${i==0}">
                        <tr>
                            <td colspan="3" style="font-weight: bold">Ingresos</td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                    </g:if>
                    <g:if test="${d.signo<0 && !band}">
                        <tr>
                            <td style="font-weight: bold">Total ingresos</td>
                            <td  style="text-align: right;font-weight: bold"><g:formatNumber number="${rol.totalIngresos}" type="currency" currencySymbol=""/></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <g:set var="band" value="${true}"></g:set>
                        <tr>
                            <td colspan="3" style="font-weight: bold">Descuentos</td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                    </g:if>
                    <tr>
                        <td>${d.descripcion}</td>
                        <td style="text-align: right"><g:formatNumber number="${d.valor}" type="currency" currencySymbol=""/></td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </g:each>
                <tr>
                    <td style="font-weight: bold">Total descuentos</td>
                    <td  style="text-align: right;font-weight: bold"><g:formatNumber number="${rol.totalEgresos}" type="currency" currencySymbol=""/></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td style="font-weight: bold">Liquido a recibir:</td>
                    <td style="text-align: right"><g:formatNumber number="${rol.totalIngresos-rol.totalEgresos}" type="currency" currencySymbol="\$"/></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>

            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            Fecha: ${new java.util.Date().format("dd-MM-yyyy HH:mm:ss")}
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