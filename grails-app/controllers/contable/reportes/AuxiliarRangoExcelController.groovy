package contable.reportes

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

class AuxiliarRangoExcelController extends Shield  {
    def dataSource
    def index() {
        def inicio = new Date().parse("dd-MM-yyyy",params.inicio)
        def fin = new Date().parse("dd-MM-yyyy",params.fin)
        def cuenta = Cuenta.findByNumeroAndEmpresa(params.cuenta,session.empresa)
        def desde = params.desde.toInteger()
        def hasta = params.hasta.toInteger()
        def fecha = new Date()
        def cn = new Sql(dataSource)
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()

        XSSFWorkbook wb = new XSSFWorkbook()
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


        (desde..hasta).each {
            def num = params.cuenta.trim()
            def n = it.toString()
            (3-n.length()).times {
                num+="0"
            }
            num+=n
//            println "num "+num
            auxiliarCuenta_ajax(cn,wb,inicio,fin,num,styleNegrilla,styleTitulo,styleSubtitulo,styleFooter,styleHeader,styleTable,img)
        }



        def output = response.getOutputStream()
        def header = "attachment; filename=" + "Auxiliar-${fecha.format('ddMMyyyy')}.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }



    def auxiliarCuenta_ajax(cn,wb,inicio,fin,cuenta,styleNegrilla,styleTitulo,styleSubtitulo,styleFooter,styleHeader,styleTable,img){

        def sql = "CONTABLE..up_rpt_auxiliar_por_cta  'PS' , ${inicio.format('yyyy').toInteger()}00 ,'${inicio.format('MM/dd/yyyy')}' , '${fin.format('MM/dd/yyyy')}','${cuenta.trim()}', 'S'"
        cn.call(sql.toString())
        sql = "select * from CONTABLE..COMPROBANTES_TMP   order by CON_FECHA, COM_NUMERO"

        def debe = 0
        def haber = 0
        def cont = 0
        def celda
        def iniRow = 0
        def iniCol = 0
        def curRow = iniRow
        def row
        XSSFSheet sheet
        cn.eachRow(sql.toString()){r->
            if(cont==0){
                sheet = wb.createSheet(cuenta)
                int pictureIdx = wb.addPicture(img.readBytes(), XSSFWorkbook.PICTURE_TYPE_PNG);
                CreationHelper helper = wb.getCreationHelper();
                Drawing drawing = sheet.createDrawingPatriarch();
                ClientAnchor anchor = helper.createClientAnchor();
                anchor.setRow1(0);
                anchor.setCol1(0);
                anchor.setRow2(1);
                anchor.setCol2(1);
                Picture pict = drawing.createPicture(anchor, pictureIdx);

                row = sheet.createRow((short) curRow)
                curRow++
                row.setHeightInPoints(30)
                XSSFRow row2 = sheet.createRow((short) curRow)
                curRow += 2
                row2.setHeightInPoints(24)
                curRow++
                XSSFCell cellTitulo = row.createCell((short) iniCol)
                cellTitulo.setCellValue("Petróleos y servicios" )
                cellTitulo.setCellStyle(styleTitulo)
                XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
                cellSubtitulo.setCellValue("Auxiliar, desde "+inicio.format("dd-MM-yyyy")+" hasta "+fin.format("dd-MM-yyyy"))
                cellSubtitulo.setCellStyle(styleSubtitulo)
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
                sheet.setColumnWidth(2,5000)
                sheet.setColumnWidth(3,14000)
                sheet.setColumnWidth(4,5000)
                sheet.setColumnWidth(5,5000)
                sheet.setColumnWidth(6,5000)
                sheet.setColumnWidth(7,5000)
                sheet.setColumnWidth(8,5000)
                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 1)
                celda.setCellValue(r["CTA_CUENTA"])
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 2)
                celda.setCellValue(r["CTA_DESCRIPCION"])
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 4)
                celda.setCellValue("SALDO ANTERIOR")
                celda.setCellStyle(styleNegrilla)
                celda =  row.createCell((short) 5)
                celda.setCellValue(r["SALDO_INICIAL"])
                celda.setCellStyle(styleFooter)
                curRow++
                row = sheet.createRow((short) curRow)
                celda =  row.createCell((short) 1)
                celda.setCellValue("Fecha")
                celda.setCellStyle(styleHeader)
                celda =  row.createCell((short) 2)
                celda.setCellValue("Código")
                celda.setCellStyle(styleHeader)
                celda =  row.createCell((short) 3)
                celda.setCellValue("Descripción")
                celda.setCellStyle(styleHeader)
                celda =  row.createCell((short) 4)
                celda.setCellValue("Debe")
                celda.setCellStyle(styleHeader)
                celda =  row.createCell((short) 5)
                celda.setCellValue("Haber")
                celda.setCellStyle(styleHeader)
                celda =  row.createCell((short) 6)
                celda.setCellValue("Saldo")
                celda.setCellStyle(styleHeader)
                curRow++
            }
            row = sheet.createRow((short) curRow)
            celda = row.createCell((short) 1)
            celda.setCellValue(r["CON_FECHA"].format("dd-MM-yyyy"))
            celda = row.createCell((short) 2)
            celda.setCellValue("PS-" + r["COM_MES_CODIGO"] + getTipo_ajax(r["COM_TIPO_CODIGO"]) + "-" + r["COM_NUMERO"])
            celda = row.createCell((short) 3)
            celda.setCellValue(r["COM_CONCEPTO"])
            celda = row.createCell((short) 4)
            celda.setCellValue(r["COM_DEBE"])
            celda.setCellStyle(styleTable)
            celda = row.createCell((short) 5)
            celda.setCellValue(r["COM_HABER"])
            celda.setCellStyle(styleTable)
            celda = row.createCell((short) 6)
            celda.setCellValue(r["COM_SALDO"])
            celda.setCellStyle(styleTable)
            curRow++
            debe += r["COM_DEBE"]
            haber += r["COM_HABER"]

            cont++
        }
        if(cont>0){
            row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 3)
            celda.setCellValue("Suman:")
            celda.setCellStyle(styleNegrilla)
            celda =  row.createCell((short) 4)
            celda.setCellValue(debe)
            celda.setCellStyle(styleFooter)
            celda =  row.createCell((short) 5)
            celda.setCellValue(haber)
            celda.setCellStyle(styleFooter)
            curRow++
        }

    }



    def getTipo_ajax(tipo){
        switch (tipo){
            case 1:
                return "I"
                break;
            case 2:
                return "E"
                break;
            case 3:
                return "D"
                break;
            case 4:
                return "A"
                break;
        }
    }

}
