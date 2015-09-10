package contable.reportes

import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter
import contable.core.Cuenta
import contable.seguridad.Shield
import groovy.sql.Sql

class MayorAuxiliarController extends Shield {
    def dataSource
    def qrCodeService
    def reportesService
    def index() {

        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cuenta = Cuenta.findByNumeroAndEmpresa(params.cuenta,session.empresa)
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="MayorAuxiliarSaldos-${cuenta.numero.trim()}-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(reportesService.getVcardReporte(session.usuario.login,"Mayor auxiliar"), 70, bs)
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(),bs, fecha, session.usuario.login,", Mayor auxiliar",null));
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
        def sql = "CONTABLE..up_rpt_auxiliar_saldos  'PS' , ${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}','${cuenta.numero.trim()}', '${cierre}'"
        println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..COMPROBANTES_TMP order by CTA_CUENTA,COM_CONTADOR "
        // println "sql "+sql
        def cont = 0
        def table = new PdfPTable(6);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [10,30,15,15,15,15];
        table.setWidths(anchos)
        def cell
        def debe = 0
        def haber = 0
        def saldoi=0
        def saldo=0
        cell = new PdfPCell(new Paragraph("Cod. Cuenta", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Descripción Cuenta", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Saldo inicial", titulo));
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
        def last=null
        def saldoInicial = 0
        cn.eachRow(sql.toString()) { r ->

            if(last!=r["CTA_CUENTA"]){
                saldoInicial=r["SALDO_INICIAL"]
                saldoi+= r["SALDO_INICIAL"]
            }else{
                debe+=  r["COM_DEBE"]
                haber+= r["COM_HABER"]
                saldo+= (saldoInicial + r["COM_DEBE"]-r["COM_HABER"])
                cell = new PdfPCell(new Paragraph(r["CTA_CUENTA"], contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(r["CTA_DESCRIPCION"], contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_LEFT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(formatNumber(number:  saldoInicial,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(formatNumber(number:  r["COM_DEBE"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(formatNumber(number:  r["COM_HABER"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(formatNumber(number:  saldoInicial+r["COM_DEBE"]-r["COM_HABER"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
            }
            last=r["CTA_CUENTA"]


        }


        cell = new PdfPCell(new Paragraph("TOTAL GENERAL: ", titulo));
        cell.setBorder(0)
        cell.setColspan(2)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: saldoi,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
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
        cell = new PdfPCell(new Paragraph(formatNumber(number: saldo,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
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
}
