<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 5/6/13
  Time: 11:37 AM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <title>Zeo + Crossfilter</title>

    <script src="../js/crossfilter.min.js"></script>
    <script src="../js/d3.min.js"></script>
    <script src="../js/dc.js"></script>
%{--<script src="../js/graph.js"></script>--}%
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dc.css')}" />
    <style>
    body{
        width: 1400px;
    }

    .pieChart{
        display:inline-block;
    }
     .legendLine{
        line-height: 250%;
    }

     #graphs{
      /*  display: inline-block;  */

    }

    #pieCharts{
        position: absolute;
        width: 1100px;
        height: 300px;
        left: 0px;
        top: 0px;
    }

    #histogram{
        display:block;
    }

    #histTitle{
        margin-left: 20px;
    }
    .pieChartContainer{
        position: absolute;
        border:

    }
    .sizeMinor {
        width: 260px;
        height: 260px;
    }
    .sizeMajor {
        width: 600px;
        height: 600px;
    }
    .posCompressed0{
        left: 10px;
        top: 10px;
    }
    .posCompressed1{
        left: 260px;
        top: 10px;
    }
    .posCompressed2{
        left: 520px;
        top: 10px;
    }
    .posCompressed3{
        left: 780px;
        top: 10px;
    }
    #widthTest{
        position: absolute;
        visibility: hidden;
        height: auto;
        width: auto;
    }

    .graphTitle{
        font-size: 130%;
        font-weight: 700;
    }


    .data-table-th {
        background: #146D8F;
        color: #FFFFFF;
        font-weight: 600;
    }

    table#data-table td, th  {
        text-align: center;
        margin: 0;
        outline: 0 none;
        list-style: none;
        border-spacing: 0px;

        border-bottom: 1px solid #6C6C6C;
        font-family: 'Open Sans';
        font-size: 13px;
        font-style: normal;
        height: 50px;
        padding: 15px 5px 10px;
        width: 97px;
    }

    table#data-table tr:nth-child(odd) {
        background: #e1e1e1;
    }

    table#data-table tr:nth-child(even) {
        background: #FFF;
    }

    table#data-table tr:hover {
        background-color: #a3a3a3;
    }

     table{
        clear: both;
        width: 97%;
        font-family: 'Cabin';
        border: 1px solid #6C6C6C;
        margin: 15px;
        border-spacing: 0px;
        text-align: center;
    }
    .expander{
        float: right;
        border: 1px solid #5d9046;
        background: #67AA25;
        color: #fff;
        font-family: Arial, Helvetica, Sans-Serif;
        text-decoration: none;
        width: 100px;
        font-size: 10px;
        font-weight: bold;
        padding: 3px 0;
        text-align: center;
        display: block;
        border-radius: 4px;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;
        text-shadow: 1px 1px 1px #666;
        -moz-box-shadow: 0 1px 3px #111;
        -webkit-box-shadow: 0 1px 3px #111;
        box-shadow: 0 1px 3px #111;
        background: #3F8EB5; /* old browsers */
        background: -moz-linear-gradient(top, #3F8EB5 0%, #1D76A0 100%); /* firefox */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#3F8EB5), color-stop(100%,#1D76A0)); /* webkit */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3F8EB5', endColorstr='#1D76A0',GradientType=0 );
    }
    </style>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'style.css')}" />

<script>

    // Various formatters.
    var data,
//                formatNumber = d3.format(",d"),
//                formatFloat = d3.format(",.2f"),
//                formatChange = d3.format("+,d"),
//                formatDate = d3.time.format("%B %d, %Y"),
//                formatTime = d3.time.format("%I:%M %p"),
            pieWidth = 250,
            innerRadius = 30,
            bigPie = 300,
            colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f",
                '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f",
                '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f"],
            assay = {},
            piename=['a0','a1','a2','a3'],
            margin=20,
            diameter=260,
            diameter2=margin +diameter+margin +margin +diameter+margin,
            diameter3=diameter2+margin +diameter+margin;


    var bigarc = d3.svg.arc()
            .innerRadius(innerRadius*1.2)
            .outerRadius(bigPie);

    var compressedPos = [  {'x':10,  'y':10},
                           {'x':260, 'y':10},
                           {'x':520, 'y':10},
                           {'x':780, 'y':10} ];
    var expandedPos = [  {'x':50,  'y':10},
                         {'x':396, 'y':10},
                         {'x':742, 'y':10} ];

    var centerstagePos = {'x':742, 'y':10};



        function readInData(incoming) {

        var processedAssays = {}; // Use for de-duplication
        var developingAssayList = []; // This will be the return value

        incoming.forEach(function (d, i) {

            // de-duplication step
            if (processedAssays[d.assayId] !== true) {
                processedAssays[d.assayId] = true;

                developingAssayList.push({
                    index:i,
                    assayId:d.assayId,
                    GO_biological_process_term:d.data.GO_biological_process_term,
                    assay_format:d.data.assay_format,
                    assay_type:d.data.assay_type
                });
            }
        });
        return  developingAssayList;
    }

    function addPieChart(crossFilterVariable, id, key, colors) {
        var dimensionVariable = crossFilterVariable.dimension(function (d) {
            return d[key];
        });
        var dimensionVariableGroup = dimensionVariable.group().reduceSum(function (d) {
            return 1;
        });

        return dc.pieChart("#" + id)
                .width(250)
                .height(250)
                .transitionDuration(200)
                .radius(120)
                .innerRadius(30)
                .dimension(dimensionVariable)
                .group(dimensionVariableGroup)
                .colors(colors)
                .label(function (d) {
                    return d.data.key.toString() + ": " + d.data.value;
                });
    }


    function addDcTable(crossFilterVariable, id, key) {
        var dimensionVariable = crossFilterVariable.dimension(function (d) {
            return d[key];
        });
        var dimensionVariableGroup = function (d) {
            return "";
        };

        return dc.dataTable("#" + id)
                .dimension(dimensionVariable)
                .group(dimensionVariableGroup)
                .size(20)
                .columns([
            function (d) {
                return d.index;
            },
            function (d) {
                return d.assayId;
            },
            function (d) {
                return d.GO_biological_process_term;
            },
            function (d) {
                return d.assay_format;
            },
            function (d) {
                return d.assay_type;
            }])
                .order(d3.ascending)
                .sortBy(function (d) {
                    return d.assayId;
                });
    }

     function expandForAllPieCharts (pieChartHolderElement)  {
         pieChartHolderElement.attr('height',diameter3);
     }
    function moveDataTableOutOfTheWay (dataTable, duration)  {
        dataTable.transition()
                .duration(duration)
                .style("top",diameter3+ "px") ;
    }
    function spotlightOneAndBackgroundThree (spotlight,background1,background2,background3,expandedPos)  {
        // first handle the spotlight element and then the three backup singers
        spotlight.attr('height',diameter2)
                .attr('width',diameter2)
                .style("top","10px")
                .transition()
                .duration(500)
                .style("top",""+(diameter+margin)+"px")
                .transition()
                .duration(500)
                .style("left",""+diameter+"px");
        background1
                .transition()
                .duration(1500)
                .style("left",""+expandedPos[0].x+"px");
        background2
                .transition()
                .duration(1500)
                .style("left",""+expandedPos[1].x+"px");
        background3
                .transition()
                .duration(1500)
                .style("left",""+expandedPos[2].x+"px");
    }

    function clickMiddleOfPie(d,x) {
        // x tells us the index of the pie
        // this is the pie DOM element

        //
        //move other tables out of the way, and increase the size of the pie
        //

        // increase size of palatte
        expandForAllPieCharts (d3.select('.pieCharts'));
        moveDataTableOutOfTheWay(d3.select('#data-table'), 500);
        spotlightOneAndBackgroundThree (d3.select('#a0'),d3.select('#a1'),d3.select('#a2'),d3.select('#a3'),expandedPos);

        var s=d3.select('#a'+x);
        s.select('#a0-chart>svg')
                .attr('width',600)
                .attr('height',600);

        s.select('#a0-chart>svg>g')
                .selectAll('text')
                .remove();

        s.select('#a0-chart>svg>g')
                .selectAll('g')
                .select('path')
                .transition()
                .duration(1500)
                .attr("d", bigarc)
                .attr("transform", "translate(175,175)");

    }



    //
    //   Get the data and make the plots using dc.js
    //
    d3.json("http://localhost:8028/cow/veryCross/feedMeJson", function (incomingData) {
        // create an empty list
        var assays = [];

        // Clean up the data.  De-dup, and assign
        assays = readInData(incomingData);


        // Create the crossfilter for the relevant dimensions and groups.
        assay = crossfilter(assays);

        allDataDcTable = addDcTable(assay, 'data-table', 'assayId');
        biologicalProcessPieChart = addPieChart(assay, 'a0-chart', 'GO_biological_process_term', colors);
        assayFormatPieChart = addPieChart(assay, 'a1-chart', 'assay_format', colors);
        assayIdDimensionPieChart = addPieChart(assay, 'a2-chart', 'index', colors);
        assayTypePieChart = addPieChart(assay, 'a3-chart', 'assay_type', colors);

        dc.renderAll();

        var buttondata = [  {name:"a",num:0},
                            {name:"b",num:1},
                            {name:"c",num:2},
                            {name:"d",num:3}] ;

        var placeButtonsHere = d3.selectAll('.pieChartContainer')
                .data(buttondata);


        placeButtonsHere.append("div").text('click to expand').attr("class", "expander").on('click',clickMiddleOfPie);


    });

</script>

<style>
    @import url(http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:400,700);
    </style>
</head>
<body>
<div id = "graphs">
    %{--<div id="histogram">--}%
        %{--<span id = "histTitle" class="graphTitle">Histogram</span>--}%
        %{--<a class="reset" href="javascript:histogramChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>--}%
        %{--<span class="reset" style="display: none;"></span>--}%
        %{--<div class = "clearfix"></div>--}%
    %{--</div>--}%

    <div id = "pieCharts" class="pieCharts">

        <div id = "a0"  class = "pieChartContainer posCompressed0 sizeMinor"  >
            <div id="a0-chart" class="pieChart">
                <span class="graphTitle">Biological process</span>
                <a class="reset" href="javascript:biologicalProcessPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="a0.chartBlocks">
            </div>
           %{--<span class="expander">Click to expand</span>--}%
        </div>

        <div id = "a1"  class = "pieChartContainer posCompressed1 sizeMinor" >
            <div id="a1-chart" class="pieChart">
                <span class="graphTitle">Assay format</span>
                <a class="reset" href="javascript:assayFormatPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="assayFormatPieBlocks">
            </div>
        </div>

        <div id = "a2"  class = "pieChartContainer posCompressed2 sizeMinor" >
            <div id="a2-chart" class="pieChart">
                <span class="graphTitle">Assay format</span>
                <a class="reset" href="javascript:assayIdDimensionPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="assayIDPieBlocks">
            </div>
        </div>

        <div id = "a3"  class = "pieChartContainer posCompressed3 sizeMinor">
            <div id="a3-chart" class="pieChart">
                <span class="graphTitle">Assay type</span>
                <a class="reset" href="javascript:assayTypePieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="assayTypePieBlocks">
            </div>
        </div>

    </div>






</div>
%{--<script>--}%
    %{----}%
    %{----}%
    %{--var buttondata = [{"name":"a"},--}%
        %{--{"name":"b"},--}%
        %{--{"name":"c"},--}%
        %{--{"name":"d"}] ;--}%

    %{--d3.selectAll(".pieChartContainer")--}%
%{--.data(buttondata)--}%
%{--.enter()--}%
%{--.append('p').text("j") ;--}%
%{--//                .append("span")--}%
%{--//                .attr("class", "expander").property("value","g");--}%
%{--//                .attr("transform", "translate(" + outerRadius + "," + outerRadius + ")");--}%





%{--</script>--}%

    <table id="data-table" class="table table-hover dc-data-table"  style="position:absolute; left: 10px; top: 300px;">
    <thead>
    <tr class="header">
        <th class="data-table-th">Index</th>
        <th class="data-table-th">Assay</th>
        <th class="data-table-th">Biological process</th>
        <th class="data-table-th">Assay format</th>
        <th class="data-table-th">Assay type</th>
    </tr>
    </thead>
</table>

<div id="widthTest" class="legendLine"></div>
</body>
</html>
