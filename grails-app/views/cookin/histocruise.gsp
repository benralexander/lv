
<head>
    <script src="../js/ctrp/d3.js"></script>
    <script src="../js/histocruise.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/histocruise.css"/>

</head>

<body>
<div id="histogramGoesHere"/>
<button id="sort" onclick="sortBars()">Sort</button>
<button id="reset" onclick="reset()">Reset</button>
<script>
d3.json("http://localhost:8028/cow/cookin/retrieveJson", function (error, inData) {
    console.log('huh');
    var swirlyHistogram = d3.swirlyHistogram();
    swirlyHistogram.addSeries(inData);
    swirlyHistogram.render();
});
</script>
</body>
