package contable.nomina.reportes

import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter
import contable.nomina.MesNomina
import contable.nomina.Sueldo
import groovy.sql.Sql
import contable.nomina.DetalleRol
import contable.nomina.Empleado
import contable.nomina.Rol
import contable.seguridad.Shield

import javax.swing.GroupLayout

class ReporteRolController extends Shield {

    def qrCodeService

    def reporte() {
        Document document = new Document();
        def fecha = new Date()
        def nombre ="rolEmpleado-${fecha.format('ddMMyyyy')}.pdf"
        //Document document = new Document();
        //def fecha = new Date()
        def rol = Rol.get(params.id)
        def ingresos = DetalleRol.findAllByRolAndSigno(rol,1)
        def egresos = DetalleRol.findAllByRolAndSigno(rol,-1)
        def meses = ["0":"Todos","1":"Enero","2":"Febero","3":"Marzo","4":"Abril","5":"Mayo","6":"Junio","7":"Juilo","8":"Agosto","9":"Septiembre","10":"Octubre","11":"Noviembre","12":"Diciembre"]
        //def nombre ="rolEmpleado-${rol.empleado.nombre}-${fecha.format('ddMMyyyy')}.pdf"
        //def nombre ="rolEmpleado-${rol.empleado.nombre}-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(getVcard("Rol de pagos de ${rol.empleado}, mes de ${rol.mes.descripcion}"), 65, bs)
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-60x60.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(),bs, fecha, session.usuario.login,"",null));
        Font header = new Font(Font.FontFamily.HELVETICA, 12, Font.UNDERLINE | Font.BOLD);
        Font titulo = new Font(Font.FontFamily.HELVETICA, 9, Font.BOLD);
        Font contenido = new Font(Font.FontFamily.HELVETICA, 8);
        document.open();
        Image image = Image.getInstance(img.readBytes());
        image.setAbsolutePosition(40f, 740f);
        document.add(image);
        image = Image.getInstance(bs.toByteArray());
        image.setAbsolutePosition(500f, 738f);
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
        p = new Paragraph("Rol Empleado", titulo);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);
        def table = new PdfPTable(10);
        table.setWidthPercentage(99.toFloat())//EL PORCENTAJE DE PAG 95
        int[] anchos = [15,9,9,9,9,9,9,9,9,9];
        table.setWidths(anchos)
        def cell
        cell = new PdfPCell(new Paragraph("Nombre", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Ingreso", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Egreso", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("RMU", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        def mes = MesNomina.get(params.id) //traer el mes que llega de parametros vista.getrolmes(imprimir)
        def roles = Rol.findAllByMes(mes)//traer roles de pago del mes
        //def rol = Rol.get(params.id) traer id rol -31082015
        //def detrol = DetalleRol.findAllByRol(rol) traer detalles de rol segun id anterior -31082015
        //def emp = Empleado.get(params.id) -31082015
        def emp = Empleado.get(params.id)
        def s = Sueldo.findByEmpleadoAndFinIsNull(emp) //02092015
        roles.each{r-> // iterando todos los roles
            def dr = DetalleRol.findAllByRolAndSigno(r, +1)
            def tmo = dr.size()
            //def tmo2 = dr2.size()

            def y = 0
            while (y < tmo ){
                 cell = new PdfPCell(new Paragraph(dr.descripcion[y], contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                y++
            }
            cell = new PdfPCell(new Paragraph(r.empleado.nombre + " " + r.empleado.apellido, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: r.totalIngresos,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: r.totalEgresos,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: s.sueldo,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            table.addCell(cell);
            def x = 0
            while (x < tmo ){

                cell = new PdfPCell(new Paragraph(formatNumber(number: dr.valor[x],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                table.addCell(cell);
                x++
            }
        }
        document.add(table)
        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)


    }

    def reporteRol(){
        Document document = new Document();

        def fecha = new Date()
        def rol = Rol.get(params.id)
        def ingresos = DetalleRol.findAllByRolAndSigno(rol,1)
        def egresos = DetalleRol.findAllByRolAndSigno(rol,-1)
        def meses = ["0":"Todos","1":"Enero","2":"Febero","3":"Marzo","4":"Abril","5":"Mayo","6":"Junio","7":"Juilo","8":"Agosto","9":"Septiembre","10":"Octubre","11":"Noviembre","12":"Diciembre"]
        def nombre ="rolEmpleado-${rol.empleado.nombre}-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(getVcard("Rol de pagos de ${rol.empleado}, mes de ${rol.mes.descripcion}"), 65, bs)
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        def writer = PdfWriter.getInstance(document, baos);
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-60x60.png').getFile()
        writer.setPageEvent(new contable.HeaderFooter(img.readBytes(),bs, fecha, session.usuario.login,"",null));
        Font header = new Font(Font.FontFamily.HELVETICA, 12, Font.UNDERLINE | Font.BOLD);
        Font titulo = new Font(Font.FontFamily.HELVETICA, 9, Font.BOLD);
        Font contenido = new Font(Font.FontFamily.HELVETICA, 8);
        document.open();
        Image image = Image.getInstance(img.readBytes());
        image.setAbsolutePosition(40f, 740f);
        document.add(image);
        image = Image.getInstance(bs.toByteArray());
        image.setAbsolutePosition(500f, 738f);
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
        document.add(new Paragraph("ROL DEL PAGOS MES DE "+meses[new Date().parse("yyyyMMdd",""+rol.mes.codigo+"01").format("M")].toUpperCase()));
        document.add(new Paragraph("\n"));
        p = new Paragraph("Detalle de ingresos y descuentos", contenido);
        document.add(p)
        p = new Paragraph("Apellidos y nombres: "+rol.empleado, contenido);
        document.add(p)
        document.add(new Paragraph("\n"));
        p = new Paragraph("INGRESOS", titulo);
        p.setAlignment(Element.ALIGN_LEFT);
        document.add(p);
        def table = new PdfPTable(2);
        table.setWidthPercentage(60.toFloat())//EL PORCENTAJE DE PAG 95
        table.setHorizontalAlignment(Element.ALIGN_LEFT)
        int[] anchos = [70,30];
        table.setWidths(anchos)
        def cell
        p = new Paragraph("\n", titulo);
        document.add(p);
        def su = 0
        ingresos.each{d->

            def suu = su + d.valor

            cell = new PdfPCell(new Paragraph(d.descripcion, contenido));
            cell.setBorder(0)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: d.valor,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            cell.setBorder(0)
            table.addCell(cell);

        }



        document.add(table)
        p = new Paragraph("Total ingresos: "+formatNumber(number: rol.totalIngresos,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo);
        document.add(p);
        p = new Paragraph("\n", titulo);
        document.add(p);
        p = new Paragraph("\n", titulo);
        document.add(p);
        p = new Paragraph("EGRESOS", titulo);
        p.setAlignment(Element.ALIGN_LEFT);
        document.add(p);
        p = new Paragraph("\n", titulo);
        document.add(p);
        table = new PdfPTable(2);
        table.setWidthPercentage(60.toFloat())//EL PORCENTAJE DE PAG 95
        table.setHorizontalAlignment(Element.ALIGN_LEFT)
        anchos = [70,30];
        table.setWidths(anchos)

         egresos.each{d->
            cell = new PdfPCell(new Paragraph(d.descripcion, contenido));
            cell.setBorder(0)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: d.valor,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT)
            cell.setBorder(0)
            table.addCell(cell);

        }

        //s = egresos
        document.add(table)
        p = new Paragraph("Total egresos: "+formatNumber(number: rol.totalEgresos,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), titulo);
        document.add(p);
        p = new Paragraph("\n", titulo);
        document.add(p);
        p = new Paragraph("Total a recibir: "+g.formatNumber(number:  rol.totalIngresos-rol.totalEgresos,type: "currency",currencySymbol: ""), titulo);
        p.setAlignment(Element.ALIGN_LEFT);
        document.add(p);


        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
        println "lLlego"

    }
    String getVcard(title) {
        def s = new StringBuilder()
        s << "BEGIN:VCARD\n"
        s << "VERSION:3.0\n"
        s << "N:${session.usuario.login};;;\n"
        s << "FN: Generado por: ${session.usuario.login}\n"
        s << "ORG:Petroleos y Servicios\n"
        s << "TITLE:${title ? title.replace(',', '\\,') : ''}\n"
        s << "TEL;TYPE=work,voice,pref:381-9680\n"
        s << "REV:${new Date().format('dd-MM-yyyy HH:mm')}\n"
        s << "END:VCARD\n"
        return s.toString()
    }

}





//detallerol.finfallbyrolandcodigoInList(r, ["H100", "H200, H150])

// rubro.totalingreso

