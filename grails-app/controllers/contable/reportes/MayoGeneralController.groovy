package contable.reportes


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
import com.itextpdf.text.pdf.PdfWriter

class MayoGeneralController extends Shield  {

    def dataSource
    def qrCodeService
    def reportesService
    def reporte(){
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="MayorGeneral-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(reportesService.getVcardReporte(session.usuario.login,"Mayor general"), 70, bs)
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(),bs, fecha, session.usuario.login,", Mayor general",null));
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
        p = new Paragraph("MAYOR GENERAL",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        def sql = "CONTABLE..up_mayor_general 'PS' ,'${params.cuenta}',${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}', '${cierre}'"
        println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL=4 order by MES_CODIGO,CTA_CUENTA "
        println "sql "+sql
        def table = new PdfPTable(5);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [15,40,15,15,15];
        table.setWidths(anchos)
        def cell
        def cont = 0
        def last=null
        def debe = 0,haber=0,totald=0,totalh=0
        cn.eachRow(sql.toString()) { r ->
            if(cont==0){
                cell = new PdfPCell(new Paragraph(r["CTA_MAYOR"], titulo));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(r["CTA_DESCRIPCION_MAYOR"], titulo));
                cell.setBorder(0)
                cell.setColspan(4)
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("Cód. Cuenta", contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Descripción", contenido));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Debe", contenido));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Haber", contenido));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Saldo", contenido));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                cell.setBorder(0)
                table.addCell(cell);


            }
            if(r["MES_CODIGO"]!=last){
                if(last!=null){
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number: debe,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                    cell.setBorder(0)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorderWidthTop(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number:  haber,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                    cell.setBorder(0)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorderWidthTop(1)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    totald+=debe
                    totalh+=haber
                    debe=0
                    haber=0
                }
                cell = new PdfPCell(new Paragraph(r["CTA_MESPROCESO"], titulo));
                cell.setBorder(0)
                cell.setColspan(5)
                table.addCell(cell);

            }
            last=r["MES_CODIGO"]
            debe+= r["CTA_DEBE"]
            haber+= r["CTA_HABER"]
            cell = new PdfPCell(new Paragraph(r["CTA_CUENTA"], contenido));
            cell.setBorder(0)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(r["CTA_DESCRIPCION"], contenido));
            cell.setBorder(0)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(""+formatNumber(number:r["CTA_DEBE"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(""+formatNumber(number:r["CTA_HABER"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(""+formatNumber(number:r["CTA_SALDO_INI"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cont++
        }
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        cell.setColspan(2)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: debe,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorderWidthTop(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number:  haber,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorderWidthTop(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        table.addCell(cell);
        totald+=debe
        totalh+=haber

        cell = new PdfPCell(new Paragraph("Total período:", titulo));
        cell.setBorder(0)
        cell.setColspan(2)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: totald,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
//        cell.setBorderWidthTop(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number:  totalh,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
//        cell.setBorderWidthTop(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        table.addCell(cell);


        document.add(table)
        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }
}
