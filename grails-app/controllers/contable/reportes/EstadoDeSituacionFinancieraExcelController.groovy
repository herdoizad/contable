package contable.reportes
import contable.seguridad.Shield
import groovy.sql.Sql
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.ClientAnchor
import org.apache.poi.ss.usermodel.CreationHelper
import org.apache.poi.ss.usermodel.DataFormat
import org.apache.poi.ss.usermodel.Drawing
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.util.CellRangeAddress
import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFColor
import org.apache.poi.xssf.usermodel.XSSFRow
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook

class EstadoDeSituacionFinancieraExcelController extends Shield {
    def dataSource
    def index() {

        println "el coyote"

        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cierre = "01/01/2015"
        def nivel = params.nivel.toInteger()
        def fecha = new Date()
        //def banco = Banco.findByCodigo(params.banco)
        def cn = new Sql(dataSource)
        def sql = "CONTABLE..up_saldos_contables 'PS' ,'${cierre}' , '${fin.format('MM/dd/yyyy')}', '${inicio.format('MM/dd/yyyy')}'"
        cn.call(sql.toString())
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL<=${nivel} order by CTA_CUENTA "
        def result = [:]
        cn.eachRow(sql.toString()){r->
            result.put(r["CTA_CUENTA"].trim(),["saldo":r["CTA_SALDO"] , "nivel":r["CTA_NIVEL"],"desc":r["CTA_DESCRIPCION"].trim(),"debe":r["CTA_DEBE"],"haber":r["CTA_HABER"],"inicial":r["CTA_SALDO_INI"]])
        }
        def iniRow = 0
        def iniCol = 0
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def curRow = iniRow
        //def curCol = iniCol
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Estado Situación Financiera")
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
        XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
        cellSubtitulo.setCellValue("Estado Situación Financiera desde "+inicio.format("dd-MM-yyyy")+" hasta "+fin.format("dd-MM-yyyy"))
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

        def total1=0
        def total2=0
        def total3=0
        def total4=0
        def total5=0
        def total6=0
        def band = 1
        def show = true

        def celda
        def td = 0,th=0
        def last = null
        def table = null
        def cell
        curRow++
        result.each {r->
//            println "r "+r
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
                //  println "4 "+r
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
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 6)
                    celda.setCellValue("TOTAL ACTIVOS")
                    celda.setCellStyle(styleNegrilla)

                    celda =  row.createCell((short) 7)
                    celda.setCellValue(total1)
                    celda.setCellStyle(styleNegrilla)
                    curRow++
                    band=0
                    break;


                case 3:

                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 6)
                    celda.setCellValue("TOTAL PASIVOS")
                    celda.setCellStyle(styleNegrilla)

                    celda =  row.createCell((short) 7)
                    celda.setCellValue(total2)
                    celda.setCellStyle(styleNegrilla)
                    curRow++
                    band=0
                    break;

            }
            if(show){
                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 1)
                celda.setCellValue(r.key)
                //celda.setCellStyle(styleNegrilla)

                celda =  row.createCell((short) 2)
                celda.setCellValue(r.value["desc"])
                //celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short)(3+5-r.value["nivel"]))
                celda.setCellValue(r.value["debe"]-r.value["haber"]+r.value["inicial"])
                //celda.setCellStyle(styleNegrilla)
                curRow++

            }

        }

        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 6)
        celda.setCellValue("TOTAL CAPITAL")
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 7)
        celda.setCellValue(total3)
        celda.setCellStyle(styleNegrilla)

        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 6)
        celda.setCellValue("UTILIDAD EJERCICIO")
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 7)
        celda.setCellValue(total4)
        celda.setCellStyle(styleNegrilla)

        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 6)
        celda.setCellValue("TOTAL PATRIMONIO")
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 7)
        celda.setCellValue(total4+total3)
        celda.setCellStyle(styleNegrilla)

        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 6)
        celda.setCellValue("TOTAL PASIVO + PATRIMONIO")
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 7)
        celda.setCellValue(total4+total3+total2-total6)
        celda.setCellStyle(styleNegrilla)






        def output = response.getOutputStream()
        def header = "attachment; filename=" + "EstadoSituacionFinanciera.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }
}
