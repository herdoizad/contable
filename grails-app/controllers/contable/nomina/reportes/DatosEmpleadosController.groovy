package contable.nomina.reportes
import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter
import contable.nomina.Contrato
import contable.nomina.ContratoController
import contable.nomina.Empleado
import contable.nomina.MesNomina
import contable.nomina.Rol
import contable.nomina.Sueldo
import contable.nomina.TipoContrato
import contable.seguridad.Shield
class DatosEmpleadosController extends Shield {

    def reporte() {
        Document document = new Document();
        def fecha = new Date()
        def nombre ="datosEmpleados-${fecha.format('ddMMyyyy')}.pdf"
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
        p = new Paragraph("Datos de los empleados", titulo);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);
        def table = new PdfPTable(14);
        table.setWidthPercentage(99.toFloat())
        int[] anchos = [7,7,7,6,7,7,7,9,11,3,3,7,7,5];
        table.setWidths(anchos)
        def cell
        cell = new PdfPCell(new Paragraph("Nombre", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Apellido", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Cédula", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Estado Civil", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Dirección", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Telefono", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Fecha Nacimiento", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Nacionalidad", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Cargo", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Sexo", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Tipo de Sangre", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Codigo Sectorial", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Ciudad Trabajo", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        cell = new PdfPCell(new Paragraph("Tipo Contrato", contenido));
        cell.setBorder(0)
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        table.addCell(cell);
        //def emp = Empleado.get(params.id)
        //def sueld = Sueldo.findAllByEmpleado(em)
        //def con = Contrato.findByEmpleadoAndFin(emp,"null")
        //def tipo = TipoContrato.get(params.id)
        //def tcon = TipoContrato.findByCodigo()
        //def resp = con.tipo.des

        Empleado.listOrderByApellido().each {emp->
            def con = Contrato.findByEmpleadoAndFinIsNull(emp)


            //sueld.each {s ->
               // println "empleado: " +  s.empleado.nombre + " ingresos: " + s.sueldo
           // }
            cell = new PdfPCell(new Paragraph(emp.nombre, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.apellido, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.cedula, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.estadoCivil.descripcion, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.direccion, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.telefono, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.fechaNacimiento?.format("dd-MM-yyyy"), contenido));
            table.addCell(cell)
            // formato tipo date
            // signo de interrogacion para que no de error si esxisten null
            cell = new PdfPCell(new Paragraph(emp.nacionalidad, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.cargo, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.sexo, contenido));
             cell.setHorizontalAlignment(Element.ALIGN_CENTER)
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.tipoSangre, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.codigoSectorial, contenido));
            table.addCell(cell);
            cell = new PdfPCell(new Paragraph(emp.ciudadTrabajo, contenido));
            table.addCell(cell);
            //cell = new PdfPCell(new Paragraph(formatNumber(number: sueld.empleado,maxFractionDigits: 2,format: "###,##0",minFractionDigits: 2 ), contenido));
            //table.addCell(cell);
            //cell = new PdfPCell(new Paragraph(con?.tipo, contenido));
            cell = new PdfPCell(new Paragraph("" +con?.tipo?.descripcion, contenido));
            table.addCell(cell);

        }
        document.add(table)
        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }
}

//// Sueldo.findbYEmpleadoandfinisnull(emp)
//s
// detalleRol.findAllByrolandsigno(r,-1)
