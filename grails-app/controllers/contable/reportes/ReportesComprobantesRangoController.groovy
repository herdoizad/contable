package contable.reportes

import com.itextpdf.text.BaseColor
import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfContentByte
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter
import contable.core.Cheque
import contable.core.Cliente
import contable.core.Comprobante
import contable.core.DetalleComprobante
import contable.core.DetalleFacturaEgresos
import contable.core.Tabla

class ReportesComprobantesRangoController {
    def meses =["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]

    def qrCodeService
    def reportesService
    def reporte() {
//        println "params "+params
        Document document = new Document();
        def desde = params.desde.toInteger()
        def hasta = params.hasta.toInteger()
        def nombre = "comprobantes-del-${desde}-al-${hasta}.pdf"
        def fecha = new Date()
        def mes = params.anio+params.mes
//        println "mes "+mes
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        Font header = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        Font titulo = new Font(Font.FontFamily.HELVETICA, 9, Font.BOLD);
        Font contenido = new Font(Font.FontFamily.HELVETICA, 8);
        document.setMargins(40,40,20,50)
        def hf = new contable.HeaderFooter(img.readBytes(),null, fecha, session.usuario.login,"",null)
        writer.setPageEvent(hf);
        document.open();
        Image image = Image.getInstance(img.readBytes());
        image.setAbsolutePosition(40f, 765f);
        document.add(image);

        Paragraph p = new Paragraph("PETROLEOS Y SERVICIOS", header);
        p.setAlignment(Element.ALIGN_LEFT);
        p.setIndentationLeft(94)
        document.add(p);
        p = new Paragraph("Dirección: Av. 6 de Diciembre \n" +
                "N30-182 y Alpallana, Quito" , contenido);
        p.setAlignment(Element.ALIGN_LEFT);
        p.setIndentationLeft(94)
        document.add(p);
        p = new Paragraph("Telefono: (593) (2) 381-9680", contenido);
        p.setAlignment(Element.ALIGN_LEFT);
        p.setIndentationLeft(94)
        document.add(p);
        document.add(new Paragraph("\n"));

        def cont = 0
        (desde..hasta).each {
//            println "num "+it
            def  comp = Comprobante.findAll("from Comprobante where empresa='${session.empresa.codigo}' and numero=${it} and tipo=${params.tipo} and mes=${mes}")
            if(comp.size()>0) {
                comp = comp.pop()
                if (cont > 0)
                    document.newPage()
                cont++
                imprimeComprobante(comp, document, header, titulo, contenido, hf,writer)
            }
        }






        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }


    def imprimeComprobante(Comprobante comp,Document document,header,titulo,contenido,hf,writer){
//        println "imprime comprobante "+params
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(reportesService.getVcardComprobante(session.usuario.login,g.formatNumber(number:  comp.numero,minFractionDigits: 0,maxFractionDigits: 0),comp.tipo,comp.mes), 70, bs)
        def image = Image.getInstance(bs.toByteArray());
        image.setAbsolutePosition(500f, 750f);
        document.add(image);
        hf.qr=bs

        def detalles = DetalleComprobante.findAll("from DetalleComprobante where empresa='${comp.empresa.codigo}' and numero=${comp.numero} and tipo=${comp.tipo} and mes=${comp.mes}")
        try {
            PdfPTable table
            PdfPTable tabla = new PdfPTable(3);
            tabla.setWidthPercentage(95.toFloat())
            int[] anchos = [15, 35, 50];
            tabla.setWidths(anchos)
            def cell = new PdfPCell(new Paragraph("Fecha", titulo));
            cell.setBorder(0)
            tabla.addCell(cell);
            cell = new PdfPCell(new Paragraph(comp.fecha.format("dd-MM-yyyy"), contenido));
            cell.setBorder(0)
            tabla.addCell(cell);
            cell = new PdfPCell(new Paragraph("Comprobante de "+comp.getTipoString(), titulo));
            cell.setBorder(0)
            tabla.addCell(cell);
            cell = new PdfPCell(new Paragraph("", titulo));
            cell.setBorder(0)
            tabla.addCell(cell);
            cell = new PdfPCell(new Paragraph("", titulo));
            cell.setBorder(0)
            tabla.addCell(cell);
            cell = new PdfPCell(new Paragraph("No: PS-${comp.mes}-${comp.tipo}-${g.formatNumber(number: comp.numero,maxFractionDigits: 0)}", titulo));
            cell.setBorder(0)
            tabla.addCell(cell);

            def cheque
            if(comp.tipo==2 ) {
                document.add(new Paragraph("\n"));
                cheque = Cheque.findAll("from Cheque where mes=${comp.mes} and comprobante=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
                if(cheque.size()>0) {
                    cheque = cheque.pop()
                    PdfContentByte cb = writer.getDirectContent();
                    cb.saveState();
                    cb.setColorStroke(BaseColor.BLACK);
                    cb.rectangle(38, 661, 520, 70);
                    cb.stroke();
                    cb.restoreState();
                    table = new PdfPTable(5);
                    table.setWidthPercentage(95.toFloat())
                    anchos = [15,35,20, 10, 20];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("CHEQUE", titulo));
                    cell.setBorder(0)
                    cell.setColspan(5)
                    cell.setBorderWidthBottom(1);
                    cell.setPaddingBottom(6)
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Banco:", titulo));
                    cell.setBorder(0)
                    cell.setColspan(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.banco.descripcion, contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("No. ", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(""+cheque.numero, contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Pague a:", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.beneficiario, contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("US\$:", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: cheque.valor,type: "currency",currencySymbol: ""), contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Ciudad:", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Quito", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Fecha:", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.emision?.format("dd-MM-yyyy"), contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Cuenta:", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(""+cheque.banco.numero, contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(3)
                    table.addCell(cell);
                    document.add(table)
                    document.add(new Paragraph("\n", titulo))
                }

            }
            if(comp.tipoProcesamiento==4){
                cheque = Cheque.findAll("from Cheque where mes=${comp.mes} and comprobante=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
                if(cheque.size()>0) {
                    cheque = cheque.pop()
                    def p=new Paragraph("TRANSFERENCIA", titulo)
                    p.setAlignment(Element.ALIGN_CENTER)
                    document.add(p)
                    document.add(new Paragraph("\n", titulo))
                    table = new PdfPTable(6);
                    table.setWidthPercentage(95.toFloat())
                    anchos = [15, 10, 35, 13, 13, 13];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("Banco", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("No. Cuenta", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Beneficiario", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("No. Transf", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Fecha", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Valor", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.banco.descripcion, contenido));
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.banco.numero, contenido));
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.beneficiario, contenido));
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number: comp.numero, maxFractionDigits: 0), contenido));
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.emision.format("dd-MM-yyyy"), contenido));
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number: cheque.valor, type: "currency", currencySymbol: ""), contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Total", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setColspan(5)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number: cheque.valor, type: "currency", currencySymbol: ""), titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    document.add(table)
                    document.add(new Paragraph("\n", titulo))
                }
            }

            document.add(tabla)
            table = new PdfPTable(2);
            table.setWidthPercentage(95.toFloat())
            anchos = [14, 76];
            table.setWidths(anchos)
            cell = new PdfPCell(new Paragraph("Concepto", titulo));
            cell.setBorder(0)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(comp.concepto, contenido));
            cell.setBorder(0)
            table.addCell(cell);
            document.add(table)
            document.add(new Paragraph("\n", titulo))
            table = new PdfPTable(4);
            table.setWidthPercentage(95.toFloat())
            anchos = [15, 55,15,15];
            table.setWidths(anchos)
            cell = new PdfPCell(new Paragraph("CONTABILIZACIÓN", titulo));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            cell.setColspan(4)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("Cuenta", titulo));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("Detalle de Transacción", titulo));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("Debe", titulo));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("Haber", titulo));
            table.addCell(cell);
            def debe =0
            def haber = 0
            detalles.each {d->
                cell = new PdfPCell(new Paragraph(d.cuenta.numero, contenido));
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(d.descripcion, contenido));
                table.addCell(cell);
                if(d.signo>0){
                    debe+=d.valor
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: d.valor,type:"currency",currencySymbol: ""), contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("0.00", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                }else{
                    haber+=d.valor
                    cell = new PdfPCell(new Paragraph("0.00", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: d.valor,type:"currency",currencySymbol: ""), contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);

                }
            }
            cell = new PdfPCell(new Paragraph("Suman", titulo));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            cell.setColspan(2)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(g.formatNumber(number: debe,type:"currency",currencySymbol: ""), titulo));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(g.formatNumber(number: haber,type:"currency",currencySymbol: ""), titulo));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            document.add(table)
            document.add(new Paragraph("\n"));
            if(comp.tipoProcesamiento==4) {
                def detFac = DetalleFacturaEgresos.findAll("from DetalleFacturaEgresos  where mes=${comp.mes} and comprobante=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
                detFac.each {d->
//                    document.add(new Paragraph("\n", titulo))
                    def cliente =Cliente.findByCodigo(cheque.codigoBeneficiario)
                    table = new PdfPTable(5);
                    table.setWidthPercentage(95.toFloat())
                    anchos = [15,35,20, 10, 20];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("COMPROBANTE DE RETENCIÓN", titulo));
                    cell.setBorder(0)
                    cell.setColspan(5)
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);


                    cell = new PdfPCell(new Paragraph("Ejercicio fiscal:", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(d.creacion?.format("yyyy"), contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("No. Diario:", titulo));
                    cell.setBorder(0)
                    cell.setColspan(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(" PS-${comp.mes}-${comp.tipo}-${g.formatNumber(number: comp.numero,maxFractionDigits: 0)}", contenido));
                    cell.setBorder(0)
                    cell.setColspan(1)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Contribuyente:", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.beneficiario, contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("R.U.C.: ", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cliente?.ruc, contenido));
                    cell.setBorder(0)
                    cell.setColspan(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Dirección: ", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cliente?.direccion, contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Fecha:", titulo));
                    cell.setBorder(0)
                    cell.setColspan(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(d.creacion?.format("dd-MM-yyyy"), contenido));
                    cell.setBorder(0)
                    table.addCell(cell);


                    document.add(table)
                    document.add(new Paragraph("\n", titulo))
                    table = new PdfPTable(5);
                    table.setWidthPercentage(95.toFloat())
                    anchos = [17,17,32, 17, 17];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("Ejercicio fiscal", titulo))
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Base imponible para la retención", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Impuesto", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("% de Retención", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Valor retenido", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);

                    if(d.retencion>0){
                        def rentencion = Tabla.findByCodigo(d.tipoRetencion)
                        cell = new PdfPCell(new Paragraph(d.creacion.format("yyyy"), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.valor,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(rentencion.descripcion, contenido))
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(""+rentencion.porcentaje, contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.retencion,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);

                    }

                    if(d.valorIva>0){
                        def rentencion = Tabla.findByCodigo(d.tipoIva)
                        cell = new PdfPCell(new Paragraph(d.creacion.format("yyyy"), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.valor*0.12,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(rentencion.descripcion, contenido))
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(""+rentencion.porcentaje, contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.valorIva,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);

                    }
                    document.add(table)
                    document.add(new Paragraph("\n", titulo))


                }
            }
            if(comp.tipo!=2 && comp.tipoProcesamiento!=4) {
                table = new PdfPTable(3);
                table.setWidthPercentage(95.toFloat())
                anchos = [33,33,34];
                table.setWidths(anchos)
                cell = new PdfPCell(new Paragraph("\n\n\n\n", titulo));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("", titulo));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("", titulo));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Elaborado por", titulo));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Contador", titulo));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Jefe financiero", titulo));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                document.add(table)
            }else{
                if(comp.tipo==2){
                    table = new PdfPTable(6);
                    table.setWidthPercentage(100.toFloat())
                    anchos = [16,16,16,16,16,16];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("\n\n\n\n", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("\n\n\n\n", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Contador", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Jefe financiero", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Auditoría interna", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Presidente ejecutivo", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Presidente de directorio", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Recibí conforme", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    document.add(table)
                }else{
                    table = new PdfPTable(5);
                    table.setWidthPercentage(100.toFloat())
                    anchos = [20,20,20,20,20];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("\n\n\n\n", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("\n\n\n\n", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Contador", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Jefe financiero", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Auditoría interna", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Presidente ejecutivo", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Presidente de directorio", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    document.add(table)

                    def p =new Paragraph("Transferido a:${cheque.beneficiario?.toString().trim()} Cta: ${comp.cuentaTransferencia} - ${comp.bancoCliente.descripcion}", contenido)
                    p.setAlignment(Element.ALIGN_LEFT)
                    document.add(p);
                }
            }


            if(comp.tipo==2) {
                def detFac = DetalleFacturaEgresos.findAll("from DetalleFacturaEgresos  where mes=${comp.mes} and comprobante=${comp.numero} and tipo=${comp.tipo} and empresa='${session.empresa.codigo}'")
                detFac.each {d->
                    document.add(new Paragraph("\n", titulo))
                    def cliente =Cliente.findByCodigo(cheque.codigoBeneficiario)
                    table = new PdfPTable(5);
                    table.setWidthPercentage(95.toFloat())
                    anchos = [15,35,20, 10, 20];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("COMPROBANTE DE RETENCIÓN", titulo));
                    cell.setBorder(0)
                    cell.setColspan(5)
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("CONTRIBUYEMTE ESPECIAL RESOLUCIÓN # 02239 \n DEL 7 DE MAYO 1996", contenido));
                    cell.setBorder(0)
                    cell.setColspan(5)
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("R.U.C. "+session.empresa.ruc, contenido));
                    cell.setBorder(0)
                    cell.setColspan(5)
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Matriz:"+session.empresa.direccion, contenido));
                    cell.setBorder(0)
                    cell.setColspan(3)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("No. 001-001-00"+session.empresa.secuencialComprobante, contenido));
                    cell.setColspan(2)
                    cell.setBorder(0)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("PBX: "+session.empresa.telefono.trim()+" - E-Mail: "+session.empresa.email, contenido));
                    cell.setBorder(0)
                    cell.setColspan(3)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Quito - Ecuador", contenido));
                    cell.setBorder(0)
                    cell.setColspan(3)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(5)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Señor (es):", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cheque.beneficiario, contenido));
                    cell.setBorder(0)
                    cell.setColspan(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Emisión:", titulo));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(d.creacion?.format("dd-MM-yyyy"), contenido));
                    cell.setBorder(0)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("R.U.C.: ", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cliente?.ruc, contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Tipo de comprobante ", titulo));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(d.tipoDocumento.descripcion, contenido));
                    cell.setBorder(0)
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Dirección: ", titulo));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(cliente?.direccion, contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Numero de comprobante ", titulo));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(d.numeroFactura, contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    document.add(table)
                    document.add(new Paragraph("\n", titulo))
                    document.add(new Paragraph("\n", titulo))
                    table = new PdfPTable(5);
                    table.setWidthPercentage(95.toFloat())
                    anchos = [17,17,32, 17, 17];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("Ejercicio fiscal", titulo))
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Base imponible para la retención", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Impuesto", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("% de Retención", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Valor retenido", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);

                    if(d.retencion>0){
                        def rentencion = Tabla.findByCodigo(d.tipoRetencion)
                        cell = new PdfPCell(new Paragraph(d.creacion.format("yyyy"), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.valor,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(rentencion.descripcion, contenido))
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(""+rentencion.porcentaje, contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.retencion,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);

                    }

                    if(d.valorIva>0){
                        def rentencion = Tabla.findByCodigo(d.tipoIva)
                        cell = new PdfPCell(new Paragraph(d.creacion.format("yyyy"), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.valor*0.12,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(rentencion.descripcion, contenido))
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(""+rentencion.porcentaje, contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(g.formatNumber(number:  d.valorIva,type: "currency",currencySymbol: ""), contenido))
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);

                    }
                    document.add(table)

                    table = new PdfPTable(3);
                    table.setWidthPercentage(95.toFloat())
                    anchos = [33,33,34];
                    table.setWidths(anchos)
                    cell = new PdfPCell(new Paragraph("\n\n\n\n\n", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Agente de retención", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Sujeto pasivo", titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    table.addCell(cell);
                    document.add(table)

                }
            }

            def p=new Paragraph("Impreso el "+new Date().format("dd-MM-yyyy HH:mm")+", Generado por: "+session.usuario.login,contenido)
            p.setAlignment(Element.ALIGN_CENTER)
            document.add(p)
        }catch (e){
            println "error pdf "+e.printStackTrace()
        }
    }

}
