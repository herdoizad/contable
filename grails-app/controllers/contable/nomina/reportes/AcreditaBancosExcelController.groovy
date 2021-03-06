package contable.nomina.reportes

import contable.nomina.DetalleRol
import contable.nomina.MesNomina
import contable.nomina.Rol
import contable.nomina.Rubro
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

class AcreditaBancosExcelController {

    def index() {

            def iniRow = 0
            def iniCol = 0
            def fecha = new Date()
            def mes = MesNomina.get(params.id)

            def meses = ["0":"Todos","1":"Enero","2":"Febero","3":"Marzo","4":"Abril","5":"Mayo","6":"Junio","7":"Juilo","8":"Agosto","9":"Septiembre","10":"Octubre","11":"Noviembre","12":"Diciembre"]

            def celda
            def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
            def curRow = iniRow
            XSSFWorkbook wb = new XSSFWorkbook()
            XSSFSheet sheet = wb.createSheet("Acreditacion Bancos")
            int pictureIdx = wb.addPicture(img.readBytes(), XSSFWorkbook.PICTURE_TYPE_PNG);
            CreationHelper helper = wb.getCreationHelper();
            Drawing drawing = sheet.createDrawingPatriarch();
            ClientAnchor anchor = helper.createClientAnchor();
            anchor.setRow1(0);
            anchor.setCol1(0);
            anchor.setRow2(1);
            anchor.setCol2(1);

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
            //cellSubtitulo.setCellValue("Rol de Pagos del mes de "+mes.descripcion.toUpperCase());
            cellSubtitulo.setCellValue("Listado de Acreditación a Bancos Empleados");
            //println meses
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
            sheet.setColumnWidth(1,8000)
            sheet.setColumnWidth(2,8000)
            sheet.setColumnWidth(3,5000)
            sheet.setColumnWidth(4,5000)
            sheet.setColumnWidth(5,5000)
            sheet.setColumnWidth(6,5000)
            sheet.setColumnWidth(7,5000)
            sheet.setColumnWidth(8,5000)
        curRow++
            row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 1)
            celda.setCellValue("Apellido")
            celda.setCellStyle(styleHeader)
            celda =  row.createCell((short) 2)
            celda.setCellValue("Nombre")
            celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 3)
        celda.setCellValue("Banco")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 4)
        celda.setCellValue("Numero de Cuenta")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 5)
        celda.setCellValue("Liquido a Recibir")
        celda.setCellStyle(styleHeader)
        curRow++
        def rubros =  Rubro.list([sort: "signo",order: "desc"])
        def roles = Rol.findAllByMes(mes)
        def signo = null

        roles.each{r->

            row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 1)
            celda.setCellValue(r.empleado.apellido)
            curRow++
            //row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 2)
            celda.setCellValue(r.empleado.nombre)
            celda =  row.createCell((short) 3)
            celda.setCellValue(r.empleado.banco)
            celda =  row.createCell((short) 4)
            celda.setCellValue(r.empleado.cuenta)

            def suma = 0
            def resta = 0

            rubros.eachWithIndex{ ru, i ->
                def dr = DetalleRol.findByRolAndRubro(r, ru)
                if (dr){
                   if(dr.signo > 0){
                        suma = dr.valor + suma
                    }
                    else {
                        resta = dr.valor + resta
                    }
                }
              }
           def recibir = suma - resta
            //println "+" + suma
            //println "-" + resta
            println "=" + recibir

            celda =  row.createCell((short) 5)
            celda.setCellValue(recibir)
            println "topo100"
        }


            def output = response.getOutputStream()
        def header = "attachment; filename=" + "AcreditacionBancosEmpleados.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()

}
}