package contable.nomina.reportes

import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfWriter
import contable.nomina.Empleado
import contable.nomina.Sueldo
import contable.seguridad.Shield

class CertificadosController extends Shield {
    def qrCodeService
    def nuevoCertificado() {
        def empleados = Empleado.findAllByEstado("A")
        [empleados:empleados]

    }


    def imprimeCertificado(){
        println "params "+params
        def texto = params.text
        def empleado = Empleado.get(params.id)
        Document document = new Document();
        def fecha = new Date()
        def nombre ="certificado-${fecha.format('ddMMyyyy')}.pdf"
        ByteArrayOutputStream bs = new ByteArrayOutputStream()
        qrCodeService.renderPng(getVcard_ajax("Certificado de trabajo del empleado: ${empleado}"), 65, bs)
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
        document.add(new Paragraph(texto))


        document.close();
        def b = baos.toByteArray()
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }



    def generarTexto_ajax(){
        def empleado = Empleado.get(params.id)
        def sueldo = Sueldo.findAllByEmpleado(empleado,[sort:"inicio"])
        if(sueldo.size()>0)
            sueldo=sueldo.pop()
        [empleado:empleado,sueldo:sueldo]
    }

    String getVcard_ajax(title) {
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
