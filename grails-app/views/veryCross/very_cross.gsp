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

    <title>Linked pies</title>

    <script src="../js/crossfilter.js"></script>
    <script src="../js/d3.js"></script>
    <script src="../js/dc.js"></script>
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
    .pieChartContainer{
        position: absolute;
        border:  2px solid black;
        border-radius: 8px;
        -moz-border-radius: 8px;
        -webkit-border-radius: 8px;
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
    var grandWidth = 1052;
    var totalWidgetNumber = 4;
    var widgetHeight =  270;
    var widgetSpacing = 7;
    var margin = {top: 30, right: 20, bottom: 30, left: 10},
            width = grandWidth - margin.left - margin.right,
            height = widgetHeight - margin.top - margin.bottom;
    var widgetWidth =  grandWidth / totalWidgetNumber,
            quarterWidgetWidth =  widgetWidth/4;
    var widgetWidthWithoutSpacing = 260;
    var widgetWidthWithTitle = 300;
    var pieChartWidth =  widgetWidth-13,
        pieChartRadius = pieChartWidth/2;
    var displayWidgetX = 260,
        displayWidgetY = 320,
        displayWidgetWidth = 600,
        displayWidgetHeight = 660    ;
    var pieWidth = widgetWidth;
    var data,
            innerRadius = 30,
            bigPie = widgetWidth+(quarterWidgetWidth/2),
            colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f",
                '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f",
                '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f"],
            assay = {},
            piename=['a0','a1','a2','a3'],
            pieWidgetMargin=20,
            diameter=260,
            diameter2=pieWidgetMargin +diameter+pieWidgetMargin +pieWidgetMargin +diameter+pieWidgetMargin,
            diameter3=diameter2+pieWidgetMargin +diameter+pieWidgetMargin,
            textForExpandingButton = 'click to expand',
            textForContractingButton = 'click to contract';


    var bigarc = d3.svg.arc()
            .innerRadius(innerRadius*1.2)
            .outerRadius(bigPie);
    var arc = d3.svg.arc()
            .innerRadius(innerRadius)
            .outerRadius(pieChartRadius);

    var compressedPos = [  {'x':margin.left+((widgetWidth+widgetSpacing)*0),  'y':10},
                           {'x':margin.left+((widgetWidth+widgetSpacing)*1), 'y':10},
                           {'x':margin.left+((widgetWidth+widgetSpacing)*2), 'y':10},
                           {'x':margin.left+((widgetWidth+widgetSpacing)*3), 'y':10} ];
    var expandedPos = [  {'x':(widgetWidth*0)+(quarterWidgetWidth*1),  'y':10},
                         {'x':(widgetWidth*1)+(quarterWidgetWidth*2), 'y':10},
                         {'x':(widgetWidth*2)+(quarterWidgetWidth*3), 'y':10} ];
    var displaySize =  {'width':620,  'height':660};

    var centerstagePos = {'x':742, 'y':10};

    var widgetPosition  = new WidgetPosition ();

    function WidgetPosition()  {
        var currentWidgetPosition = { 'up': [0,1,2,3],
                                  'down': [] };
        this.isAnyWidgetExpanded  =  function () {   // returns a Boolean
            return currentWidgetPosition.down.length>0;
        };
        this.expandedWidget  =  function () {   // returns a number
            if (currentWidgetPosition.down.length==1){
                return currentWidgetPosition.down[0];
            } else {
                return -1;
            }
        };
        this.unexpandedWidgets = function () {   // returns an array
            return currentWidgetPosition.up;
        };

        // the main action routine.
        this.expandThisWidget = function (widgetToBeExpanded) {  // number: 1 = success, 0 = failure
            var indexOfDesiredWidget  = 0;
            // first make sure the incoming argument is inside the acceptable range
            if ((widgetToBeExpanded < 0) || (widgetToBeExpanded > 3)) {
                return -1;
            }
            // another way to go wrong is to try to expand a widget that isn't in the top row to begin with
            indexOfDesiredWidget = currentWidgetPosition.up.indexOf(widgetToBeExpanded);
            if (indexOfDesiredWidget == -1){
                return indexOfDesiredWidget;
            }
            // you can also go wrong if there is already a widget expanded
            if (currentWidgetPosition.down.length!=0) {
                indexOfDesiredWidget = -1;
            }

            if (indexOfDesiredWidget  > -1)  {
                // everything looks good. Let's do what the caller has asked us to do.
                //First copy the widget to the down position
                currentWidgetPosition.down.push(currentWidgetPosition.up[indexOfDesiredWidget]);
                // Now remove it from the top row and collapse those around it
                currentWidgetPosition.up = currentWidgetPosition.up.slice(0,indexOfDesiredWidget).concat(
                        currentWidgetPosition.up.slice(indexOfDesiredWidget+1,4));
            }
            return indexOfDesiredWidget;
        };
        // the other action routine, though this one is much simpler since there's only one choice
        this.unexpandAllWidgets= function (){
            currentWidgetPosition.up.push(currentWidgetPosition.down.pop ());
            currentWidgetPosition.up.sort( function (a,b){
                return a-b;
            });
            currentWidgetPosition.down = [];
        };
    }



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
                .width(pieChartWidth)
                .height(pieChartWidth)
                .transitionDuration(200)
                .radius(pieChartRadius)
                .innerRadius(innerRadius)
                .dimension(dimensionVariable)
                .group(dimensionVariableGroup)
                .colors(colors)
                .label(function (d) {
                    return d.data.key.toString() + ": " + d.data.value;
                });
    }


    function addDcTable(crossFilterVariable, id, key) {
        var dimensionVariable = crossFilterVariable.dimension(function (d) {return d[key]; }),
            dimensionVariableGroup = function (d) {return "";};

        return dc.dataTable("#" + id)
                .dimension(dimensionVariable)
                .group(dimensionVariableGroup)
                .size(20)
                .columns([
                        function (d) {return d.index;},
                        function (d) {return d.assayId;},
                        function (d) {return d.GO_biological_process_term;},
                        function (d) {return d.assay_format;},
                        function (d) {return d.assay_type;}
                  ])
                .order(d3.ascending)
                .sortBy(function (d) {return d.assayId;});
    }



     function expandDataAreaForAllPieCharts (pieChartHolderElement)  {
         pieChartHolderElement.attr('height',diameter3);
     }


    function moveDataTableOutOfTheWay (dataTable, duration)  {
        dataTable.transition()
                .duration(duration)
                .style("top",diameter3+pieWidgetMargin+pieWidgetMargin+pieWidgetMargin+pieWidgetMargin +"px") ;
    }


    function shiftBackgroundWidgets ( domDescription, horizontalPosition)  {
        domDescription
                .transition()
                .duration(1500)
                .style("left",horizontalPosition+"px");
    }


    function spotlightOneAndBackgroundThree (d,spotlight,background1,background2,background3,origButton,expandedPos)  {
        // first handle the spotlight element and then the three backup singers
        spotlight.classed('sizeMinor',false)
                .style('padding-left',pieWidgetMargin+"px")
                .transition()
                .duration(1000)
                .style("top",""+(diameter+pieWidgetMargin+pieWidgetMargin+pieWidgetMargin)+"px")
                .transition()
                .duration(1000)
                .style("left",diameter+"px")
                .transition()
                .duration(500)
                .style('height',diameter2+pieWidgetMargin+pieWidgetMargin+pieWidgetMargin+"px")
                .transition()
                .duration(1000)
                .style('width',pieWidgetMargin+diameter2+"px")
                .transition()
                .duration(1000);
        shiftBackgroundWidgets (background1,expandedPos[0].x);
        shiftBackgroundWidgets (background2,expandedPos[1].x);
        shiftBackgroundWidgets (background3,expandedPos[2].x);
        var x=origButton
                 .text(textForContractingButton);
    }
    function resetOneAndResettleThree (d,spotlight,background1,background2,background3,origButton,expandedPos)  {
        // first handle the spotlight element and then the three backup singers
        spotlight.transition()
                .duration(500)
                .style('height',spotlight.data()[0].orig.size.height+"px")
                .style('width',spotlight.data()[0].orig.size.width+"px")
                .style('padding-left',"0px")
                .transition()
                .duration(500)
                .style("left",spotlight.data()[0].orig.coords.x+"px")
                .transition()
                .duration(500)
                .style("top",spotlight.data()[0].orig.coords.y+"px")
;
        shiftBackgroundWidgets (background1,background1.data()[0].orig.coords.x);
        shiftBackgroundWidgets (background2,background2.data()[0].orig.coords.x);
        shiftBackgroundWidgets (background3,background3.data()[0].orig.coords.x);
        var x=origButton
                .text(textForExpandingButton);
    }

    function expandGraphicsArea (graphicsTarget) {
        graphicsTarget
                .attr('width',(widgetWidth*2)+quarterWidgetWidth)
                .attr('height',(widgetWidth*2)+quarterWidgetWidth);

        graphicsTarget
                .select('g')
                .selectAll('text')
                .remove();

        graphicsTarget
                .selectAll('g')
                .select('path')
                .transition()
                .duration(1500)
                .attr("d", bigarc)
                .attr("transform", "translate(171,171)");

    }
    function contractGraphicsArea (graphicsTarget) {
        graphicsTarget
                .transition()
                .duration(1500)
                .attr('width',pieChartWidth)
                .attr('height',pieChartWidth);

        graphicsTarget
                .select('g')
                .selectAll('text')
                .remove();

        graphicsTarget
                .selectAll('g')
                .select('path')
                .transition()
                .duration(500)
                .attr("d", arc)
                .attr("transform", "translate(0,0)");

    }


    function clickMiddleOfPie(d,x) {
        // we better decide whether where you want to expand or contract
        var origButton=d3.selectAll('#expbutton'+d.index);

        if (!widgetPosition.isAnyWidgetExpanded())  {
            expandDataAreaForAllPieCharts (d3.select('.pieCharts'));
            moveDataTableOutOfTheWay(d3.select('#data-table'), 500);
            widgetPosition.expandThisWidget(d.index);
            var expandedWidget = widgetPosition.expandedWidget ();
            var unexpandedWidget =  widgetPosition.unexpandedWidgets ();
            spotlightOneAndBackgroundThree (d,d3.select('#a'+expandedWidget),
                    d3.select('#a'+unexpandedWidget[0]),
                    d3.select('#a'+unexpandedWidget[1]),
                    d3.select('#a'+unexpandedWidget[2]),
                    origButton,
                    expandedPos);
            expandGraphicsArea (d3.select('#a'+expandedWidget).select('.pieChart>svg'));
        }

        else if (widgetPosition.expandedWidget()==d.index) {
            contractGraphicsArea (d3.select('#a'+x).select('.pieChart>svg'));
            var expandedWidget = widgetPosition.expandedWidget ();
            var unexpandedWidget =  widgetPosition.unexpandedWidgets ();
            resetOneAndResettleThree(d,d3.select('#a'+expandedWidget),
                    d3.select('#a'+unexpandedWidget[0]),
                    d3.select('#a'+unexpandedWidget[1]),
                    d3.select('#a'+unexpandedWidget[2]),
                    origButton,
                    expandedPos);
            widgetPosition.unexpandAllWidgets();
        }

    }



    //
    //   Get the data and make the plots using dc.js
    //
    var generateLinkedPies = function () {
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

              var buttondata = [  {    index  :  0,
                                       orig   :  {     coords  :  {     x      :  compressedPos[0].x,
                                                                        y      :  compressedPos[0].y },
                                                       size    :  {     width  :  widgetWidthWithoutSpacing,
                                                                        height :  widgetWidthWithTitle }
                                       },
                                       display:  {     coords  :  {     x      :  displayWidgetX ,
                                                                        y      :  displayWidgetY },
                                                       size    :  {     width  :  displayWidgetWidth,
                                                                        height :  displayWidgetHeight }
                                       }
                                  },
                                  {    index  :  1,
                                       orig   :  {     coords   :  {     x      :  compressedPos[1].x,
                                                                         y      :  compressedPos[1].y },
                                                       size     :  {     width  :  widgetWidthWithoutSpacing,
                                                                         height :  widgetWidthWithTitle }
                                                 },
                                       display:  {     coords  :  {     x      :  displayWidgetX ,
                                                                        y      :  displayWidgetY },
                                                       size    :  {     width  :  displayWidgetWidth,
                                                                        height :  displayWidgetHeight }
                                       }
                                  },
                                  {    index  :  2,
                                       orig   :  {     coords  :  {     x      :  compressedPos[2].x,
                                                                        y      :  compressedPos[2].y },
                                                       size    :  {     width  :  widgetWidthWithoutSpacing,
                                                                        height :  widgetWidthWithTitle }
                                                 },
                                       display:  {     coords  :  {     x      :  displayWidgetX ,
                                                                        y      :  displayWidgetY },
                                                       size    :  {     width  :  displayWidgetWidth,
                                                                        height :  displayWidgetHeight }
                                                 }
                                  },
                                  {   index  :  3,
                                      orig   :  {     coords  :  {     x      :  compressedPos[3].x,
                                                                       y      :  compressedPos[3].y },
                                                      size    :  {     width  :  widgetWidthWithoutSpacing,
                                                                       height :  widgetWidthWithTitle }
                                                },
                                      display:  {     coords  :  {     x      :  displayWidgetX ,
                                                                       y      :  displayWidgetY },
                                                      size    :  {     width  :  displayWidgetWidth,
                                                                       height :  displayWidgetHeight }
                                                }
                                  }
              ];

            var placeButtonsHere =    d3.selectAll('.pieChartContainer')
                                        .data(buttondata);


            placeButtonsHere.append("div")
                    .text(textForExpandingButton)
                    .attr('class', 'expander')
                    .attr('id', function(d){return 'expbutton'+ d.index;})
                    .on('click',clickMiddleOfPie);


        });
    }();

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

        <div id = "a0"  class = "pieChartContainer" style="left: 10px; top: 10px;">
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

        <div id = "a1"  class = "pieChartContainer" style="left: 280px; top: 10px;">
            <div id="a1-chart" class="pieChart">
                <span class="graphTitle">Assay format</span>
                <a class="reset" href="javascript:assayFormatPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="assayFormatPieBlocks">
            </div>
        </div>

        <div id = "a2"  class = "pieChartContainer" style="left: 550px; top: 10px;">
            <div id="a2-chart" class="pieChart">
                <span class="graphTitle">Assay format</span>
                <a class="reset" href="javascript:assayIdDimensionPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="assayIDPieBlocks">
            </div>
        </div>

        <div id = "a3"  class = "pieChartContainer" style="left: 820px; top: 10px;">
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
