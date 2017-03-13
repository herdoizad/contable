package contable.reportes

import contable.core.Cuenta
import contable.seguridad.Shield
import groovy.sql.Sql
import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter

class AuxiliarController extends Shield  {
    def qrCodeService
    def reportesService
    def dataSource
    def reporte(){
        //println "params "+params
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cuenta = Cuenta.findByNumeroAndEmpresa(params.cuenta,session.empresa)
        def fecha = new Date()
        def cierre = "01/01/${inicio.format('yyyy')}"
        def cn = new Sql(dataSource)
        Document document = new Document();

        def nombre ="Auxiliar-${cuenta.numero.trim()}-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(reportesService.getVcardReporte(session.usuario.login,", Auxiliar"), 70, bs)
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(),bs, fecha, session.usuario.login,", Auxiliar",null));
        Font header = new Font(Font.FontFamily.HELVETICA, 11,  Font.BOLD);
        Font titulo = new Font(Font.FontFamily.HELVETICA, 6, Font.BOLD);
        Font contenido = new Font(Font.FontFamily.HELVETICA, 5);
        document.setMargins(40,40,20,50)
        document.open();
        Image image = Image.getInstance(img.readBytes());
        image.setAbsolutePosition(40f, 765f);
        document.add(image);
        image = Image.getInstance(bs.toByteArray());
        image.setAbsolutePosition(500f, 750f);
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
        document.add(new Paragraph("\n"));
        p = new Paragraph("Auxiliar",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        def sql = "CONTABLE..up_rpt_auxiliar_por_cta  'PS' , ${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy').concat(' 23:59:59')}','${cuenta.numero.trim()}', 'S'"
      // println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..COMPROBANTES_TMP    order by CON_FECHA, COM_NUMERO "
       // println "sql "+sql
        def cont = 0
        def table = new PdfPTable(6);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [9,13,39,13,13,13];
        table.setWidths(anchos)
        def cell
        def debe = 0
        def haber = 0
        cn.eachRow(sql.toString()){r->
            if(cont==0){
                cell = new PdfPCell(new Paragraph(r["CTA_CUENTA"], titulo));
                cell.setBorder(0)
                cell.setColspan(2)
                cell.setHorizontalAlignment(Element.ALIGN_LEFT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(cuenta.descripcion.trim(), titulo));
                cell.setBorder(0)
                cell.setColspan(1)
                cell.setHorizontalAlignment(Element.ALIGN_LEFT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("SALDO ANTERIOR", titulo));
                cell.setBorder(0)
                cell.setColspan(2)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(formatNumber(number:  r["SALDO_INICIAL"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                cell.setBorder(0)
                cell.setColspan(1)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("\n\n\n", titulo));
                cell.setBorder(0)
                cell.setColspan(6)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("Fecha", titulo));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Código", titulo));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Descripción", titulo));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Debe", titulo));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Haber", titulo));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Saldo", titulo));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
            }
            debe+=  r["COM_DEBE"]
            haber+= r["COM_HABER"]
            cell = new PdfPCell(new Paragraph(r["CON_FECHA"].format("dd-MM-yyyy"), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("PS-"+r["COM_MES_CODIGO"]+getTipo(r["COM_TIPO_CODIGO"])+"-"+r["COM_NUMERO"], contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(r["COM_CONCEPTO"], contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_LEFT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number:  r["COM_DEBE"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number:  r["COM_HABER"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number:  r["COM_SALDO"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);

            cont++
        }
        cell = new PdfPCell(new Paragraph("Suman: ", titulo));
        cell.setBorder(0)
        cell.setColspan(3)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: debe,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number:  haber,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);


        document.add(table)
        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def getTipo(tipo){
        switch (tipo){
            case 1:
                return "I"
                break;
            case 2:
                return "E"
                break;
            case 3:
                return "D"
                break;
            case 4:
                return "A"
                break;
        }
    }
}
