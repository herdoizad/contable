package contable.reportes

import contable.core.Banco
import contable.seguridad.Shield
import groovy.sql.Sql
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.ClientAnchor
import org.apache.poi.ss.usermodel.CreationHelper
import org.apache.poi.ss.usermodel.DataFormat
import org.apache.poi.ss.usermodel.Drawing
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.Picture
import org.apache.poi.ss.util.CellRangeAddress
import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFColor
import org.apache.poi.xssf.usermodel.XSSFRow
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook

class ChequesExcelController extends Shield  {
    def dataSource
    def index() {

        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def banco = Banco.findByCodigo(params.banco)
        def cn = new Sql(dataSource)
        def sql = "CONTABLE..up_rpt_cheques_emitidos  '${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}','${params.banco}', 'PS'"

        def iniRow = 0
        def iniCol = 0
        def curRow = iniRow
        def curCol = iniCol
        def celda
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Estado de resultado integral")
        int pictureIdx = wb.addPicture(img.readBytes(), XSSFWorkbook.PICTURE_TYPE_PNG);
        CreationHelper helper = wb.getCreationHelper();
        Drawing drawing = sheet.createDrawingPatriarch();
        ClientAnchor anchor = helper.createClientAnchor();
        anchor.setRow1(0);
        anchor.setCol1(0);
        anchor.setRow2(1);
        anchor.setCol2(1);
        Picture pict = drawing.createPicture(anchor, pictureIdx);

        DataFormat format = wb.createDataFormat();
        Font fontTitulo = wb.createFont()
        fontTitulo.setFontHeightInPoints((short) 24)
        fontTitulo.setColor(new XSSFColor(new java.awt.Color(23, 54, 93)))
        fontTitulo.setBold(true)
        Font fontSubtitulo = wb.createFont()
        fontSubtitulo.setFontHeightInPoints((short) 18)
        fontSubtitulo.setColor(new XSSFColor(new java.awt.Color(23, 54, 93)))
        fontSubtitulo.setBold(true)

        Font fontHeader = wb.createFont()
        fontHeader.setFontHeightInPoints((short) 10)
        fontHeader.setColor(new XSSFColor(new java.awt.Color(255, 255, 255)))
        fontHeader.setBold(true)

        Font fontFooter = wb.createFont()
        fontFooter.setBold(true)

        // Create a row and put some cells in it. Rows are 0 based.
        XSSFRow row = sheet.createRow((short) curRow)
        curRow++
        row.setHeightInPoints(30)
        XSSFRow row2 = sheet.createRow((short) curRow)
        curRow += 2
        row2.setHeightInPoints(24)
        curRow++

        CellStyle styleTitulo = wb.createCellStyle()
        styleTitulo.setFont(fontTitulo)
        styleTitulo.setAlignment(CellStyle.ALIGN_CENTER)
        styleTitulo.setVerticalAlignment(CellStyle.VERTICAL_CENTER)

        CellStyle styleSubtitulo = wb.createCellStyle()
        styleSubtitulo.setFont(fontSubtitulo)
        styleSubtitulo.setAlignment(CellStyle.ALIGN_CENTER)
        styleSubtitulo.setVerticalAlignment(CellStyle.VERTICAL_CENTER)

        CellStyle styleHeader = wb.createCellStyle()
        styleHeader.setFont(fontHeader)
        styleHeader.setAlignment(CellStyle.ALIGN_CENTER)
        styleHeader.setVerticalAlignment(CellStyle.VERTICAL_CENTER)
        styleHeader.setFillForegroundColor(new XSSFColor(new java.awt.Color(0, 110, 183)));
        styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND)
        styleHeader.setBorderRight((short) 1)
        styleHeader.setBorderLeft((short)1)
        styleHeader.setBorderTop((short) 1)
        styleHeader.setBorderBottom((short) 1)
        styleHeader.setWrapText(true);

        CellStyle styleFooter = wb.createCellStyle()
        styleFooter.setFont(fontFooter)
        styleFooter.setDataFormat(format.getFormat("0.00"));

        CellStyle styleNegrilla = wb.createCellStyle()
        styleNegrilla.setFont(fontFooter)

        CellStyle styleTable = wb.createCellStyle()
        styleTable.setDataFormat(format.getFormat("0.00"));

        XSSFCell cellTitulo = row.createCell((short) iniCol)
        cellTitulo.setCellValue("Petróleos y servicios" )
        cellTitulo.setCellStyle(styleTitulo)
        XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
        cellSubtitulo.setCellValue("LISTADO DE CHEQUES EMITIDOS, desde "+inicio.format("dd-MM-yyyy")+" hasta "+fin.format("dd-MM-yyyy"))
        cellSubtitulo.setCellStyle(styleSubtitulo)
        sheet.addMergedRegion(new CellRangeAddress(
                iniRow, //first row (0-based)
                iniRow, //last row  (0-based)
                iniCol, //first column (0-based)
                8  //last column  (0-based)
        ))
        sheet.addMergedRegion(new CellRangeAddress(
                1, //first row (0-based)
                1, //last row  (0-based)
                0, //first column (0-based)
                8  //last column  (0-based)
        ))
        sheet.setColumnWidth(1,4000)
        sheet.setColumnWidth(2,4000)
        sheet.setColumnWidth(3,5000)
        sheet.setColumnWidth(4,9000)
        sheet.setColumnWidth(5,9000)
        sheet.setColumnWidth(6,6000)
        sheet.setColumnWidth(7,5000)
        sheet.setColumnWidth(8,5000)

        def last = null
        def total = 0
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("Banco: ${banco.descripcion}\t\t\t\t\t  Cuenta: ${banco.numero}")
        sheet.addMergedRegion(new CellRangeAddress(
                curRow, //first row (0-based)
                curRow, //last row  (0-based)
                1, //first column (0-based)
                7  //last column  (0-based)
        ))
        celda.setCellStyle(styleHeader)

        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("Mes")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 2)
        celda.setCellValue("Número comp")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 3)
        celda.setCellValue("Fecha emisión")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 4)
        celda.setCellValue("No. Cheque")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 5)
        celda.setCellValue("Beneficiario")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 6)
        celda.setCellValue("Haber")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 7)
        celda.setCellValue("Valor")
        celda.setCellStyle(styleHeader)

        curRow++


        cn.eachRow(sql.toString()) { r ->
            if(last!=r["CHE_NUMERO_CHEQUE"]){
                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 1)
                celda.setCellValue(r["MES_CODIGO"])
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 2)
                celda.setCellValue(r["COM_NUMERO"])
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 3)
                celda.setCellValue(r["CHE_FECHA_EMISION"].format("dd-MM-yyyy"))
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 4)
                celda.setCellValue(r["CHE_NUMERO_CHEQUE"])
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 5)
                celda.setCellValue(r["CHE_BENEFICIARIO"])
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 6)
                celda.setCellValue(r["CHE_VALOR"])
                celda.setCellStyle(styleFooter)

                if( r["CHE_VALOR"]==0){
                    celda =  row.createCell((short) 7)
                    celda.setCellValue("ANULADO")
                    celda.setCellStyle(styleNegrilla)
                }
                curRow++
            }
            last=r["CHE_NUMERO_CHEQUE"]
            if(banco.cuenta.numero!=r["CTA_CUENTA"] && r["COM_SIGNO"]==1){
                total+=r["COM_VALOR"]
                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 3)
                celda.setCellValue(r["CTA_CUENTA"])
                celda =  row.createCell((short) 4)
                celda.setCellValue(r["CTA_DESCRIPCION"])
                celda =  row.createCell((short) 7)
                celda.setCellValue(r["COM_VALOR"])
                celda.setCellStyle(styleTable)
                curRow++
            }


        }


        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 6)
        celda.setCellValue("TOTAL")
        celda.setCellStyle(styleNegrilla)
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 7)
        celda.setCellValue(total)
        celda.setCellStyle(styleFooter)



        def output = response.getOutputStream()
        def header = "attachment; filename=" + "chequesEmitidos.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()

    }
}
