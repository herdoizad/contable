package contable.reportes

import contable.seguridad.Shield
import groovy.sql.Sql
import groovy.time.TimeCategory
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

class EstadoIntegralExcelController extends Shield {
    def dataSource
    def index() {
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin
        def nivel = params.nivel.toInteger()
        def cierre = "01/01/${inicio.format('yyyy')}"
        def cn = new Sql(dataSource)
        def fecha = new Date()

        use ( TimeCategory ) {
            fin = new Date().parse("dd-MM-yyyy",params.fin) + 23.hours + 59.minutes + 59.seconds
        }

        def sql = "CONTABLE..up_bce_resultados_mes 'PS' ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy HH:mm:ss')}', '${cierre}'"
        cn.call(sql.toString())
        sql = "select * from CONTABLE..PLAN_CUENTA_TMP where CTA_NIVEL<=${nivel} order by CTA_CUENTA "
        def result = [:]
        result.put("INGRESOS",[])
        result.put("COSTO DE VENTAS",[])
        result.put("GASTOS DE OPERACION",[])
        result.put("INGRESOS NO OPERATIVOS",[])
        result.put("GASTOS NO OPERATIVOS",[])
        result.put("COSTOS Y GASTOS",[])

        def iniRow = 0
        def iniCol = 0
        def curRow = iniRow
        def curCol = iniCol
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
        cellSubtitulo.setCellValue("Estado de resultado integral, desde "+inicio.format("dd-MM-yyyy")+" hasta "+fin.format("dd-MM-yyyy"))
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
        sheet.setColumnWidth(2,14000)
        sheet.setColumnWidth(3,5000)
        sheet.setColumnWidth(4,5000)
        sheet.setColumnWidth(5,5000)
        sheet.setColumnWidth(6,6000)
        sheet.setColumnWidth(7,5000)
        sheet.setColumnWidth(8,5000)
        sheet.setColumnWidth(9,5000)


        cn.eachRow(sql.toString()){r->
            if(r["CTA_TITULO"].trim()!="") {
                result[r["CTA_TITULO"].trim()].add(["cuenta"     : r["CTA_CUENTA"].trim(), "saldo": r["CTA_SALDO"]
                                                    , "desc2"    : r["CTA_DESCRIPCION_MAYOR"], "nivel": r["CTA_NIVEL"]
                                                    , "desc"     : r["CTA_DESCRIPCION"].trim(), "debe": r["CTA_DEBE"]
                                                    , "haber"    : r["CTA_HABER"], "inicial": r["CTA_SALDO_INI"]
                                                    , "utilidadb": r["UTILIDAD_BRUTA"], "utilidado": r["UTILIDAD_OPERATIVA"]])
            }

        }

        def ub=0
        def uo=0
        def ino = 0
        def gno = 0
        def last = ""
        def detalle = []
        def desc=""
        def total = 0
        def celda
        def celtaT1,celdaT2
        result.eachWithIndex {r,i->
            if(r.key!="COSTOS Y GASTOS"){
                if(last!=""){
                    row = sheet.createRow((short) celtaT1)
                    celda =  row.createCell((short) 1)
                    celda.setCellValue(last)
                    celda.setCellStyle(styleNegrilla)
                    celda =  row.createCell((short) 7)
                    celda.setCellValue(total)
                    celda.setCellStyle(styleFooter)
//                    curRow++
                    if(desc=="INGRESOS")
                        desc="INGRESOS ORDINARIOS"

                    row = sheet.createRow((short) celdaT2)
                    celda =  row.createCell((short) 1)
                    celda.setCellValue(desc)
                    celda.setCellStyle(styleNegrilla)
                    celda =  row.createCell((short) 6)
                    celda.setCellValue(total)
                    celda.setCellStyle(styleFooter)

                    curRow++
                    if(i==2){
                        row = sheet.createRow((short) curRow)
                        celda =  row.createCell((short) 6)
                        celda.setCellValue("UTILIDAD BRUTA")
                        celda.setCellStyle(styleNegrilla)
                        celda =  row.createCell((short) 7)
                        celda.setCellValue(ub)
                        celda.setCellStyle(styleFooter)
                        curRow++
                    }
                    if(i==3){
                        row = sheet.createRow((short) curRow)
                        celda =  row.createCell((short) 6)
                        celda.setCellValue("UTILIDAD OPERATIVA")
                        celda.setCellStyle(styleNegrilla)
                        celda =  row.createCell((short) 7)
                        celda.setCellValue(uo)
                        celda.setCellStyle(styleFooter)
                        curRow++
                    }
                    curRow++
                }
                celtaT1=curRow+1
                celdaT2=curRow+2
                curRow+=3
                last=r.key
                def cont = 0
                detalle = []
                total = 0
                desc =""
                r.value.each {c->
                    if(cont==0){
                        desc=c["desc2"]
                    }
                    ub=c["utilidadb"]
                    uo=c["utilidado"]
                    def saldo = c["saldo"]
                    def valor = c["debe"]-c["haber"]+c["inicial"]
                    if(saldo<0)
                        saldo=saldo*-1
                    if(valor<0)
                        valor=valor*-1
                    if(c["nivel"]>2){
                        if(c["nivel"]==nivel)
                            total+=valor
                        row = sheet.createRow((short) curRow)
                        celda =  row.createCell((short) 1)
                        celda.setCellValue(c["cuenta"])
                        celda =  row.createCell((short) 2)
                        celda.setCellValue(c["desc"])
                        celda =  row.createCell((short) (3+ 5-c["nivel"]))
                        celda.setCellValue(valor)
                        celda.setCellStyle(styleTable)
                        curRow++
                    }
                    cont++
                }
                if(r.key=="INGRESOS NO OPERATIVOS"){
                    ino=total
                }
                if(r.key=="GASTOS NO OPERATIVOS"){
                    gno=total
                }
            }

        }

        row = sheet.createRow((short) celtaT1)
        celda =  row.createCell((short) 1)
        celda.setCellValue(last)
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 7)
        celda.setCellValue(total)
        celda.setCellStyle(styleFooter)
        row = sheet.createRow((short) celdaT2)
        celda =  row.createCell((short) 1)
        celda.setCellValue(desc)
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 6)
        celda.setCellValue(total)
        celda.setCellStyle(styleFooter)

        curRow++
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 6)
        celda.setCellValue("RESULTADO DEL EJERCICIO")
        celda.setCellStyle(styleNegrilla)
        celda =  row.createCell((short) 7)
        celda.setCellValue(uo+ino-gno)
        celda.setCellStyle(styleFooter)

        def output = response.getOutputStream()
        def header = "attachment; filename=" + "resultadoIntegral.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()


    }
}
