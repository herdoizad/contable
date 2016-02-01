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
import groovy.time.TimeCategory

class EstadoDeSituacionFinancieraController extends Shield {

    def dataSource
    def qrCodeService
    def reportesService
    def estado(){
        //println "esf "+params
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin
        def nivel = params.nivel.toInteger()
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        Document document = new Document();
        /*Cierre  - fin - inicio*/
        use ( TimeCategory ) {
            fin = new Date().parse("dd-MM-yyyy",params.fin) + 23.hours + 59.minutes + 59.seconds
        }
        println "fecha fin nueva "+ fin
        def sql = "CONTABLE..up_saldos_contables 'PS' ,'${cierre}' , '${fin.format('MM/dd/yyyy HH:mm:ss')}', '${inicio.format('MM/dd/yyyy')}'"
        println "sql up_saldos_contables "+sql
        cn.call(sql)
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL<=${nivel} order by CTA_CUENTA "
        //println "sql "+sql
        def result = [:]
        cn.eachRow(sql.toString()){r->
            result.put(r["CTA_CUENTA"].trim(),["saldo":r["CTA_SALDO"] , "nivel":r["CTA_NIVEL"],"desc":r["CTA_DESCRIPCION"].trim(),"debe":r["CTA_DEBE"],"haber":r["CTA_HABER"],"inicial":r["CTA_SALDO_INI"]])
        }
        def fecha = new Date()
        def nombre ="EstadoSituacionFinanciera-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(reportesService.getVcardReporte(session.usuario.login,"Estado de situación financiera"), 70, bs)
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(),bs, fecha, session.usuario.login,", Estado de situación financiera",null));
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
        p = new Paragraph("ESTADO SITUACIÓN FINANCIERA",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        document.add(new Paragraph("\n"));
        document.add(new Paragraph("\n"));
        def table = new PdfPTable(7);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [15,35,10,10,10,10,10];
        table.setWidths(anchos)
        def total1=0
        def total2=0
        def total3=0
        def total4=0
        def total5=0
        def total6=0
        def band = 1
        def show = true

        result.each {r->
           println "r "+r
            if(r.key=="1"){
                total1=r.value["debe"]-r.value["haber"]+r.value["inicial"]
            }
            if(r.key=="2"){
                total2=r.value["debe"]-r.value["haber"]+r.value["inicial"]
                band=2
            }
            if(r.key=="3"){
                total3=r.value["debe"]-r.value["haber"]+r.value["inicial"]
                band=3
            }
            if(r.key=="4"){
                total4=r.value["saldo"]
                //println "4 "+r
                show = false
            }
            if(r.key=="5"){
                total5=r.value["debe"]-r.value["haber"]+r.value["inicial"]
            //    println "5 "+r
            }
            if(r.key=="6"){
                total6=r.value["debe"]-r.value["haber"]+r.value["inicial"]
              //  println "6 "+r
            }
            switch (band){
                case 2:
                    (4).times {
                        def cell = new PdfPCell(new Paragraph("", contenido));
                        cell.setBorder(0)
                        table.addCell(cell);
                    }
                    def cell = new PdfPCell(new Paragraph("TOTAL ACTIVOS", titulo));
                    cell.setBorderWidth(1)
                    cell.setBorderWidthRight(0)
                    cell.setColspan(2)
                    cell.setPaddingBottom(3)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number: total1,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorderWidth(1)
                    cell.setBorderWidthLeft(0)
                    cell.setPaddingBottom(3)
                    table.addCell(cell);
                    band=0
                    break;
                case 3:
                    (4).times {
                        def cell = new PdfPCell(new Paragraph("", contenido));
                        cell.setBorder(0)
                        table.addCell(cell);
                    }
                    def cell = new PdfPCell(new Paragraph("TOTAL PASIVOS", titulo));
                    cell.setBorderWidth(1)
                    cell.setBorderWidthRight(0)
                    cell.setPaddingBottom(3)
                    cell.setColspan(2)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number: total2,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorderWidth(1)
                    cell.setBorderWidthLeft(0)
                    cell.setPaddingBottom(3)
                    table.addCell(cell);
                    band=0
                    break;
            }
            if(show){
                def cell = new PdfPCell(new Paragraph(r.key, contenido));
                cell.setBorder(0)
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph(r.value["desc"], contenido));
                cell.setBorder(0)
                table.addCell(cell);
                (5-r.value["nivel"]).times {
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                }
                cell = new PdfPCell(new Paragraph(formatNumber(number:  r.value["debe"]-r.value["haber"]+r.value["inicial"],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                cell.setBorder(0)
                table.addCell(cell);
                (r.value["nivel"]-1).times {
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setBorder(0)
                    table.addCell(cell);
                }
            }

        }


        (3).times {
            def cell = new PdfPCell(new Paragraph("", contenido));
            cell.setBorder(0)
            table.addCell(cell);
        }
        def cell = new PdfPCell(new Paragraph("TOTAL CAPITAL", titulo));
        cell.setBorderWidth(1)
        cell.setBorderWidthRight(0)
        cell.setBorderWidthBottom(0)
        cell.setPaddingBottom(3)
        cell.setColspan(3)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: total3,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorderWidth(1)
        cell.setBorderWidthLeft(0)
        cell.setBorderWidthBottom(0)
        cell.setPaddingBottom(3)
        table.addCell(cell);
        (3).times {
             cell = new PdfPCell(new Paragraph("", contenido));
            cell.setBorder(0)
            table.addCell(cell);
        }
        cell = new PdfPCell(new Paragraph("UTILIDAD EJERCICIO", titulo));
        cell.setBorderWidth(1)
        cell.setBorderWidthRight(0)
        cell.setBorderWidthBottom(0)
        cell.setPaddingBottom(3)
        cell.setColspan(3)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: total4,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorderWidth(1)
        cell.setBorderWidthBottom(0)
        cell.setBorderWidthLeft(0)
        cell.setPaddingBottom(3)
        table.addCell(cell);
        (3).times {
            cell = new PdfPCell(new Paragraph("", contenido));
            cell.setBorder(0)
            table.addCell(cell);
        }
        cell = new PdfPCell(new Paragraph("TOTAL PATRIMONIO", titulo));
        cell.setBorderWidth(1)
        cell.setBorderWidthRight(0)
        cell.setBorderWidthBottom(0)
        cell.setPaddingBottom(3)
        cell.setColspan(3)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: total4+total3,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorderWidth(1)
        cell.setBorderWidthLeft(0)
        cell.setBorderWidthBottom(0)
        cell.setPaddingBottom(3)
        table.addCell(cell);
        (3).times {
            cell = new PdfPCell(new Paragraph("", contenido));
            cell.setBorder(0)
            table.addCell(cell);
        }
        cell = new PdfPCell(new Paragraph("TOTAL PASIVO + PATRIMONIO", titulo));
        cell.setBorderWidth(1)
        cell.setBorderWidthRight(0)
        cell.setPaddingBottom(3)
        cell.setColspan(3)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number:total4+total3+total2-total6,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorderWidth(1)
        cell.setBorderWidthLeft(0)
        cell.setPaddingBottom(3)
        table.addCell(cell);
        document.add(table)


        if(nivel==3){
            table = new PdfPTable(3);
            table.setWidthPercentage(95.toFloat())
            anchos = [33,33,34];
            table.setWidths(anchos)
            cell = new PdfPCell(new Paragraph("\n\n\n\n\n\n\n", titulo));
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
            cell = new PdfPCell(new Paragraph("Pablo Orozco Salazar\n PRESIDENTE EJECUTIVO", titulo));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            cell.setBorder(0)
            cell.setBorderWidthTop(1)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("", titulo));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            cell.setBorder(0)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph("Gina Martinez Ortega\n CONTADOR", titulo));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            cell.setBorder(0)
            cell.setBorderWidthTop(1)
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





}

