package contable.reportes

import contable.core.Banco
import contable.core.Cuenta
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

class CarteraVencidaExcelController extends Shield {
    def dataSource

    def index() {
       //println "payaso2"
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        //def cierre = "01/01/2015"
        //def banco = Banco.findByCodigo(params.banco)
        def cuenta = Cuenta.findByNumeroAndEmpresa(params.cuenta,session.empresa)
        def desde =cuenta.numero.trim()+"01001"
        def hasta = cuenta.numero.trim()+"99999"
        //def fecha = new Date()
        def cn = new Sql(dataSource)
        def sql = "CONTABLE..up_rpt_cartera_vencida " +
                " 'PS' , ${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' " +
                ", '${fin.format('MM/dd/yyyy')}'" + ",'${desde}','${hasta}', ${params.dias}"
        cn.call(sql.toString())
        def iniRow = 0
        def iniCol = 0
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def curRow = iniRow
        //def curCol = iniCol
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Diario General")
        int pictureIdx = wb.addPicture(img.readBytes(), XSSFWorkbook.PICTURE_TYPE_PNG);

        CreationHelper helper = wb.getCreationHelper();
        Drawing drawing = sheet.createDrawingPatriarch();
        ClientAnchor anchor = helper.createClientAnchor();
        anchor.setRow1(0);
        anchor.setCol1(0);
        anchor.setRow2(1);
        anchor.setCol2(1);

        //Picture pict = drawing.createPicture(anchor, pictureIdx);

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

        def tit = ""
        switch (params.dias){
            case "0":
                tit="DE 0 a 29"
                break;
            case "30":
                tit="DE 30 a 59"
                break;
            case "60":
                tit="DE 60 a 89"
                break;
            case "90 a 364":
                tit=""
                break;
            case "DE 365 a 1825":
                tit=""
                break;
            case "1826":
                tit="MAS DE 1825"
                break;

        }

        row = sheet.createRow((short) curRow)
        XSSFCell cellSubtitulo = row.createCell((short) 3)
        cellSubtitulo.setCellValue("CARTERA VENCIDA CUENTAS CONTABLES "+tit+" DIAS")
        cellSubtitulo.setCellStyle(styleSubtitulo)
        curRow++
        row = sheet.createRow((short) curRow)
        XSSFCell cellSubtitulo2 = row.createCell((short) 3)
        cellSubtitulo2.setCellValue("Desde "+inicio.format("dd-MM-yyyy")+" hasta "+fin.format("dd-MM-yyyy"))
        cellSubtitulo2.setCellStyle(styleSubtitulo)


        curRow++
        //row = sheet.createRow((short) curRow)


        sheet.addMergedRegion(new CellRangeAddress(
                iniRow, //first row (0-based)
                iniRow, //last row  (0-based)
                iniCol, //first column (0-based)
                6  //last column  (0-based)
        ))
        sheet.addMergedRegion(new CellRangeAddress(
                1, //first row (0-based)
                1, //last row  (0-based)
                0, //first column (0-based)
                6  //last column  (0-based)
        ))
        sheet.setColumnWidth(1,4000)
        sheet.setColumnWidth(2,15000)
        sheet.setColumnWidth(3,5000)
        sheet.setColumnWidth(4,5000)
        sheet.setColumnWidth(5,5000)
        sheet.setColumnWidth(6,5000)
        sheet.setColumnWidth(7,5000)
        sheet.setColumnWidth(8,5000)





        sql = "select * from CONTABLE..COMPROBANTES_TMP "
        def celda
        //def td = 0,th=0
        //def last = null
        //def table = null
        //def cell
        def total = 0
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("CUENTA")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 2)
        celda.setCellValue("DESCRIPCIÓN")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 3)
        celda.setCellValue("DÍAS VENCIDOS")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 4)
        celda.setCellValue("ÚLTIMO MOVIMIENTO")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 5)
        celda.setCellValue("SALDO")
        celda.setCellStyle(styleHeader)
        curRow++

        cn.eachRow(sql.toString()){r->
            total+=r["COM_SALDO"]
            row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 1)
            celda.setCellValue(r["CTA_CUENTA"])
            celda.setCellStyle(styleTable)


            celda =  row.createCell((short) 2)
            celda.setCellValue(r["CTA_DESCRIPCION"])
            //celda.setCellStyle(styleNegrilla)


            celda =  row.createCell((short) 3)
            celda.setCellValue("")
            celda.setCellStyle(styleTable)


            celda =  row.createCell((short) 4)
            celda.setCellValue((r["CON_FECHA"].format("dd-MM-yyyy")))
            celda.setCellStyle(styleTable)



            celda =  row.createCell((short) 5)
            celda.setCellValue(r["COM_SALDO"])
            celda.setCellStyle(styleTable)
            curRow++

            println "------" + r
        }
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 4)
        celda.setCellValue("TOTAL")
        celda.setCellStyle(styleNegrilla)

        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 5)
        celda.setCellValue(total)
        celda.setCellStyle(styleFooter)

        def output = response.getOutputStream()
        def header = "attachment; filename=" + "carteraVencida.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }
}
