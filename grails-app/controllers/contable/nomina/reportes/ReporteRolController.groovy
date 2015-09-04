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

class ReporteRolController extends Shield {

    def reporte() {
        Document document = new Document();
        def fecha = new Date()
        def nombre ="rolEmpleado-${fecha.format('ddMMyyyy')}.pdf"
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
        //def rol = Rol.get(params.id)
        roles.each{r-> // iterando todos los roles
            def dr = DetalleRol.findAllByRolAndSigno(r, +1)
            //def dr2 = DetalleRol.findAllByRolAndSigno(r, -1)
            def tmo = dr.size()
            //def tmo2 = dr2.size()

            def y = 0
            while (y < tmo ){
                //println " Ingreso: " + dr.valor[x]
                cell = new PdfPCell(new Paragraph(dr.descripcion[y], contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                y++
            }
            /*def w = 0
            while (w < tmo2 ){
                //println " Ingreso: " + dr.valor[x]
                cell = new PdfPCell(new Paragraph(dr2.descripcion[w], contenido));
                cell.setBorder(0)
                cell.setHorizontalAlignment(Element.ALIGN_CENTER)
                table.addCell(cell);
                w++
            }*/
            //println "empleado: " +  r.empleado.nombre + " Ingreso: " + tmo + " Ingreso: " + dr.valor + " egresos : " + r.totalEgresos
            //+ "tamaño descripcion" + dr.descripcion.size() + "tamaño valor" + dr.valor.size()
           // lo anterior imprime en consola resultado
            cell = new PdfPCell(new Paragraph(r.empleado.nombre + " " + r.empleado.apellido, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: r.totalIngresos,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            table.addCell(cell);
            //cell = new PdfPCell(new Paragraph(r.totalIngresos, contenido));
           cell = new PdfPCell(new Paragraph(formatNumber(number: r.totalEgresos,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
           table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: s.sueldo,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            table.addCell(cell);
            def x = 0
            while (x < tmo ){
                //println " Ingreso: " + dr.valor[x]
                cell = new PdfPCell(new Paragraph(formatNumber(number: dr.valor[x],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                table.addCell(cell);
                x++
            }
            /*def z = 0
            while (z < tmo2 ){
                //println " Ingreso: " + dr.valor[x]
                cell = new PdfPCell(new Paragraph(formatNumber(number: dr2.valor[z],maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
                table.addCell(cell);
                x++
            }*/



           // detrol.each {dr->
           //cell = new PdfPCell(new Paragraph(dr.descripcion, contenido)); //-31082015
           //table.addCell(cell); //-31082015
            //}
            //sueld.each {sld->
            //cell = new PdfPCell(new Paragraph(formatNumber(number:sld.sueldo,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            //table.addCell(cell); //-31082015
            //}




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
        def nombre ="rolEmpleado-${fecha.format('ddMMyyyy')}.pdf"
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
        p = new Paragraph("Rol Empleado", titulo);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);
        p = new Paragraph("INGRESO", titulo);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);
        def table = new PdfPTable(2);
        table.setWidthPercentage(95.toFloat())//EL PORCENTAJE DE PAG 95
        int[] anchos = [40,40];
        table.setWidths(anchos)
        def cell
        cell = new PdfPCell(new Paragraph("RUBRO", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
       cell = new PdfPCell(new Paragraph("VALOR", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        def rol = Rol.get(params.id)
        //def det = DetalleRol.findAllByRolAndSigno(rol, +1)
        def det = DetalleRol.findAllByRol(rol)
        det.each{d->
            cell = new PdfPCell(new Paragraph(d.descripcion, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(formatNumber(number: d.valor,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            table.addCell(cell);
        }

        /*document.add(new Paragraph("\n"));
        document.add(new Paragraph("\n"));
        p = new Paragraph("EGRESO", titulo);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);

        document.add(new Paragraph("\n"));
        document.add(new Paragraph("\n"));

        def table2 = new PdfPTable(2);
        table2.setWidthPercentage(95.toFloat())//EL PORCENTAJE DE PAG 95
        int[] anchose = [40,40];
        table2.setWidths(anchose)
        def celle
        celle = new PdfPCell(new Paragraph("RUBRO", contenido));
        celle.setBorder(0)
        celle.setHorizontalAlignment(Element.ALIGN_CENTER)
        table2.addCell(cell);
        celle = new PdfPCell(new Paragraph("VALOR", contenido));
        celle.setBorder(0)
        celle.setHorizontalAlignment(Element.ALIGN_CENTER)
        table2.addCell(cell);
        def det2 = DetalleRol.findAllByRolAndSigno(rol, -1)
        det2.each{d2->
            celle = new PdfPCell(new Paragraph(d2.descripcion, contenido));
            table2.addCell(celle);
            celle = new PdfPCell(new Paragraph(formatNumber(number: d2.valor,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            table2.addCell(celle);


        }*/

        //ROL
        //DETALLE
        document.add(table)
        //document.add(table2)
        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
        println "lLlego"
    }
}

//detallerol.finfallbyrolandcodigoInList(r, ["H100", "H200, H150])

// rubro.totalingreso

