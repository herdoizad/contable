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

class BalanceComprobacionController extends Shield {
    def dataSource
    def reporte(){
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def nivel = params.nivel.toInteger()
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="BalanceDeComprobacion-${fecha.format('ddMMyyyy')}.pdf"
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
        p = new Paragraph("BALANCE DE COMPROBACION",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        def sql = "CONTABLE..up_arbol_inverso 'PS' ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}', '${cierre}'"
        println "sql "+sql
        cn.call(sql)
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL<=${nivel} order by CTA_CUENTA "
        println "sql "+sql

        def table = new PdfPTable(8);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [9,19,12,12,12,12,12,12];
        table.setWidths(anchos)

        def cell = new PdfPCell(new Paragraph("", titulo));
        cell.setBorder(0)
        cell.setColspan(2)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Saldo inicial", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(2)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Movimientos", contenido));
        cell.setBorder(0)
        cell.setColspan(2)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Balance de comprobación", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(2)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Código", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Descripción", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Debe", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Haber", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Debe", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Haber", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Debe", contenido));
        cell.setBorder(0)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Haber", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setColspan(1)
        table.addCell(cell);
        def last ="1"
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("ACTIVO", titulo));
        cell.setBorder(0)
        cell.setColspan(7)
        table.addCell(cell);
        def totalds=0,totalhs=0,totaldm=0,totalhm=0,totaldb=0,totalhb=0,totaldsg=0,totalhsg=0,totaldmg=0,totalhmg=0,totaldbg=0,totalhbg=0
        cn.eachRow(sql.toString()){r->
            if(r["CTA_NIVEL"]==nivel){

                if(r["CTA_CUENTA"].startsWith("2.") && last=="1"){
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalds,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhs,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb

                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("PASIVO", titulo));
                    cell.setBorder(0)
                    cell.setColspan(7)
                    table.addCell(cell);
                    last="2"
                }
                if(r["CTA_CUENTA"].startsWith("3.")  && last=="2"){
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalds,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhs,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb
                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("CAPITAL LIQUIDO CONTABLE", titulo));
                    cell.setBorder(0)
                    cell.setColspan(7)
                    table.addCell(cell);
                    last="3"
                }
                if(r["CTA_CUENTA"].startsWith("4.")  && last=="3"){
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalds,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhs,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb
                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("INGRESOS", titulo));
                    cell.setBorder(0)
                    cell.setColspan(7)
                    table.addCell(cell);
                    last="4"
                }
                if(r["CTA_CUENTA"].startsWith("5.")  && last=="4"){
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalds,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhs,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
                    cell.setBorder(0)
                    cell.setBorderWidthTop(1)
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    table.addCell(cell);
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb
                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("COSTOS Y GASTOS DE OPERACION", titulo));
                    cell.setBorder(0)
                    cell.setColspan(7)
                    table.addCell(cell);
                    last="5"
                }

                def ini = r["CTA_SALDO_INI"]
                def sdebe=0
                def shaber = 0
                if(ini>0)
                    sdebe=ini
                else
                    shaber=ini
                totalds+=sdebe
                totalhs+=shaber
                totaldm+=r["CTA_DEBE"]
                totalhm+=r["CTA_HABER"]
                totaldb+=r["CTA_SALDO_DEU"]
                totalhb+=r["CTA_SALDO_ACR"]
                cell = new PdfPCell(new Paragraph(r["CTA_CUENTA"], contenido));
                cell.setBorder(0)
                cell.setColspan(1)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(r["CTA_DESCRIPCION"], contenido));
                cell.setBorder(0)
                cell.setColspan(1)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(g.formatNumber(number: sdebe,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(g.formatNumber(number:shaber,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(g.formatNumber(number: r["CTA_DEBE"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(g.formatNumber(number: r["CTA_HABER"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(g.formatNumber(number: r["CTA_SALDO_DEU"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(g.formatNumber(number: r["CTA_SALDO_ACR"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                table.addCell(cell);
            }

        }
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        cell.setColspan(2)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalds,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhs,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhm,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhb,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        totaldsg+=totalds
        totalhsg+=totalhs
        totaldmg+=totaldm
        totalhmg+=totalhm
        totaldbg+=totaldb
        totalhbg+=totalhb
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setBorder(0)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("TOTAL GENERAL", titulo));
        cell.setBorder(0)
        cell.setColspan(1)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldsg,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhsg,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldmg,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhmg,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totaldbg,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
        cell.setBorder(0)
        cell.setBorderWidthTop(1)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(g.formatNumber(number: totalhbg,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2), titulo));
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
