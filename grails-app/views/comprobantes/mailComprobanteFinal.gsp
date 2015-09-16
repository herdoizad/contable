<%@ page contentType="text/html"%>
<html>
<head>
    <title>Edición de comprobantes</title>

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
            Edicion del comprobante: PS-${comp.mes}-${comp.tipo}-${g.formatNumber(number: comp.numero,maxFractionDigits: 0)}
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 20px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            Concepto: ${comp.concepto}
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            Fecha: ${comp.fecha.format("dd-MM-yyyy")}
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            Movimientos después de la edición:
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            <table style="width: 100%;border: none;border-collapse: collapse">
                <tr>
                    <th style="background-color: #0060BF;color: white">Cuenta</th>
                    <th style="background-color: #0060BF;color: white">Descripción</th>
                    <th style="background-color: #0060BF;color: white">Debe</th>
                    <th style="background-color: #0060BF;color: white">haber</th>
                </tr>
                <g:set var="td" value="${0}"/>
                <g:set var="th" value="${0}"/>
                <g:each in="${detalle}" var="d">

                    <tr>
                        <td>${d.cuenta.numero}</td>
                        <td>${d.cuenta.descripcion}</td>
                        <g:if test="${d.signo>0}">
                            <g:set var="td" value="${td+d.valor}"/>
                            <td style="text-align: right"><g:formatNumber number="${d.valor}" type="currency" currencySymbol=""/></td>
                            <td style="text-align: right">0.00</td>
                        </g:if>
                        <g:else>
                            <g:set var="th" value="${th+d.valor}"/>
                            <td style="text-align: right">0.00</td>
                            <td style="text-align: right"><g:formatNumber number="${d.valor}" type="currency" currencySymbol=""/></td>
                        </g:else>

                    </tr>
                </g:each>
                <tr>
                    <td></td>
                    <td style="font-weight: bold">TOTAL</td>
                    <td style="text-align: right;font-weight: bold"><g:formatNumber number="${td}" type="currency" currencySymbol=""/></td>
                    <td style="text-align: right;font-weight: bold"><g:formatNumber number="${th}" type="currency" currencySymbol=""/></td>
                </tr>
            </table>
        </td>

    </tr>
    <tr>
        <td colspan="2"  style="height: 10px; ">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            Usuario que modificó: ${genera}
        </td>
    </tr>

</table>


</body>
</html>