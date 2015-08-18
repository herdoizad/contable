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
import contable.core.Comprobante
import contable.core.DetalleComprobante
import contable.seguridad.Shield
import groovy.sql.Sql

class DiarioGeneralController extends Shield {
    def dataSource
    def index() {

        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cierre = "01/01/2015"
        def banco = Banco.findByCodigo(params.banco)
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="DiarioGeneral-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/logo-login.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(), fecha, session.usuario.login,", DIARIO GENERAL"));
        Font header = new Font(Font.FontFamily.HELVETICA, 12, Font.UNDERLINE | Font.BOLD);
        Font titulo = new Font(Font.FontFamily.HELVETICA, 7, Font.BOLD);
        Font contenido = new Font(Font.FontFamily.HELVETICA, 6);
        document.open();
        Image image = Image.getInstance(img.readBytes());
        image.setAbsolutePosition(40f, 738f);
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
        p = new Paragraph("DIARIO GENERAL",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        def cont = 0
        def sql = "CONTABLE..up_rpt_diario_general  'PS' ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}'"
        println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..COMPROBANTES_TMP  order by COM_NUMERO"
        def cell
        def td = 0,th=0
        def last = null
        def table = null
        cn.eachRow(sql.toString()){r->
            if(last!=r["COM_NUMERO"]){
                if(table!=null)
                    document.add(table)

                p = new Paragraph(imprimeNumero_ajax(r["COM_NUMERO"]),titulo)
                p.setAlignment(Element.ALIGN_CENTER)
                document.add(p);
                p = new Paragraph(r["COM_CONCEPTO"],titulo)
                p.setAlignment(Element.ALIGN_LEFT)
                document.add(p);
                table = new PdfPTable(5);
                table.setWidthPercentage(95.toFloat())
                int[] anchos = [15,40,15,15,15];
                table.setWidths(anchos)
            }
            last=r["COM_NUMERO"]
            cell = new PdfPCell(new Paragraph(r["CTA_CUENTA"], contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_LEFT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(r["CTA_DESCRIPCION"], contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_LEFT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("PS-"+r["COM_MES_CODIGO"]+"-D-"+r["COM_NUMERO"], contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_LEFT)
            table.addCell(cell);
            def debe = r["COM_DEBE"]
            def haber = r["COM_HABER"]
            td+=debe
            th+=haber
            cell = new PdfPCell(new Paragraph(formatNumber(number: debe,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number:  haber,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
        }

       if(table!=null){
           cell = new PdfPCell(new Paragraph("Totales", titulo))
           cell.setBorder(0)
           cell.setColspan(3)
           cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
           table.addCell(cell);
           cell = new PdfPCell(new Paragraph(formatNumber(number: td,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
           cell.setBorder(0)
           cell.setBorderWidthTop(1)
           cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
           table.addCell(cell);
           cell = new PdfPCell(new Paragraph(formatNumber(number:  th,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
           cell.setBorder(0)
           cell.setBorderWidthTop(1)
           cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
           table.addCell(cell);
           document.add(table)
       }


        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)

    }


    def imprimeNumero_ajax(numero){
        def res ="-"
        def num = numero.toString().trim()
        (8-num.length()).times {
            res+="0"
        }
        res+=num
        res+="-"
        return res
    }
}
