<%--
Minimal coding example in D3 for May 22 demo
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Sierpinski triangle demot</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="../css/sierpinski.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <script type="text/javascript" src="../js/sierpinski.js"></script>
    <style>
    .triangle {
    }
    </style>
</head>

<body>
<div>


<script>


    var friendlyTriangle = d3.sierpinskiTriangle()
            .selectionIdentifier("body");

    friendlyTriangle
            .levelsOfDescent (6)
            .render();

     var xx=function(x,y){
         console.log('x='+x);
     }
</script>

</div><input id="levelSpinner" type="number" min="1" max="10" step="1" value="6" size="2"
             oninput="friendlyTriangle.levelsOfDescent(this.value).clear().render()"/>

<div class="control-group">
    <button onclick="friendlyTriangle.reverser()">moveAround</button>
    <button onclick="friendlyTriangle.resetColor()">resetColor</button>
</div>
</body>
</html>