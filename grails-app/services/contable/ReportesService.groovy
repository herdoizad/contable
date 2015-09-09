package contable

import grails.transaction.Transactional

@Transactional
class ReportesService {

    def server ="localhost:8080/contable"

    String getVcardComprobante(usuario,numero,tipo,mes) {
        def s = new StringBuilder()
        s << "BEGIN:VCARD\n"
        s << "VERSION:3.0\n"
        s << "N:${usuario};;;\n"
        s << "FN: Generado por: ${usuario}, el ${new Date().format('dd-MM-yyyy HH:mm')}\n"
        s << "ORG:Petroleos y Servicios\n"
        s << "TITLE:Comprobante PS-${mes}-${tipo}-${numero}\n"
        s << "TEL;TYPE=work,voice,pref:381-9680\n"
        s << "REV:${new Date().format('dd-MM-yyyy HH:mm')}\n"
        s << "URL:http://${server}/verificaDocumentos?key="+generaCodigoComprobante(numero,tipo,mes)+"\n"
        s << "END:VCARD\n"
        return s.toString()
    }
    String getVcardReporte(usuario,titulo) {
        def s = new StringBuilder()
        s << "BEGIN:VCARD\n"
        s << "VERSION:3.0\n"
        s << "N:${usuario};;;\n"
        s << "FN: Generado por: ${usuario}, el ${new Date().format('dd-MM-yyyy HH:mm')} \n"
        s << "ORG:Petroleos y Servicios\n"
        s << "TITLE:${titulo}\n"
        s << "TEL;TYPE=work,voice,pref:381-9680\n"
        s << "REV:${new Date().format('dd-MM-yyyy HH:mm')}\n"
//        s << "URL:http://${server}/verificaDocumentos?key="+generaCodigoComprobante(numero,tipo,mes)+"\n"
        s << "END:VCARD\n"
        return s.toString()
    }

    def generaCodigoComprobante(numero,tipo,mes){
        def num =""+mes+tipo+numero
        def n = new Random()
        def key=n.nextInt((num.size()-1)*10000)
        num=num.toLong()
        num=num-key
        key=key.toString()
        def separador = key[0].toInteger()*10
        if(separador<65)
            separador=65
        return ""+key+Character.toChars(separador)+num
    }

    def desifraKey(String key){
        def b = key[0]
        def separador = key[0].toInteger()*10
        if(separador<65)
            separador=65
        def parts = key.split(Character.toChars(separador).toString())
        def codigo = parts[1].toLong()+parts[0].toLong()
        codigo=codigo.toString()
        return [codigo[0..5],codigo[6..6],codigo[7..codigo.size()-1]]
    }

}
