package contable.reportes

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
import org.apache.poi.util.IOUtils
import org.apache.poi.xssf.usermodel.XSSFCell as Cell
import org.apache.poi.xssf.usermodel.XSSFColor
import org.apache.poi.xssf.usermodel.XSSFRow as Row
import org.apache.poi.xssf.usermodel.XSSFSheet as Sheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook as Workbook
class BalanceExcelController extends Shield  {
    def dataSource
    def qrCodeService
    def reportesService
    def reporte() {
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def nivel = params.nivel.toInteger()
        def cierre = "01/01/2015"
        def cn = new Sql(dataSource)
        def fecha = new Date()
        def nombre ="BalanceDeComprobacion-${fecha.format('ddMMyyyy')}.pdf"
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def sql = "CONTABLE..up_arbol_inverso 'PS' ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}', '${cierre}'"
        cn.call(sql)
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL<=${nivel} order by CTA_CUENTA "
        def last ="1"
        def totalds=0,totalhs=0,totaldm=0,totalhm=0,totaldb=0,totalhb=0,totaldsg=0,totalhsg=0,totaldmg=0,totalhmg=0,totaldbg=0,totalhbg=0

        def iniRow = 0
        def iniCol = 0
        def curRow = iniRow
        def curCol = iniCol
        Workbook wb = new Workbook()
        Sheet sheet = wb.createSheet("Balance de comprobación")
        int pictureIdx = wb.addPicture(img.readBytes(), Workbook.PICTURE_TYPE_PNG);
        //Returns an object that handles instantiating concrete classes
        CreationHelper helper = wb.getCreationHelper();
        //Creates the top-level drawing patriarch.
        Drawing drawing = sheet.createDrawingPatriarch();
        //Create an anchor that is attached to the worksheet
        ClientAnchor anchor = helper.createClientAnchor();
        //set top-left corner for the image
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
        Row row = sheet.createRow((short) curRow)
        curRow++
        row.setHeightInPoints(30)
        Row row2 = sheet.createRow((short) curRow)
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

        Cell cellTitulo = row.createCell((short) iniCol)
        cellTitulo.setCellValue("Petróleos y servicios" )
        cellTitulo.setCellStyle(styleTitulo)
        Cell cellSubtitulo = row2.createCell((short) iniCol)
        cellSubtitulo.setCellValue("Balance de comprobación del "+inicio.format("dd-MM-yyyy")+" hasta "+fin.format("dd-MM-yyyy"))
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
        row = sheet.createRow((short) curRow)
        Cell celda =  row.createCell((short) 3)
        celda.setCellValue("Saldo inicial")
        celda.setCellStyle(styleHeader)

        celda =  row.createCell((short) 5)
        celda.setCellValue("Movimientos")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 7)
        celda.setCellValue("Balance de comprobación")
        celda.setCellStyle(styleHeader)
        sheet.addMergedRegion(new CellRangeAddress(
                curRow, //first row (0-based)
                curRow, //last row  (0-based)
                3, //first column (0-based)
                4  //last column  (0-based)
        ))
        sheet.addMergedRegion(new CellRangeAddress(
                curRow, //first row (0-based)
                curRow, //last row  (0-based)
                5, //first column (0-based)
                6  //last column  (0-based)
        ))
        sheet.addMergedRegion(new CellRangeAddress(
                curRow, //first row (0-based)
                curRow, //last row  (0-based)
                7, //first column (0-based)
                8  //last column  (0-based)
        ))
        sheet.setColumnWidth(1,4000)
        sheet.setColumnWidth(2,9000)
        sheet.setColumnWidth(3,5000)
        sheet.setColumnWidth(4,5000)
        sheet.setColumnWidth(5,5000)
        sheet.setColumnWidth(6,5000)
        sheet.setColumnWidth(7,5000)
        sheet.setColumnWidth(8,5000)
        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("Código")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 2)
        celda.setCellValue("Descripción")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 3)
        celda.setCellValue("Debe")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 4)
        celda.setCellValue("Haber")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 5)
        celda.setCellValue("Debe")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 6)
        celda.setCellValue("Haber")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 7)
        celda.setCellValue("Debe")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 8)
        celda.setCellValue("Haber")
        celda.setCellStyle(styleHeader)
        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 2)
        celda.setCellValue("ACTIVO")
        celda.setCellStyle(styleHeader)
        6.times {
            celda =  row.createCell((short) it+3)
            celda.setCellValue("")
            celda.setCellStyle(styleHeader)
        }
        curRow++
        cn.eachRow(sql.toString()){r->
            if(r["CTA_NIVEL"]==nivel){
                if(r["CTA_CUENTA"].startsWith("2.") && last=="1"){
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 3)
                    celda.setCellValue(totalds)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 4)
                    celda.setCellValue(totalhs)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 5)
                    celda.setCellValue(totaldm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 6)
                    celda.setCellValue(totalhm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 7)
                    celda.setCellValue(totaldb)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 8)
                    celda.setCellValue(totalhb)
                    celda.setCellStyle(styleFooter)
                    curRow++
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 1)
                    celda.setCellValue("")
                    celda.setCellStyle(styleHeader)
                    celda =  row.createCell((short) 2)
                    celda.setCellValue("PASIVO")
                    celda.setCellStyle(styleHeader)
                    6.times {
                        celda =  row.createCell((short) it+3)
                        celda.setCellValue("")
                        celda.setCellStyle(styleHeader)
                    }
                    curRow++
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb
                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    last="2"
                }
                if(r["CTA_CUENTA"].startsWith("3.")  && last=="2"){
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 3)
                    celda.setCellValue(totalds)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 4)
                    celda.setCellValue(totalhs)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 5)
                    celda.setCellValue(totaldm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 6)
                    celda.setCellValue(totalhm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 7)
                    celda.setCellValue(totaldb)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 8)
                    celda.setCellValue(totalhb)
                    celda.setCellStyle(styleFooter)
                    curRow++
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 1)
                    celda.setCellValue("")
                    celda.setCellStyle(styleHeader)
                    celda =  row.createCell((short) 2)
                    celda.setCellValue("CAPITAL LIQUIDO CONTABLE")
                    celda.setCellStyle(styleHeader)
                    6.times {
                        celda =  row.createCell((short) it+3)
                        celda.setCellValue("")
                        celda.setCellStyle(styleHeader)
                    }
                    curRow++
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb
                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    last="3"
                }
                if(r["CTA_CUENTA"].startsWith("4.")  && last=="3"){
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 3)
                    celda.setCellValue(totalds)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 4)
                    celda.setCellValue(totalhs)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 5)
                    celda.setCellValue(totaldm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 6)
                    celda.setCellValue(totalhm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 7)
                    celda.setCellValue(totaldb)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 8)
                    celda.setCellValue(totalhb)
                    celda.setCellStyle(styleFooter)
                    curRow++
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 1)
                    celda.setCellValue("")
                    celda.setCellStyle(styleHeader)
                    celda =  row.createCell((short) 2)
                    celda.setCellValue("INGRESOS")
                    celda.setCellStyle(styleHeader)
                    6.times {
                        celda =  row.createCell((short) it+3)
                        celda.setCellValue("")
                        celda.setCellStyle(styleHeader)
                    }
                    curRow++
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb
                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    last="4"
                }
                if(r["CTA_CUENTA"].startsWith("5.")  && last=="4"){
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 3)
                    celda.setCellValue(totalds)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 4)
                    celda.setCellValue(totalhs)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 5)
                    celda.setCellValue(totaldm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 6)
                    celda.setCellValue(totalhm)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 7)
                    celda.setCellValue(totaldb)
                    celda.setCellStyle(styleFooter)
                    celda =  row.createCell((short) 8)
                    celda.setCellValue(totalhb)
                    celda.setCellStyle(styleFooter)
                    curRow++
                    row = sheet.createRow((short) curRow)
                    celda =  row.createCell((short) 1)
                    celda.setCellValue("")
                    celda.setCellStyle(styleHeader)
                    celda =  row.createCell((short) 2)
                    celda.setCellValue("COSTOS Y GASTOS DE OPERACION")
                    celda.setCellStyle(styleHeader)
                    6.times {
                        celda =  row.createCell((short) it+3)
                        celda.setCellValue("")
                        celda.setCellStyle(styleHeader)
                    }
                    curRow++
                    totaldsg+=totalds
                    totalhsg+=totalhs
                    totaldmg+=totaldm
                    totalhmg+=totalhm
                    totaldbg+=totaldb
                    totalhbg+=totalhb
                    totalds=0
                    totalhs=0
                    totaldm=0
                    totalhm=0
                    totaldb=0
                    totalhb=0
                    last="5"
                }

                def ini = r["CTA_SALDO_INI"]
                def sdebe=0
                def shaber = 0
                if(ini>0)
                    sdebe=ini
                else
                    shaber=ini
                totalds+=sdebe
                totalhs+=shaber
                totaldm+=r["CTA_DEBE"]
                totalhm+=r["CTA_HABER"]
                totaldb+=r["CTA_SALDO_DEU"]
                totalhb+=r["CTA_SALDO_ACR"]
                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 1)
                celda.setCellValue(r["CTA_CUENTA"])
                celda =  row.createCell((short) 2)
                celda.setCellValue(r["CTA_DESCRIPCION"])
                celda =  row.createCell((short) 3)
                celda.setCellValue(sdebe)
                celda.setCellStyle(styleTable)
                celda =  row.createCell((short) 4)
                celda.setCellValue(shaber)
                celda.setCellStyle(styleTable)
                celda =  row.createCell((short) 5)
                celda.setCellValue(r["CTA_DEBE"])
                celda.setCellStyle(styleTable)
                celda =  row.createCell((short) 6)
                celda.setCellValue(r["CTA_HABER"])
                celda.setCellStyle(styleTable)
                celda =  row.createCell((short) 7)
                celda.setCellValue(r["CTA_SALDO_DEU"])
                celda.setCellStyle(styleTable)
                celda =  row.createCell((short) 8)
                celda.setCellValue( r["CTA_SALDO_ACR"])
                celda.setCellStyle(styleTable)
                curRow++

            }




        }
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 3)
        celda.setCellValue(totalds)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 4)
        celda.setCellValue(totalhs)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 5)
        celda.setCellValue(totaldm)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 6)
        celda.setCellValue(totalhm)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 7)
        celda.setCellValue(totaldb)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 8)
        celda.setCellValue(totalhb)
        celda.setCellStyle(styleFooter)
        curRow++
        totaldsg+=totalds
        totalhsg+=totalhs
        totaldmg+=totaldm
        totalhmg+=totalhm
        totaldbg+=totaldb
        totalhbg+=totalhb
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 2)
        celda.setCellValue("TOTAL GENERAL")
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 3)
        celda.setCellValue(totaldsg)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 4)
        celda.setCellValue(totalhsg)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 5)
        celda.setCellValue(totaldmg)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 6)
        celda.setCellValue(totalhmg)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 7)
        celda.setCellValue(totaldbg)
        celda.setCellStyle(styleFooter)
        celda =  row.createCell((short) 8)
        celda.setCellValue(totalhbg)
        celda.setCellStyle(styleFooter)
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "balanceComprobacion.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }
}
