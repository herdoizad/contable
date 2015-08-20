package contable.reportes

import contable.core.Banco
import contable.core.Cuenta
import contable.seguridad.Shield

class ReportesController extends Shield {

    def index() {
        def anio = session.empresa.anio
        def inicio = new Date().parse("yyyyMMdd",anio+"0101")
        def fin  = new Date()
        def cuentas = Cuenta.findAllByAgrupa(1,[sort:"numero"])
        def cuentasMayor = Cuenta.findAllByNivel(3,[sort:"numero"])
        def cuentas4 = Cuenta.findAllByNivel(4,[sort:"numero"])
        def bancos = Banco.list([sort: "codigo"])
        def dias = ["0":"0","30":"30","60":"60","90":"90","365":"365","1826":"Más de 1825"]

        def reportes = ["1":"Balance de comprobación",
                        "2":"Auxiliar","3":"Auxiliar por rango","4":"Estado de resultado integral",
                        "5":"Cartera vencida","6":"Cheques","7":"Diario general","8":"Mayor general",
                        "9":"Mayor auxiliar","10":"Estado de situación financiera"]
        [inicio:inicio,fin:fin,cuentas:cuentas,cuentasMayor:cuentasMayor,bancos:bancos,cuentas4:cuentas4,dias:dias,reportes:reportes]
    }
}
