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
import groovy.sql.Sql

class AuxiliarRangoController {
    def dataSource
    def index() {
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cuenta = Cuenta.findByNumeroAndEmpresa(params.cuenta,session.empresa)
        def desde = params.desde.toInteger()
        def hasta = params.hasta.toInteger()
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="Auxiliar-${cuenta.numero.trim()}-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/logo-login.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(), fecha, session.usuario.login,""));
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
        p = new Paragraph("Auxiliar",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);


        (desde..hasta).each {
            def num = params.cuenta.trim()
            def n = it.toString()
            (3-n.length()).times {
                num+="0"
            }
            num+=n
            //println "num "+num
            auxiliarCuenta_ajax(cn,document,num,inicio,fin,titulo,contenido)
        }



        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }




    def auxiliarCuenta_ajax(cn,document,cuenta,inicio,fin,titulo,contenido){
        def sql = "CONTABLE..up_rpt_auxiliar_por_cta  'PS' , ${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}','${cuenta.trim()}', 'S'"
       // println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..COMPROBANTES_TMP "
        // println "sql "+sql
        def cont = 0
        def table = new PdfPTable(6);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [10,15,30,15,15,15];
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
                cell = new PdfPCell(new Paragraph(r["CTA_DESCRIPCION"], titulo));
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

                cell = new PdfPCell(new Paragraph("\n", titulo));
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
            cell = new PdfPCell(new Paragraph("PS-"+r["COM_MES_CODIGO"]+getTipo_ajax(r["COM_TIPO_CODIGO"])+"-"+r["COM_NUMERO"], contenido));
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
        if(cont>0) {
            cell = new PdfPCell(new Paragraph("Suman: ", titulo));
            cell.setBorder(0)
            cell.setColspan(3)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: debe, maxFractionDigits: 2, format: "###,##0", minFractionDigits: 2), contenido));
            cell.setBorder(0)
            cell.setBorderWidthTop(1)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: haber, maxFractionDigits: 2, format: "###,##0", minFractionDigits: 2), contenido));
            cell.setBorder(0)
            cell.setBorderWidthTop(1)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("", contenido));
            cell.setBorder(0)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("\n\n", titulo));
            cell.setBorder(0)
            cell.setColspan(6)
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            table.addCell(cell);
            document.add(table)
        }

    }

    def getTipo_ajax(tipo){
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
