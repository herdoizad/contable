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

class CarteraVencidaController extends Shield {
    def dataSource
    def qrCodeService
    def reportesService
    def index() {
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cuenta = Cuenta.findByNumeroAndEmpresa(params.cuenta,session.empresa)
        def desde =cuenta.numero.trim()+"01001"
        def hasta = cuenta.numero.trim()+"99999"
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="Cartera Vencida-${cuenta.numero.trim()}-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(reportesService.getVcardReporte(session.usuario.login,"Cartera vencida"), 70, bs)
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(),bs, fecha, session.usuario.login,", Cartera vencida",null));
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
        def tit = ""
        switch (params.dias){
            case "0":
                tit="DE 0 a 29"
                break;
            case "30":
                tit="DE 30 a 59"
                break;
            case "60":
                tit="DE 60 a 89"
                break;
            case "90 a 364":
                tit=""
                break;
            case "DE 365 a 1825":
                tit=""
                break;
            case "1826":
                tit="MAS DE 1825"
                break;

        }
        p = new Paragraph("CARTERA VENCIDA CUENTAS CONTABLES\n "+tit+" DIAS",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("\n",contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);


        def sql = "CONTABLE..up_rpt_cartera_vencida " +
                " 'PS' , ${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' " +
                ", '${fin.format('MM/dd/yyyy')}'" + ",'${desde}','${hasta}', ${params.dias}"
        //println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..COMPROBANTES_TMP "
        //println "paso "
        def table = new PdfPTable(5);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [15,40,15,15,15];
        table.setWidths(anchos)
        def total = 0
        def   cell = new PdfPCell(new Paragraph("Cuenta", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Descripción", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Días Vencidos", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Último movimiento", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Saldo", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cn.eachRow(sql.toString()){r->
            total+=r["COM_SALDO"]
            cell = new PdfPCell(new Paragraph(r["CTA_CUENTA"], contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_LEFT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(r["CTA_DESCRIPCION"], contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_LEFT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("", contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_LEFT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(r["CON_FECHA"].format("dd-MM-yyyy"), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number:  r["COM_SALDO"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
        }

        cell = new PdfPCell(new Paragraph("TOTAL", titulo));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setColspan(4)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number:  total,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
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
