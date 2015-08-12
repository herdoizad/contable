package contable



class UtilitariosTagLib {
    static defaultEncodeAs = [taglib: 'none']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    static namespace = "util"

    def renderHTML = { attrs ->
        out << attrs.html
    }



    def clean = { attrs ->
//        println("att" + attrs)
        def replace = [
                "&aacute;": "á",
                "&eacute;": "é",
                "&iacute;": "í",
                "&oacute;": "ó",
                "&uacute;": "ú",
                "&ntilde;": "ñ",

                "&Aacute;": "Á",
                "&Eacute;": "É",
                "&Iacute;": "Í",
                "&Oacute;": "Ó",
                "&Uacute;": "Ú",
                "&Ntilde;": "Ñ",

                "&nbsp;"  : " ",
                "&;"  : "y",
                "&"  : "y",

                "&lt;"    : "<",
                "&gt;"    : ">",

                "&amp;"   : "&",

                "&quot;"  : '"',

                "&lsquo;" : '‘',
                "&rsquo;" : '’',
                "&ldquo;" : '“',
                "&rdquo;" : '”',

                "&lsaquo;": '‹',
                "&rsaquo;": '›',
                "&laquo;" : '«',
                "&raquo;" : '»',

                "&permil;": '‰',

                "&hellip;": '...'
        ]
        def str = attrs?.str

        replace.each { busca, nuevo ->
            str = str?.replaceAll(busca, nuevo)
         }
        out << str
    }



}
