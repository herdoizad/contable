<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="P&S Sistema contable"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <imp:favicon/>
    <imp:importJs/>
    <imp:plugins/>
    <imp:customJs/>
    <imp:spinners/>
    <imp:importCss/>
    <g:layoutHead/>
</head>
<body id="body">
<div class="menu${session.color}">
<mn:menuVertical/>
</div>
<div class="contenido">
    <mn:barraTop titulo="${g.layoutTitle(default: 'P&S')}"></mn:barraTop>
    <g:layoutBody/>
</div>
<script type="text/javascript">
    var estadoMenu = 1
    $("#control-menu").click(function(){
        $(".toggle-menu").toggle()
        if(estadoMenu==1){
            $(".submenu").hide()
            $(".submenu-1").hide()
            $(".menu").animate({
                width:55
            })
            $(".menu-1").animate({
                width:55
            })
            $(".contenido").animate({
                marginLeft:"55"
            })
            estadoMenu=0

        }else{
            $(".menu").animate({
                width:180
            })
            $(".menu-1").animate({
                width:180
            })
            $(".contenido").animate({
                marginLeft:"180"
            })
            estadoMenu=1
        }
        return false
    })
    $(".dropdown-toggle").click(function(){
        if(estadoMenu==1) {
            $(this).parent().find(".submenu").toggle()
            $(this).parent().find(".submenu-1").toggle()
        }else {
            $("#control-menu").click()
            $(this).parent().find(".submenu").toggle()
            $(this).parent().find(".submenu-1").toggle()
        }
        return false
    })
</script>
</body>
</html>
