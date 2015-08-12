package contable.reportes

import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter
import contable.core.Banco
import contable.core.Cuenta
import contable.seguridad.Shield
import groovy.sql.Sql

class ChequesController extends Shield {
    def dataSource
    def reporte() {
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cierre = "01/01/2015"
        def banco = Banco.findByCodigo(params.banco)
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="ChequesEmitidos-${params.banco}-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/logo-login.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(), fecha, session.usuario.login,""));
        Font header = new Font(Font.FontFamily.HELVETICA, 12, Font.UNDERLINE | Font.BOLD);
        Font titulo = new Font(Font.FontFamily.HELVETICA, 7, Font.BOLD);
        Font contenido = new Font(Font.FontFamily.HELVETICA, 6);
        document.open();
        Image image = Image.getInstance(img.readBytes());
        image.setAbsolutePosition(40f, 722f);
        document.add(image);
        Paragraph p = new Paragraph("PETROLEOS Y SERVICIOS", header);
        p.setAlignment(Element.ALIGN_RIGHT);
        document.add(p);
        p = new Paragraph("Ruc: 1791282299001 ", contenido);
        p.setAlignment(Element.ALIGN_RIGHT);
        document.add(p);
        p = new Paragraph(" Dirección: Av. 6 de Diciembre \n" +
                "    N30-182 y Alpallana, Quito" , contenido);
        p.setAlignment(Element.ALIGN_RIGHT);
        document.add(p);
        p = new Paragraph("Telefono: (593) (2) 381-9680", contenido);
        p.setAlignment(Element.ALIGN_RIGHT);
        document.add(p);
        document.add(new Paragraph("\n"));
        document.add(new Paragraph("\n"));
        p = new Paragraph("LISTADO DE CHEQUES EMITIDOS",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        document.add(new Paragraph("\n"));
        p = new Paragraph("Banco: ${banco.descripcion}\t\t\t\t\t  Cuenta: ${banco.numero}",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        def cont = 0
        def table = new PdfPTable(7);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [10,10,15,10,30,15,10];
        table.setWidths(anchos)
        def cell
        def sql = "CONTABLE..up_rpt_cheques_emitidos  '${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}','${params.banco}', 'PS'"
        println "sql "+sql
        cell = new PdfPCell(new Paragraph("Mes", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Número comp.", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Fecha emisión", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("No. cheque", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Beneficiario", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Valor", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        def last = null
        def total = 0
        cn.eachRow(sql.toString()) { r ->
            if(last!=r["CHE_NUMERO_CHEQUE"]){
                cell = new PdfPCell(new Paragraph(""+r["MES_CODIGO"], titulo));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(""+r["COM_NUMERO"], titulo));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(r["CHE_FECHA_EMISION"].format("dd-MM-yyyy"), titulo));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(""+r["CHE_NUMERO_CHEQUE"], titulo));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(r["CHE_BENEFICIARIO"], titulo));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(formatNumber(number:  r["CHE_VALOR"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                if( r["CHE_VALOR"]==0){
                    cell = new PdfPCell(new Paragraph("[ANULADO]", titulo));
                    cell.setBorder(0)
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                }else{
                    cell = new PdfPCell(new Paragraph("", titulo));
                    cell.setBorder(0)
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                    table.addCell(cell);
                }

            }
            last=r["CHE_NUMERO_CHEQUE"]
            if(banco.cuenta.numero!=r["CTA_CUENTA"] && r["COM_SIGNO"]==1){
                total+=r["COM_VALOR"]
                cell = new PdfPCell(new Paragraph("", contenido));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("", contenido));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(r["CTA_CUENTA"], contenido));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(""+r["CTA_DESCRIPCION"], contenido));
                cell.setBorder(0)
                cell.setColspan(3)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(formatNumber(number:  r["COM_VALOR"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
            }


        }

        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("TOTAL "+banco.descripcion, titulo));
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number:  total,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
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
