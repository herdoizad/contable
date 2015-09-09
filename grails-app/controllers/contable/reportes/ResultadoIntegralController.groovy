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


class ResultadoIntegralController extends Shield {
    def dataSource
    def qrCodeService
    def reportesService
    def reporte(){
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def nivel = params.nivel.toInteger()
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="ResultadoIntegral-${fecha.format('ddMMyyyy')}.pdf"
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
        p = new Paragraph("ESTADO DE RESULTADOS INTEGRAL",titulo)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        p = new Paragraph("Desde: ${inicio.format("dd-MM-yyyy")} Hasta: "+fin.format("dd-MM-yyyy"),contenido)
        p.setAlignment(Element.ALIGN_CENTER)
        document.add(p);
        document.add(new Paragraph("\n"));
        document.add(new Paragraph("\n"));
        def sql = "CONTABLE..up_bce_resultados_mes 'PS' ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}', '${cierre}'"
        println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL<=${nivel} order by CTA_CUENTA "
        println "sql "+sql
        def result = [:]
        result.put("INGRESOS",[])
        result.put("COSTO DE VENTAS",[])
        result.put("GASTOS DE OPERACION",[])
        result.put("INGRESOS NO OPERATIVOS",[])
        result.put("GASTOS NO OPERATIVOS",[])
        result.put("COSTOS Y GASTOS",[])
        cn.eachRow(sql.toString()){r->
            if(r["CTA_TITULO"].trim()!="") {
                result[r["CTA_TITULO"].trim()].add(["cuenta"     : r["CTA_CUENTA"].trim(), "saldo": r["CTA_SALDO"]
                                                    , "desc2"    : r["CTA_DESCRIPCION_MAYOR"], "nivel": r["CTA_NIVEL"]
                                                    , "desc"     : r["CTA_DESCRIPCION"].trim(), "debe": r["CTA_DEBE"]
                                                    , "haber"    : r["CTA_HABER"], "inicial": r["CTA_SALDO_INI"]
                                                    , "utilidadb": r["UTILIDAD_BRUTA"], "utilidado": r["UTILIDAD_OPERATIVA"]])
            }

        }

        def table = new PdfPTable(7);
        table.setWidthPercentage(95.toFloat())
        int[] anchos = [15,30,10,10,10,12,13];
        table.setWidths(anchos)
        def ub=0
        def uo=0
        def ino = 0
        def gno = 0
        def last = ""
        def detalle = []
        def desc=""
        def total = 0
        result.eachWithIndex {r,i->
            if(r.key!="COSTOS Y GASTOS"){
                if(last!=""){
                    def cell = new PdfPCell(new Paragraph(last, titulo));
                    cell.setBorder(0)
                    cell.setColspan(6)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number: total,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorder(0)
                    table.addCell(cell);
                    if(desc=="INGRESOS")
                        desc="INGRESOS ORDINARIOS"
                    cell = new PdfPCell(new Paragraph(desc, titulo));
                    cell.setBorder(0)
                    cell.setColspan(5)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(formatNumber(number:  total,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorder(0)
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("", contenido));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                    cell.setBorder(0)
                    table.addCell(cell);

                    detalle.each {
                        table.addCell(it)
                    }
                    if(i==2){
                        cell = new PdfPCell(new Paragraph("UTILIDAD BRUTA", titulo));
                        cell.setBorder(0)
                        cell.setColspan(6)
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(formatNumber(number: ub,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        cell.setBorder(0)
                        cell.setBorderWidthTop(1)
                        table.addCell(cell);
                    }
                    if(i==3){
                        cell = new PdfPCell(new Paragraph("UTILIDAD OPERATIVA", titulo));
                        cell.setBorder(0)
                        cell.setColspan(6)
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        table.addCell(cell);
                        cell = new PdfPCell(new Paragraph(formatNumber(number: uo,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        cell.setBorder(0)
                        cell.setBorderWidthTop(1)
                        table.addCell(cell);
                    }
                    (21).times {
                        cell = new PdfPCell(new Paragraph("   ", contenido));
                        cell.setBorder(0)
                        table.addCell(cell);
                    }
                }
                last=r.key
                def cont = 0
                detalle = []
                total = 0
                desc =""
                r.value.each {c->
                    if(cont==0){
                        desc=c["desc2"]
                    }
                    ub=c["utilidadb"]
                    uo=c["utilidado"]
                    def cell
                    def saldo = c["saldo"]
                    def valor = c["debe"]-c["haber"]+c["inicial"]
                    if(saldo<0)
                        saldo=saldo*-1
                    if(valor<0)
                        valor=valor*-1
                    if(c["nivel"]>2){
                        if(c["nivel"]==nivel)
                            total+=valor
                        cell = new PdfPCell(new Paragraph(c["cuenta"], contenido));
                        cell.setBorder(0)
                        detalle.add(cell);
                        cell = new PdfPCell(new Paragraph(c["desc"], contenido));
                        cell.setBorder(0)
                        detalle.add(cell);
                        (5-c["nivel"]).times {
                            cell = new PdfPCell(new Paragraph("", contenido));
                            cell.setBorder(0)
                            detalle.add(cell);
                        }
                        cell = new PdfPCell(new Paragraph(formatNumber(number:  valor,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
                        cell.setBorder(0)
                        detalle.add(cell);
                        (c["nivel"]-1).times {
                            cell = new PdfPCell(new Paragraph("", contenido));
                            cell.setBorder(0)
                            detalle.add(cell);
                        }
                    }
                    cont++
                }
                if(r.key=="INGRESOS NO OPERATIVOS"){
                    ino=total
                }
                if(r.key=="GASTOS NO OPERATIVOS"){
                    gno=total
                }
            }

        }
        def cell = new PdfPCell(new Paragraph(last, titulo));
        cell.setBorder(0)
        cell.setColspan(6)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: total,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(desc, titulo));
        cell.setBorder(0)
        cell.setColspan(5)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number:  total,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorder(0)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("", contenido));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorder(0)
        table.addCell(cell);
        detalle.each {
            table.addCell(it)
        }
        (21).times {
            cell = new PdfPCell(new Paragraph("   ", contenido));
            cell.setBorder(0)
            table.addCell(cell);
        }
        cell = new PdfPCell(new Paragraph("RESULTADO DEL EJERCICIO", titulo));
        cell.setBorder(0)
        cell.setColspan(6)
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph(formatNumber(number: uo+ino-gno,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
        cell.setBorder(0)
        table.addCell(cell);
        println "UO "+uo+" ingresos  "+ino+" egresos "+gno

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
