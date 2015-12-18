package contable.nomina.reportes

import contable.core.Banco
import contable.core.Cuenta
import contable.core.Mes
import contable.nomina.DetalleRol
import contable.nomina.Empleado
import contable.nomina.HorasExtra
import contable.nomina.HorasExtraFacturacion
import contable.nomina.MesNomina
import contable.nomina.Rol
import contable.nomina.Rubro
import contable.nomina.RubroEmpleado
import contable.nomina.RubroFijoEmpleado
import contable.nomina.Variable
import contable.seguridad.Shield
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

class ReportesNominaController extends Shield {

    def index() {
        def empleados = Empleado.findAllByEstado("A")
        def meses = MesNomina.findAllByCodigoGreaterThan(new Date().format("yyyy").toInteger(),[sort:"codigo"])
        [empleados:empleados,meses:meses]
    }
    def reportes(){
        switch (params.tipo){
            case "d":
                redirect(action: "descuentos",params: params)
                break;
            case "p":
                redirect(action: "provisiones",params: params)
                break;
            case "h":
                redirect(action: "horasExtra",params: params)
                break;
            case "c":
                redirect(action: "cuadre",params: params)
                break;
        }

    }

    def descuentos(){
        def iniRow = 0
        def iniCol = 0

        println "descuentos "+params
        def mes = MesNomina.get(params.mes)
        def emepleados = []
        if(params.empleado=="-1")
            emepleados=Empleado.findAllByEstado("A",[sort: "apellido"])
        else{
            emepleados.add(Empleado.get(params.empleado))
        }
        //render "aqui hacer reporte"
        def celda
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def curRow = iniRow
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Reporte Descuento Empleado")
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
        cellTitulo.setCellValue("Petróleos y Servicios" )
        cellTitulo.setCellStyle(styleTitulo)
        XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
        cellSubtitulo.setCellValue("Detalle de Descuentos del mes "+mes.descripcion.toUpperCase());
        println mes
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
        sheet.setColumnWidth(9,5000)
        sheet.setColumnWidth(10,5000)
        sheet.setColumnWidth(11,5000)
        sheet.setColumnWidth(12,5000)


        curRow++

        def rubros = Rubro.findAllBySigno(-1)
        row = sheet.createRow((short) curRow)
        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("Apellido")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 2)
        celda.setCellValue("Nombre")
        celda.setCellStyle(styleHeader)
        def datos = [:]
        datos.put("OTROS",0)
        def cont = 3
        rubros.each {r->
            celda =  row.createCell((short) cont)
            celda.setCellValue(r.nombre)
            celda.setCellStyle(styleHeader)
            datos.put(r,0)
            cont++
        }
        celda =  row.createCell((short) cont)
        celda.setCellValue("Otros")
        celda.setCellStyle(styleHeader)
        cont++
        celda =  row.createCell((short) cont)
        celda.setCellValue("Total")
        celda.setCellStyle(styleHeader)
        curRow++
        def totalGeneral = 0

        emepleados.each {em->
            def totalEmpleado = 0
            row = sheet.createRow((short) curRow)
            celda = row.createCell((short) 1)
            celda.setCellValue(em.apellido)
            celda = row.createCell((short) 2)
            celda.setCellValue(em.nombre)
            def rol = Rol.findAllByEmpleadoAndMes(em,mes)
            cont=3
            rubros.each {r->
                def detalle = DetalleRol.findByRolAndRubro(rol,r)
                def valor = 0
                if(detalle) {
                    valor = detalle.valor
                    datos[r]+=valor
                }
                celda = row.createCell((short) cont)
                celda.setCellValue(valor)
                totalEmpleado+=valor
                cont++
            }
            def otros  = 0
            def detalle = DetalleRol.findAllByRolAndCodigo(rol,"OTROS")
            detalle.each {d->
                otros+=d.valor
            }
            datos["OTROS"]+=otros
            celda = row.createCell((short) cont)
            celda.setCellValue(otros)
            cont++
            celda = row.createCell((short) cont)
            celda.setCellValue(totalEmpleado+otros)
            totalGeneral+=totalEmpleado+otros
            curRow++


        }

        row = sheet.createRow((short) curRow)
        cont=3
        rubros.each { r ->
            celda = row.createCell((short) cont)
            celda.setCellValue(datos[r])
            cont++

        }
        celda = row.createCell((short) cont)
        celda.setCellValue(datos["OTROS"])
        cont++
        celda = row.createCell((short) cont)
        celda.setCellValue(totalGeneral)
//        println "datos "+datos
        // le borro render
        //todos los roles por empleado
        //todos los detalles de los roles
        //todos los detalles negativos}

        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reporteDescuentoEmpleados.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()


    }

    def provisiones(){
        println "provis"
        def mes = MesNomina.get(params.mes)
        def emepleados = []
        if(params.empleado=="-1")
            emepleados=Empleado.findAllByEstado("A")
        else{
            emepleados.add(Empleado.get(params.empleado))
        }
        def iniRow = 0
        def iniCol = 0
        //render "aqui hacer reporte"

        def celda
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def curRow = iniRow
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Reporte Descuentos Empleado")
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
        cellTitulo.setCellValue("Petróleos y Servicios" )
        cellTitulo.setCellStyle(styleTitulo)
        XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
        cellSubtitulo.setCellValue("Detalle de Provisiones del mes "+mes.descripcion.toUpperCase());

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


        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("Apellido")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 2)
        celda.setCellValue("Nombre")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 3)
        celda.setCellValue("Fondo reserva")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 4)
        celda.setCellValue("Decimo Tercero")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 5)
        celda.setCellValue("Decimo Cuarto")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 6)
        celda.setCellValue("Total")
        celda.setCellStyle(styleHeader)

        //siempreponercurRow++
        curRow++
        def totalVerticalUno = 0
        def totalVerticalDos = 0
        def totalVerticalTres = 0
        def totalTodo = 0


        //def emp = Empleado.listOrderByApellido()
        emepleados.each {em  ->
            def totalEmpleado = 0
            row = sheet.createRow((short) curRow)
            celda = row.createCell((short) 1)
            celda.setCellValue(em.apellido)
            curRow++
            //row = sheet.createRow((short) curRow)
            celda = row.createCell((short) 2)
            celda.setCellValue(em.nombre)


            // siempre traerpor elque se estaiterando,en este caso em
            def rol = Rol.findByEmpleadoAndMes(em, mes)
            def detalle13 = DetalleRol.findByRolAndCodigo(rol,'S13')
            def detalle14= DetalleRol.findByRolAndCodigo(rol,'S14')
            def detalleFr= DetalleRol.findByRolAndCodigo(rol,'FDRE')

            def fd = 0
            def dt = 0
            def dc =0
            if(!detalle13){
                def detalles = DetalleRol.findAllByRolAndSigno(rol,1)
                def totalIngresos = 0
                detalles.each {d->
                    if(d.codigo!="FDRE" && d.codigo!="S13"  && d.codigo!="S14" && d.codigo!="DVLDC"){
                        totalIngresos+=d.valor
                    }
                }
                dt=totalIngresos/12
                dt=dt.toDouble().round(2)
            }
            if(!detalle14){
                def variable = Variable.findByCodigo("@SBasico")
                dc = (variable.valor/12).toDouble().round(2)
            }
            if(!detalleFr){
                def detalles = DetalleRol.findAllByRolAndSigno(rol,1)
                def totalIngresos = 0
                detalles.each {d->
                    if(d.codigo!="FDRE" && d.codigo!="S13"  && d.codigo!="S14" && d.codigo!="DVLDC"){
                        totalIngresos+=d.valor
                    }
                }
                fd=totalIngresos/12
                fd=dt.toDouble().round(2)
            }

            celda = row.createCell((short) 3)
            celda.setCellValue(fd)
            totalEmpleado+=fd
            totalVerticalUno+=fd
            celda = row.createCell((short) 4)
            celda.setCellValue(dt)
            totalEmpleado+=dt
            totalVerticalDos+=dt
            celda = row.createCell((short) 5)
            celda.setCellValue(dc)
            totalEmpleado+=dc
            totalVerticalTres+=dc
            celda = row.createCell((short) 6)
            celda.setCellValue(totalEmpleado)
        }

        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 2)
        celda.setCellValue("Total")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 3)
        celda.setCellValue(totalVerticalUno)
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 4)
        celda.setCellValue(totalVerticalDos)
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 5)
        celda.setCellValue(totalVerticalTres)
        celda.setCellStyle(styleHeader)
        totalTodo = totalVerticalUno + totalVerticalDos + totalVerticalTres
        celda =  row.createCell((short) 6)
        celda.setCellValue(totalTodo)
        celda.setCellStyle(styleHeader)

        //Décimo cuarto mensual Décimo tercero mensual Fondos de reserva

        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reportedeprovisiones.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }
    /* def cuadre() {
      println "cuadre"
      def mes = MesNomina.get(params.mes)
      def emepleados = []
      if (params.empleado == "-1")
          emepleados = Empleado.findAllByEstado("A")
      else {
          emepleados.add(Empleado.get(params.empleado))
      }

      def iniRow = 0
      def iniCol = 0
      //render "aqui hacer reporte"
      def celda
      def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
      def curRow = iniRow
      XSSFWorkbook wb = new XSSFWorkbook()
      XSSFSheet sheet = wb.createSheet("Reporte Descuento Empleado")
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
      styleHeader.setBorderLeft((short) 1)
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
      cellTitulo.setCellValue("Petróleos y Servicios")
      cellTitulo.setCellStyle(styleTitulo)
      XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
      cellSubtitulo.setCellValue("Reporte especial del mes de" + mes.descripcion.toUpperCase());

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
      sheet.setColumnWidth(1, 8000)
      sheet.setColumnWidth(2, 8000)
      sheet.setColumnWidth(3, 5000)
      sheet.setColumnWidth(4, 5000)
      sheet.setColumnWidth(5, 5000)
      sheet.setColumnWidth(6, 5000)
      sheet.setColumnWidth(7, 5000)
      sheet.setColumnWidth(8, 5000)


      row = sheet.createRow((short) curRow)
      celda = row.createCell((short) 1)
      celda.setCellValue("Apellido")
      celda.setCellStyle(styleHeader)
      celda = row.createCell((short) 2)
      celda.setCellValue("Nombre")
      celda.setCellStyle(styleHeader)
      celda = row.createCell((short) 3)
      celda.setCellValue("RMU")
      celda.setCellStyle(styleHeader)
      celda = row.createCell((short) 4)
      celda.setCellValue("Otros Ingresos")
      celda.setCellStyle(styleHeader)
      celda = row.createCell((short) 5)
      celda.setCellValue("Fondos de Reserva")
      celda.setCellStyle(styleHeader)
      celda = row.createCell((short) 6)
      celda.setCellValue("Aporte IEES")
      celda.setCellStyle(styleHeader)
      celda = row.createCell((short) 7)
      celda.setCellValue("Impuesto Rentas")
      celda.setCellStyle(styleHeader)

      //siempreponercurRow++
      curRow++
      def totalVerticalUno = 0
      def totalVerticalDos = 0
      def totalVerticalTres = 0
      def totalTodo = 0

      //def emp = Empleado.listOrderByApellido()
      emepleados.each { em ->
          def totalEmpleado = 0
          row = sheet.createRow((short) curRow)
          celda = row.createCell((short) 1)
          celda.setCellValue(em.apellido)
          curRow++
          //row = sheet.createRow((short) curRow)
          celda = row.createCell((short) 2)
          celda.setCellValue(em.nombre)
          def rol = Rol.findByEmpleadoAndMes(em, mes)
          def detallermu = DetalleRol.findAllByRol(rol)
          def pq = 0
          def sq = 0
          def rmu = 0
          def fd = 0
          def ai = 0
          def ir = 0
          detallermu.each{d ->
              if (d.descripcion == 'Primera quincena' ){
                  pq =  d.valor

              }
              if (d.descripcion == 'Segunda quincena' ){
                  sq =  d.valor
              }
              rmu = pq + sq

              if (d.descripcion == 'Fondos de reserva' ){
                  fd =  d.valor
              }
              if (d.descripcion == 'Aporte al IESS' ){
                  ai =  d.valor
              }
              if (d.codigo == 'IRNTA' ){
                  ir =  d.valor
              }


          }


          celda = row.createCell((short) 3)
          celda.setCellValue(rmu)
          celda = row.createCell((short) 5)
          celda.setCellValue(fd)
          celda = row.createCell((short) 6)
          celda.setCellValue(ai)
          celda = row.createCell((short) 7)
          celda.setCellValue(ir)
                  }
      def output = response.getOutputStream()
      def header = "attachment; filename=" + "reporteespecial.xlsx"
      response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
      response.setHeader("Content-Disposition", header)
      wb.write(output)
      output.flush()
  }*/

    def horasExtra(){
        println "horasExtrados"
        def mes = MesNomina.get(params.mes)
        def emepleados = []
        if(params.empleado=="-1")
            emepleados=Empleado.findAllByEstado("A")
        else{
            emepleados.add(Empleado.get(params.empleado))
        }
        def iniRow = 0
        def iniCol = 0
        //render "aqui hacer reporte"
        def celda
        def img = grailsApplication.mainContext.getResource('/images/favicons/apple-touch-icon-57x57.png').getFile()
        def curRow = iniRow
        XSSFWorkbook wb = new XSSFWorkbook()
        XSSFSheet sheet = wb.createSheet("Reporte de Horas Extras Empleados")
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
        cellTitulo.setCellValue("Petróleos y Servicios" )
        cellTitulo.setCellStyle(styleTitulo)
        XSSFCell cellSubtitulo = row2.createCell((short) iniCol)
        cellSubtitulo.setCellValue("Reporte de Horas Extras del mes "+mes.descripcion.toUpperCase());
        println mes
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


        row = sheet.createRow((short) curRow)
        celda =  row.createCell((short) 1)
        celda.setCellValue("ApellidoS")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 2)
        celda.setCellValue("Nombre")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 3)
        celda.setCellValue("Hora extra 1x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 4)
        celda.setCellValue("Hora extra 15x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 5)
        celda.setCellValue("Hora extra 2x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 6)
        celda.setCellValue("Hora extra SF 1x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 7)
        celda.setCellValue("Hora extra SF 15x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 8)
        celda.setCellValue("Hora extra SF 2x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 9)
        celda.setCellValue("Total 1x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 10)
        celda.setCellValue("Total 15x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 11)
        celda.setCellValue("Total 2x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 12)
        celda.setCellValue("Total SF 1x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 13)
        celda.setCellValue("Total SF 15x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 14)
        celda.setCellValue("Total SF 2x")
        celda.setCellStyle(styleHeader)
        celda =  row.createCell((short) 15)
        celda.setCellValue("Total")
        celda.setCellStyle(styleHeader)



        //siempreponercurRow++
        curRow++

        //def emp = Empleado.listOrderByApellido()

        emepleados.each {em  ->
            def totalEmpleadou = 0
            def totalEmpleadod = 0
            def totalEmpleadot = 0
            def totalEmpleadous = 0
            def totalEmpleadods = 0
            def totalEmpleadots = 0


            row = sheet.createRow((short) curRow)
            celda = row.createCell((short) 1)
            celda.setCellValue(em.apellido)
            curRow++
            //row = sheet.createRow((short) curRow)
            celda = row.createCell((short) 2)
            celda.setCellValue(em.nombre)
            def roles = Rol.findByEmpleadoAndMes(em, mes)
            def detalle = DetalleRol.findAllByRolAndSigno(roles, 1)
            def horas = HorasExtra.findAllByEmpleadoAndMes(em, mes)
            horas.each {hr ->
                celda = row.createCell((short) 3)
                celda.setCellValue(hr.horas1x)

                celda = row.createCell((short) 4)
                celda.setCellValue(hr.horas15x)

                celda = row.createCell((short) 5)
                celda.setCellValue(hr.horas2x)


            }
            def horasf = HorasExtraFacturacion.findAllByEmpleadoAndMes(em, mes)
            horasf.each{ hrsf ->
                celda = row.createCell((short) 6)
                celda.setCellValue(hrsf.horas1x)
                celda = row.createCell((short) 7)
                celda.setCellValue(hrsf.horas15x)
                celda = row.createCell((short) 8)
                celda.setCellValue(hrsf.horas2x)
            }

            def rubro1 = Rubro.findAllByCodigo('H200')
            def h1 = DetalleRol.findAllByRubroAndRol(rubro1,roles)
            h1.each {huno ->
                celda = row.createCell((short) 9)
                celda.setCellValue(huno.valor)
                totalEmpleadou += huno.valor
            }


            def rubro2 = Rubro.findAllByCodigo('H150')
            def h2 = DetalleRol.findAllByRubroAndRol(rubro2,roles)
            h2.each {hdos ->
                celda = row.createCell((short) 10)
                celda.setCellValue(hdos.valor)
                totalEmpleadod += hdos.valor

            }
            def rubro3 = Rubro.findAllByCodigo('H100')
            def h3 = DetalleRol.findAllByRubroAndRol(rubro3,roles)

            h3.each {htres ->
                celda = row.createCell((short) 11)
                celda.setCellValue(htres.valor)
                totalEmpleadot += htres.valor

            }
            def tt1 = totalEmpleadou + totalEmpleadod + totalEmpleadot
            def fd = 0
            def dt = 0
            def dc =0
            detalle.each {deta ->

                if (deta.descripcion == 'Horas extra SF 25' ){
                    fd =  deta.valor
                }
                if (deta.descripcion == 'Horas extra SF 50' ){
                    dt= deta.valor
                }
                if (deta.descripcion == 'Horas extra SF 100'  ){
                    dc =   deta.valor
                }

            }
            celda = row.createCell((short) 12)
            celda.setCellValue(fd)
            totalEmpleadous += fd

            celda = row.createCell((short) 13)
            celda.setCellValue(dt)
            totalEmpleadods += dt

            celda = row.createCell((short) 14)
            celda.setCellValue(dc)
            totalEmpleadots += dc
            def tt2 = totalEmpleadous + totalEmpleadods + totalEmpleadots

            def tt = tt1 + tt2

            celda = row.createCell((short) 15)
            celda.setCellValue(tt)
        }
        //celda = row.createCell((short) 15)
        //celda.setCellValue(totalEmpleado)


        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reportedehorasextras.xlsx"
        response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        response.setHeader("Content-Disposition", header)
        wb.write(output)
        output.flush()
    }
}

