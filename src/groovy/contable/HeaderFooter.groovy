package contable

import com.itextpdf.text.BaseColor
import com.itextpdf.text.Chunk
import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.ExceptionConverter
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.Phrase
import com.itextpdf.text.Rectangle
import com.itextpdf.text.pdf.BaseFont
import com.itextpdf.text.pdf.ColumnText
import com.itextpdf.text.pdf.PdfAction
import com.itextpdf.text.pdf.PdfContentByte
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfPageEvent
import com.itextpdf.text.pdf.PdfWriter

/**
 * Created by ZAPATAV on 6/3/2015.
 */
class HeaderFooter implements PdfPageEvent{
    protected Phrase headerP;
    protected PdfPTable footer;
    def total
    def helv
    def r
    def img
    def fecha
    Font header = new Font(Font.FontFamily.HELVETICA  , 12,Font.UNDERLINE | Font.BOLD);
    Font titulo = new Font(Font.FontFamily.HELVETICA    , 10,Font.BOLD);
    Font contenido = new Font(Font.FontFamily.HELVETICA, 8);
    public HeaderFooter(img,fecha,usuario,extra) {

        this.img=img
        this.fecha=fecha

        footer = new PdfPTable(1);
        footer.setTotalWidth(500);
        footer.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
        def cell = new PdfPCell(new Paragraph("Impreso el "+new Date().format("dd-MM-yyyy")+", generado por: "+usuario+extra,contenido));
        cell.setBorder(0)
        footer.addCell(cell)


    }
    public void onEndPage(PdfWriter writer, Document document) {
        PdfContentByte cb = writer.getDirectContent();
        if (document.getPageNumber() > 1) {
            Image image = Image.getInstance(this.img);
            image.setAbsolutePosition(40f, 722f);
            document.add(image);
            ColumnText.showTextAligned(cb,
                    Element.ALIGN_RIGHT,new Phrase("PETROLEOS Y SERVICIOS",header),
                    (float)(document.right()-20),
                    (float) (document.top()+85 ),
                    (float) 0);
            ColumnText.showTextAligned(cb,
                    Element.ALIGN_RIGHT,new Phrase("Ruc: 1791282299001 ", contenido),
                    (float)(document.right()-20),
                    (float) (document.top() +70),
                    (float) 0);
            ColumnText.showTextAligned(cb,
                    Element.ALIGN_RIGHT,new Phrase(" Dirección: Av. 6 de Diciembre \n" +
                    "    N30-182 y Alpallana, Quito" , contenido),
                    (float)(document.right()-20),
                    (float) (document.top() +55),
                    (float) 0);
            ColumnText.showTextAligned(cb,
                    Element.ALIGN_RIGHT,new Phrase("Telefono: (593) (2) 381-9680" , contenido),
                    (float)(document.right()-20),
                    (float) (document.top() +40),
                    (float) 0);
        }
        footer.writeSelectedRows(0, -1,
                (float)((document.right() - document.left() - 300) /2
                        + document.leftMargin()),
                (float) (document.bottom() - 10), cb);
        document.setMargins(25,25,140,40)

    }
    public void onOpenDocument(PdfWriter writer, Document document) {
        total = writer.getDirectContent().createTemplate(100, 100);
        total.setBoundingBox(new Rectangle(-20, -20, 100, 100));
        try {
            helv = BaseFont.createFont(BaseFont.HELVETICA,
                    BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        } catch (Exception e) {
            throw new ExceptionConverter(e);
        }
    }

    @Override
    void onStartPage(PdfWriter pdfWriter, Document document) {
        PdfContentByte cb = pdfWriter.getDirectContent();
        if (document.getPageNumber() > 1) {
            Image image = Image.getInstance(this.img);
            image.setAbsolutePosition(40f, 722f);
            document.add(image);
//            Paragraph p = new Paragraph("PETROLEOS Y SERVICIOS", header);
//            p.setAlignment(Element.ALIGN_RIGHT);
//            document.add(p);
//            p = new Paragraph("Ruc: 1791282299001 ", contenido);
//            p.setAlignment(Element.ALIGN_RIGHT);
//            document.add(p);
//            p = new Paragraph(" Dirección: Av. 6 de Diciembre \n" +
//                    "    N30-182 y Alpallana, Quito" , contenido);
//            p.setAlignment(Element.ALIGN_RIGHT);
//            document.add(p);
//            p = new Paragraph("Telefono: (593) (2) 381-9680", contenido);
//            p.setAlignment(Element.ALIGN_RIGHT);
//            document.add(p);
//            document.add(new Paragraph("\n"));
//            document.add(new Paragraph("\n"));
        }
    }

    public void onCloseDocument(PdfWriter writer, Document document) {
        total.beginText();
        total.setFontAndSize(helv, 12);
        total.setTextMatrix(0, 0);
        total.showText(String.valueOf(writer.getPageNumber() - 1));
        total.endText();
    }

    @Override
    void onParagraph(PdfWriter pdfWriter, Document document, float v) {

    }

    @Override
    void onParagraphEnd(PdfWriter pdfWriter, Document document, float v) {

    }

    @Override
    void onChapter(PdfWriter pdfWriter, Document document, float v, Paragraph elements) {

    }

    @Override
    void onChapterEnd(PdfWriter pdfWriter, Document document, float v) {

    }

    @Override
    void onSection(PdfWriter pdfWriter, Document document, float v, int i, Paragraph elements) {

    }

    @Override
    void onSectionEnd(PdfWriter pdfWriter, Document document, float v) {

    }

    @Override
    void onGenericTag(PdfWriter pdfWriter, Document document, com.itextpdf.text.Rectangle rectangle, String s) {

    }



}
