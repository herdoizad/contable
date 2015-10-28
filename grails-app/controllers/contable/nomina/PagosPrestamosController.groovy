package contable.nomina

import contable.core.Mes
import contable.seguridad.Shield

class PagosPrestamosController extends Shield {

    def pendientes() {
        def meses = MesNomina.findAllByCodigoLessThanEquals((new Date().format("yyyy")+"12").toInteger(),[sort:"codigo"])
        [meses:meses]
    }


    def getPagosMes_ajax(){
        def mes = MesNomina.get(params.mes)
        def pagos = DetallePrestamo.findAllByMes(mes)
        [mes:mes,pagos:pagos]
    }


    def generarPagos_ajax(){
        def mes = MesNomina.get(params.mes)
        def cal = Calendar.getInstance();
        def now = new Date().parse("yyyyMMdd",""+mes.codigo+"01")
        cal.set(Calendar.MONTH, now.format("MM").toInteger()-1);
        cal.set(Calendar.YEAR, now.format("yyyy").toInteger());
        cal.set(Calendar.DAY_OF_MONTH, 1);// This is necessary to get proper results
        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));

        def fin = cal.getTime();
        def taza = Variable.findByCodigo("TINT").valor
        println "fin "+fin.format("dd-MM-yyyy HH:mm")
        def prestamos = Prestamo.findAllByInicioLessThanEqualsAndFinGreaterThanEquals(fin,fin.minus(1))
        prestamos.each {p->
            println "p "+p.tipo+" "+p.empleado+"  "+p.monto
            def detalle = DetallePrestamo.findByPrestamoAndMes(p,mes)
            def finp= p.fin
            if(!detalle){
                def previos = DetallePrestamo.findAllByPrestamoAndEstado(p,"A",[sort: "fechaDePago",order:"desc"])
                def saldo = p.monto
                def inicio  = new Date().parse("yyyyMMdd",p.inicio.format("yyyyMM")+"01")
                def cuotaAnterior = p.valorCuota
                if(previos.size()>0){
                    saldo=previos[0].saldo
                    inicio=previos[0].fechaDePago
                    cuotaAnterior=previos[0].cuota
                }
                if(saldo>0){
                    detalle = new DetallePrestamo()
                    detalle.estado="R"
                    detalle.fechaDePago=fin
                    detalle.prestamo=p
                    if(p.tipo.codigo=="CSMO")
                        detalle.interes=(saldo*((fin-inicio)+1)*((taza/100)/360)).toDouble().round(2)
                    else
                        detalle.interes=0
                    println "cuota anterior "+cuotaAnterior+" --  "+p.valorCuota
                    println "inicio "+inicio.format("dd-MM-yyyy")+" -  "+fin.format("dd-MM-yyyy")+"  "+(fin-inicio)
                    if(cuotaAnterior==p.valorCuota.toDouble().round(2) && (fin-inicio)<32){
                        detalle.capital=(p.valorCuota-detalle.interes).toDouble().round(2)
                        detalle.cuota=p.valorCuota.toDouble().round(2)
                        detalle.saldo=(saldo-detalle.capital).toDouble().round(2)
                        detalle.taza=taza
                        detalle.usuario=session.usuario.login
                        detalle.mes=mes

                    }else{
                        def plazo = p.fin.format("MM").toInteger()-inicio.format("MM").toInteger()


                        Calendar startCalendar = new GregorianCalendar();
                        startCalendar.setTime(fin);
                        Calendar endCalendar = new GregorianCalendar();
                        endCalendar.setTime(p.fin);

                        int diffYear = endCalendar.get(Calendar.YEAR) - startCalendar.get(Calendar.YEAR);
                        plazo = diffYear * 12 + endCalendar.get(Calendar.MONTH) - startCalendar.get(Calendar.MONTH);
                        plazo+=1


                        println "plazo "+plazo+"  "+p.fin.format("dd-MM-yyyy")+" "+fin.format("dd-MM-yyyy")
//                        plazo=Math.ceil(plazo/30)
                        println "plazo int "+plazo.toInteger()
                        if(p.interes>0){
                            def interes = taza/plazo/100
                            def cuota = interes*Math.pow(1+interes,plazo)
                            cuota=cuota/(Math.pow(1+interes,plazo)-1)
                            cuota=cuota*saldo
                            detalle.capital=(cuota-detalle.interes).toDouble().round(2)
                            detalle.cuota=cuota.toDouble().round(2)
                            detalle.saldo=(saldo-detalle.capital).toDouble().round(2)
                            detalle.taza=taza
                            detalle.usuario=session.usuario.login
                            detalle.mes=mes
                        }else{
                            def cuota = (saldo/plazo).toDouble().round(2)
                            detalle.capital=cuota
                            detalle.cuota=cuota
                            detalle.saldo=(saldo-detalle.capital).toDouble().round(2)
                            detalle.taza=taza
                            detalle.usuario=session.usuario.login
                            detalle.mes=mes
                        }                    }
                    if(fin.clearTime()>=finp.clearTime()){
                        if(detalle.saldo!=0) {
                            detalle.cuota += detalle.saldo
                            detalle.capital+=detalle.saldo
                            detalle.saldo=0
                        }
                    }
                    if(!detalle.save(flush: true))
                        println "error save detalle "+detalle.errors

                }

            }

        }
        redirect(action: 'getPagosMes_ajax',params: [mes:mes.id])
    }

    def borrar_ajax(){
        def detalle = DetallePrestamo.get(params.id)
        if(detalle.estado!="A") {
            detalle.delete(flush: true)
        }
        redirect(action: 'getPagosMes_ajax',params: [mes:params.mes])
    }


    def guardar_ajax(){
//        println "guardar "+params
        def detalle = DetallePrestamo.get(params.id)
        detalle.cuota=params.cuota.toDouble().round(2)
        detalle.capital=detalle.cuota-detalle.interes
        detalle.saldo=params.saldo.toDouble().round(2)
        if(params.aprobar=="1") {
            def rol = Rol.findByEmpleadoAndMes(detalle.prestamo.empleado,detalle.mes)
            println "rol "+rol
            if(!rol || rol?.estado=="N"){
                println "if rol"
                detalle.estado = "A"
                if(rol){
                    def dr = new DetalleRol()
                    dr.descripcion="Prestamo (${detalle.saldo}/${detalle.prestamo.monto})"
                    dr.codigo="PRST"
                    dr.detallePrestamo=detalle
                    dr.rol=rol
                    dr.signo=-1
                    dr.usuario=session.usuario.login
                    dr.valor=detalle.cuota
                    if(!dr.save(flush: true))
                        println "error save detalle rol "+dr.errors
                }
                if(!detalle.save(flush: true))
                    println "error save detalle "+detalle.errors
                render "ok"
                return

            }else{
                render "No se puede aprobar el descuento. El rol de pagos del mes de ${detalle.mes.descripcion} ya ha sido aprobado"
                return
            }

        }else{
            detalle.save(flush: true)
            render "ok"
        }

    }


    def desaprobar_ajax(){
        def detalle = DetallePrestamo.get(params.id)
        detalle.estado="R"
        detalle.save(flush: true)
        def detRol = DetalleRol.findByDetallePrestamo(detalle)
        if(detRol)
            detRol.delete(flush: true)
        render "ok"
    }

}
