<%--
Minimal coding example in D3 for May 22 demo
--%>

<html>
<head>

    <title>Graphical representation</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="../css/sierpinski.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <script type="text/javascript" src="../js/fundamental.js"></script>

</head>

<body>


<div id="container" />


<script>
    // Usage
    /////////////////////////////////

    var chart = cbbo.barChart();

    var myDataSet = [3,7,10,8,5];


    d3.select('#container')
      .datum(myDataSet)
      .call(chart.render);



</script>

</body>
</html>