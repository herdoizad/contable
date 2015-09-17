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

class MayorGeneralExcelController extends Shield {
    def dataSource
    def index() {

        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cierre = "01/01/2015"


        def banco = Banco.findByCodigo(params.banco)
        def cn = new Sql(dataSource)
        def sql = "CONTABLE..up_mayor_general 'PS' ,'${params.cuenta}',${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}', '${cierre}'"
        //println "sql "+sql
        cn.call(sql.toString())
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL=4 order by MES_CODIGO,CTA_CUENTA "
        //println "sql "+sql


        def iniRow = 0
        def iniCol = 0
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def curRow = iniRow
        def curCol = iniCol
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Mayor General")
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
        cellSubtitulo.setCellValue("Mayor General del "+inicio.format("dd-MM-yyyy")+" hasta "+fin.format("dd-MM-yyyy"))
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
        sheet.setColumnWidth(2,15000)
        sheet.setColumnWidth(3,5000)
        sheet.setColumnWidth(4,5000)
        sheet.setColumnWidth(5,5000)
        sheet.setColumnWidth(6,5000)
        sheet.setColumnWidth(7,5000)
        sheet.setColumnWidth(8,5000)

        def celda
        def cont = 0
        def last=null
        def debe = 0,haber=0,totald=0,totalh=0



        cn.eachRow(sql.toString()) { r ->
            if(cont==0){
            row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 1)
            celda.setCellValue(r["CTA_MAYOR"])
            celda.setCellStyle(styleNegrilla)
            //row = sheet.createRow((short) curRow)
            curRow++
            celda =  row.createCell((short) 2)
            celda.setCellValue(r["CTA_DESCRIPCION_MAYOR"])
            celda.setCellStyle(styleNegrilla)

                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 1)
                celda.setCellValue("CODIGO CUENTA")
                celda.setCellStyle(styleHeader)
                //row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 2)
                celda.setCellValue("DESCRIPCION")
                celda.setCellStyle(styleHeader)
                //row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 3)
                celda.setCellValue("DEBE")
                celda.setCellStyle(styleHeader)
                //row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 4)
                celda.setCellValue("HABER")
                celda.setCellStyle(styleHeader)
                //row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 5)
                celda.setCellValue("SALDO")
                celda.setCellStyle(styleHeader)
                curRow++


            }




            if(r["MES_CODIGO"]!=last){
                if(last!=null){
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 3)
                    celda.setCellValue(debe)
                    celda.setCellStyle(styleNegrilla)
                    curRow++
                    //row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 4)
                    celda.setCellValue(haber)
                    celda.setCellStyle(styleNegrilla)
                    totald+=debe
                    totalh+=haber
                    debe=0
                    haber=0
                }

                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 1)
                celda.setCellValue(r["CTA_MESPROCESO"])
                celda.setCellStyle(styleNegrilla)
                curRow++
            }
            last=r["MES_CODIGO"]
            debe+= r["CTA_DEBE"]
            haber+= r["CTA_HABER"]
            row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 1)
            celda.setCellValue(r["CTA_CUENTA"])

            celda =  row.createCell((short) 2)
            celda.setCellValue(r["CTA_DESCRIPCION"])


            celda =  row.createCell((short) 3)
            celda.setCellValue(r["CTA_DEBE"])
            celda.setCellStyle(styleTable)

            celda =  row.createCell((short) 4)
            celda.setCellValue(r["CTA_HABER"])
            celda.setCellStyle(styleTable)

            celda =  row.createCell((short) 5)
            celda.setCellValue(r["CTA_SALDO_INI"])
            celda.setCellStyle(styleTable)
            cont++
             //println "¡¡¡¡¡"+ r
            curRow++

        }

        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 3)
        celda.setCellValue(debe)
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 4)
        celda.setCellValue(haber)
        celda.setCellStyle(styleNegrilla)
        totald+=debe
        totalh+=haber

        curRow++
        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 2)
        celda.setCellValue("TOTALES PERIODO")
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 3)
        celda.setCellValue(totald)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 4)
        celda.setCellValue(totalh)
        celda.setCellStyle(styleFooter)

        def output = response.getOutputStream()
        def header = "attachment; filename=" + "mayorGeneral.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }
}
