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

    function update(){
        var data = randomDataset();
        d3.select('#container')
                .datum(data)
                .call(chart);
    }

    function randomDataset(){
        return d3.range(~~(Math.random() * 50)).map(function(d, i){
            return ~~(Math.random() * 1000);
        });
    }

    update();


</script>

</body>
</html>