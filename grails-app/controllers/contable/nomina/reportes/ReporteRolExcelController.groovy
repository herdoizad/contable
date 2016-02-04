package contable.nomina.reportes

import contable.core.Mes
import contable.nomina.DetalleRol
import contable.nomina.Empleado
import contable.nomina.MesNomina
import contable.nomina.Rol
import contable.nomina.Rubro
import contable.nomina.Sueldo
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

class ReporteRolExcelController {

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
        XSSFSheet sheet = wb.createSheet("Reporte Rol Empleados")
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
        cellTitulo.setCellValue("Petróleo y servicios" )
        cellTitulo.setCellStyle(styleTitulo)
        XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
        cellSubtitulo.setCellValue("Rol de Pagos del mes de "+mes.descripcion.toUpperCase());
        println meses
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
        sheet.setColumnWidth(3,3000)
        sheet.setColumnWidth(4,3000)
        sheet.setColumnWidth(5,3000)
        sheet.setColumnWidth(6,3000)
        sheet.setColumnWidth(7,3000)
        sheet.setColumnWidth(8,3000)
        sheet.setColumnWidth(9,3000)
        sheet.setColumnWidth(10,3000)
        sheet.setColumnWidth(11,3000)
        sheet.setColumnWidth(12,3000)
        sheet.setColumnWidth(13,3000)
        sheet.setColumnWidth(14,3000)
        sheet.setColumnWidth(15,3000)
        sheet.setColumnWidth(16,3000)
        sheet.setColumnWidth(17,3000)
        sheet.setColumnWidth(18,3000)
        sheet.setColumnWidth(19,3000)
        sheet.setColumnWidth(20,3000)
        sheet.setColumnWidth(21,3000)
        sheet.setColumnWidth(22,3000)
        sheet.setColumnWidth(23,3000)
        sheet.setColumnWidth(24,3000)
        sheet.setColumnWidth(25,3000)
        sheet.setColumnWidth(26,3000)
        sheet.setColumnWidth(27,3000)
        sheet.setColumnWidth(28,3000)
        sheet.setColumnWidth(29,3000)
        sheet.setColumnWidth(30,3000)
        sheet.setColumnWidth(31,3000)
        curRow++

        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("Apellido")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 2)
        celda.setCellValue("Nombre")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 3)
        celda.setCellValue("RBU")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 4)
        celda.setCellValue("Bono Alimentacion")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 5)
        celda.setCellValue("Decimo Tercero")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 6)
        celda.setCellValue("Decimo Cuarto")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 7)
        celda.setCellValue("Horas Extras")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 8)
        celda.setCellValue("Fondos de Reserva")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 9)
        celda.setCellValue("Bono Antiguedad")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 10)
        celda.setCellValue("Bono Sistema Facturacion")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 11)
        celda.setCellValue("Bonificacion")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 12)
        celda.setCellValue("Devolucion Descuentos")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 13)
        celda.setCellValue("Horas Extras Sistema Facturacion")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 14)
        celda.setCellValue("Reemplazo")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 15)
        celda.setCellValue("Total Ingresos")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 16)
        celda.setCellValue("IESS")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 17)
        celda.setCellValue("Anticipo")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 18)
        celda.setCellValue("Impuesto Renta")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 19)
        celda.setCellValue("Primera Quincena")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 20)
        celda.setCellValue("Otros Descuentos")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 21)
        celda.setCellValue("Total Egresos")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 22)
        celda.setCellValue("A Recibir")
        celda.setCellStyle(styleHeader)

        curRow++
        //def em =  Empleado.list([sort: "Apellido",order: "desc"])
        //Empleado.listOrderByApellido().eac
        def emp =Empleado.findAllByEstado("A",[sort: "apellido"])
        def rubros = Rubro.findAllBySigno(-1)
        def rubro = Rubro.findAllBySigno(1)
        emp.each {em ->
            def totalEmpleadou = 0
            def totalEmpleadod = 0
            def totalEmpleadot = 0
            def totalEmpleadoc = 0
            def totalEmpleadoci = 0
            def totalEmpleadose = 0
            def totalEmpleadosi = 0
            def totalEmpleadooch = 0
            def totalEmpleadonu = 0
            def totalEmpleadofac = 0

            row = sheet.createRow((short) curRow)
            celda = row.createCell((short) 1)
            celda.setCellValue(em.apellido)
            celda = row.createCell((short) 2)
            celda.setCellValue(em.nombre)
            //curRow++
            def rol = Rol.findByEmpleadoAndMes(em, mes)
            def pq = DetalleRol.findByRolAndCodigo(rol,'Q1')

            def iees = DetalleRol.findByRolAndCodigo(rol,'IESS')
            def  iessr = 0
            if(iees){
                iessr  = iees?.valor
            }

            def reem= DetalleRol.findByRolAndCodigo(rol,'REEMP')
            def  ree = 0
            if(reem){
                ree = reem?.valor
            }

            def devo= DetalleRol.findByRolAndCodigo(rol,'DVLDC')
            def  dev = 0
            if(devo){
                dev = devo?.valor
            }

            def boni = DetalleRol.findByRolAndCodigo(rol,'BNFC')
            def  bon = 0
            if(boni){
                bon = boni?.valor
            }

            def ba = DetalleRol.findByRolAndCodigo(rol,'BANT')
            def  ban = 0
            if(ba){
                ban = ba?.valor
            }

            def fr = DetalleRol.findByRolAndCodigo(rol,'FDRE')
            def  fre = 0
            if(fr){
                fre = fr?.valor
            }

            def rubro1 = Rubro.findAllByCodigo('H200')
            def h1 = DetalleRol.findAllByRubroAndRol(rubro1,rol)
            h1.each {huno ->
                totalEmpleadou += huno.valor
            }
            def rubro2 = Rubro.findAllByCodigo('H150')
            def h2 = DetalleRol.findAllByRubroAndRol(rubro2,rol)
            h2.each {hdos ->
                totalEmpleadod += hdos.valor
            }
            def rubro3 = Rubro.findAllByCodigo('H100')
            def h3 = DetalleRol.findAllByRubroAndRol(rubro3,rol)
            h3.each {htres ->
                totalEmpleadot += htres.valor
            }
            def tt1 = totalEmpleadou + totalEmpleadod + totalEmpleadot

            def rubro4 = Rubro.findAllByCodigo('BSF7')
            def h4 = DetalleRol.findAllByRubroAndRol(rubro4,rol)
            h4.each {hcuatro ->
               totalEmpleadoc += hcuatro.valor
            }
            def rubro5 = Rubro.findAllByCodigo('BSF1')
            def h5 = DetalleRol.findAllByRubroAndRol(rubro5,rol)
            h5.each {hcinco ->
                totalEmpleadoci += hcinco.valor
            }
            def rubro6 = Rubro.findAllByCodigo('BSF3')
            def h6 = DetalleRol.findAllByRubroAndRol(rubro6,rol)
            h6.each {hseis ->
                totalEmpleadose += hseis.valor
            }
            def rubrofac = Rubro.findAllByCodigo('BSF')
            def rfac = DetalleRol.findAllByRubroAndRol(rubrofac,rol)
            rfac.each {fac ->
                totalEmpleadofac += fac.valor
            }
            def tt2 = totalEmpleadoc + totalEmpleadoci + totalEmpleadose + totalEmpleadofac

            def fdu = 0
            def dtd = 0
            def dct =0
            def detalled = DetalleRol.findAllByRolAndSigno(rol, 1)
            detalled.each {deta ->

                if (deta.descripcion == 'Horas extra SF 25' ){
                    fdu =  deta.valor
                }
                if (deta.descripcion == 'Horas extra SF 50' ){
                    dtd= deta.valor
                }
                if (deta.descripcion == 'Horas extra SF 100'  ){
                    dct =   deta.valor
                }

            }
            totalEmpleadosi += fdu
            totalEmpleadooch += dtd
            totalEmpleadonu += dct
            def tt3 = totalEmpleadosi + totalEmpleadooch + totalEmpleadonu

            def al = DetalleRol.findByRolAndCodigo(rol,'ALMT')
            def  alim
            if(al){
                alim = al?.valor
            }
            else{
               alim = 0
            }

            def dc = DetalleRol.findByRolAndCodigo(rol,'S14')
            def  decimoc = 0
            if(dc){
                decimoc = dc?.valor
            }

            def dt = DetalleRol.findByRolAndCodigo(rol,'S13')
            def  decimot
            if(dt){
                decimot = dt?.valor
            }else{
                decimot = 0
            }

            //def sc = DetalleRol.findByRolAndCodigo(rol,'SLDO')
            def sc = Sueldo.findAllByEmpleado(em)
            def  sueldo
            sc.each{ s ->
            if(s){
                sueldo = s?.sueldo
                 // println  "sueldo " + s.sueldo

            }else{
                sueldo = 0
            }

            }

            def anticipo= DetalleRol.findByRolAndCodigo(rol,'ANTSU')
            def  a
            if(anticipo){
                a = anticipo?.valor
            }else{
                a = 0
            }

            def impr= DetalleRol.findByRolAndCodigo(rol,'IRNTA')
            def  i
            if(impr){
                i = impr?.valor
            }else{
                i = 0
            }
            celda = row.createCell((short) 3)
            celda.setCellValue(sueldo)
            celda = row.createCell((short) 4)
            celda.setCellValue(alim)
            celda = row.createCell((short) 5)
            celda.setCellValue(decimot)
            celda = row.createCell((short) 6)
            celda.setCellValue(decimoc)
            celda = row.createCell((short) 7)
            celda.setCellValue(tt1)
            celda = row.createCell((short) 8)
            celda.setCellValue(fre)
            celda = row.createCell((short) 9)
            celda.setCellValue(ban)
            celda = row.createCell((short) 10)
            celda.setCellValue(tt2)
            celda = row.createCell((short) 11)
            celda.setCellValue(bon)
            celda = row.createCell((short) 12)
            celda.setCellValue(dev)
            celda = row.createCell((short) 13)
            celda.setCellValue(tt3)
            celda = row.createCell((short) 14)
            celda.setCellValue(ree)
            celda = row.createCell((short) 16)
            celda.setCellValue(iessr)
            celda = row.createCell((short) 17)
            celda.setCellValue(a)
            celda = row.createCell((short) 18)
            celda.setCellValue(i)
            celda = row.createCell((short) 19)
            celda.setCellValue(pq.valor)
            def datos = 0
             def datoso = 0
            // def valoreo = 0
            rubros.each {r ->
                def detalle = DetalleRol.findByRolAndRubro(rol,r)
                def valore

                if(detalle) {
                    valore = detalle.valor
                  datos +=valore
                }
                datoso = datos - iees.valor - a - i
                celda = row.createCell((short) 20)
                celda.setCellValue(datoso)
                celda = row.createCell((short) 21)
                celda.setCellValue(datos + pq.valor)
            }

            def datosi = 0
            rubro.each {ri ->
                def detalle = DetalleRol.findByRolAndRubro(rol,ri)
                def valorei

                if(detalle) {
                    valorei = detalle.valor
                    datosi +=valorei
                }
                celda = row.createCell((short) 15)
                celda.setCellValue(datosi)
            }

            def rec = 0
            rec = datosi - datos - pq.valor
            celda = row.createCell((short) 22)
            celda.setCellValue(rec)

            curRow++


            //println " * " + impr.valor

          }




def output = response.getOutputStream()
        def header = "attachment; filename=" + "reporteRolEmpleados.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()


    }
}
