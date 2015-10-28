package contable.nomina.reportes

import contable.nomina.Contrato
import contable.nomina.Empleado
import contable.nomina.Sueldo
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

class DatosEmpleadosExcelController extends Shield  {
    //def dataSource
    def index() {
        def iniRow = 0
        def iniCol = 0
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def curRow = iniRow

        //def curCol = iniCol
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Reporte Empleados")
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
        cellSubtitulo.setCellValue("Reporte Empleados")
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
        println "pato5"
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("NUMERO CEDULA")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 2)
        celda.setCellValue("NOMBRE")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 3)
        celda.setCellValue("APELLIDO")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 4)
        celda.setCellValue("DESCRIPCION CONTRATO")
        celda.setCellStyle(styleHeader)
        //row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 5)
        celda.setCellValue("ESTADO CIVIL")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 6)
        celda.setCellValue("DIRECCIÓN")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 7)
        celda.setCellValue("TELEFONO")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 8)
        celda.setCellValue("FECHA DE NACIMIENTO")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 9)
        celda.setCellValue("LUGAR")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 10)
        celda.setCellValue("PAÍS")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 11)
        celda.setCellValue("NACIONALIDAD")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 12)
        celda.setCellValue("CARGO")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 13)
        celda.setCellValue("SEXO")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 14)
        celda.setCellValue("FECHA INGRESO")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 15)
        celda.setCellValue("FECHA ANTIGUEDAD")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 16)
        celda.setCellValue("FECHA SALIDA")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 17)
        celda.setCellValue("TIPO DE SANGRE")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 18)
        celda.setCellValue("CODIGO SECTORIAL")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 19)
        celda.setCellValue("CIUDAD DE TRABAJO")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 20)
        celda.setCellValue("RMU")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 21)
        celda.setCellValue("BONO ANTIGUEDAD")
        celda.setCellStyle(styleHeader)

        curRow++




        //Empleado.findAllByEstado("A").each {emp->
            Empleado.listOrderByApellido().each {emp->
            //println "----" + emp
            def s = Sueldo.findByEmpleadoAndFinIsNull(emp)
            def con = Contrato.findByEmpleadoAndFinIsNull(emp)
            def contratoFinal = Contrato.findAllByEmpleado(emp,[sort:"inicio"])
            if(contratoFinal.size()>0){
                contratoFinal=contratoFinal.pop()
            }else {
                contratoFinal=null
            }
                def date = new Date()
                def calc = date - emp.registro
                def ba
                if(calc > 365){
                    ba = "SI"
                }
                else{
                    ba = "NO"
                }


            row = sheet.createRow((short) curRow)
            celda =  row.createCell((short) 1)
            celda.setCellValue(emp.cedula)
            //celda.setCellStyle(styleNegrilla)
            curRow++
            celda =  row.createCell((short) 2)
            celda.setCellValue(emp.nombre)
            //celda.setCellStyle(styleNegrilla)
            celda =  row.createCell((short) 3)
            celda.setCellValue(emp.apellido)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 4)
            celda.setCellValue((con)?con.tipo?.descripcion:'')
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 5)
            celda.setCellValue(emp.estadoCivil.descripcion)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 6)
            celda.setCellValue(emp.direccion)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 7)
            celda.setCellValue(emp.telefono)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 8)
            celda.setCellValue(emp.fechaNacimiento?.format("dd-MM-yyyy"))
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 9)
            celda.setCellValue("")
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 10)
            celda.setCellValue("")
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 11)
            celda.setCellValue(emp.nacionalidad)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 12)
            celda.setCellValue(emp.cargo)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 13)
            celda.setCellValue(emp.sexo)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 14)
            celda.setCellValue(emp.registro?.format("dd-MM-yyyy"))
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 15)
            celda.setCellValue("")
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 16)
            celda.setCellValue(contratoFinal?.fin?.format("dd-MM-yyyy"))
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 17)
            celda.setCellValue(emp.tipoSangre)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 18)
            celda.setCellValue(emp.codigoSectorial)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 19)
            celda.setCellValue(emp.ciudadTrabajo)
            //celda.setCellStyle(styleNegrilla)

            celda =  row.createCell((short) 20)
            celda.setCellValue(s?.sueldo)
            celda.setCellStyle(styleTable)

            celda =  row.createCell((short) 21)
            celda.setCellValue(ba)
            //celda.setCellStyle(styleNegrilla)



        }
            def output = response.getOutputStream()
        def header = "attachment; filename=" + "reporteEmpleados.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }
}
