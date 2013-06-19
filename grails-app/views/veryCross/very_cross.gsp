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
        /*display:inline-block;*/
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
        padding-left: 5px;
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
        /*float: right;*/
        border: 1px solid #5d9046;
        background: #67AA25;
        color: #fff;
        font-family: Arial, Helvetica, Sans-Serif;
        text-decoration: none;
        width: 100px;
        font-size: 10px;
        font-weight: bold;
        padding-right: 0px;
        padding-bottom: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
        right: 0px;
        bottom: 0px;
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



    var linkedVisualizationModule = (function () {
        //
        //  Variables to describe the layout of the whole page, with special attention
        //   to the unexpended widgets
        //
        var grandWidth = 1052,// width of the entire display
                totalWidgetNumber = 4, // how many widgets are we dealing with
                widgetHeight = 270, // how tall is each individual widget
                widgetSpacing = 7, // how much vertical space between widgets
                margin = {top: 30, right: 20, bottom: 30, left: 10},  // boundaries of displayable area
                width = grandWidth - margin.left - margin.right, // displayable width
                height = widgetHeight - margin.top - margin.bottom, // displayable height
                widgetWidth = grandWidth / totalWidgetNumber,   // each individual widget width
                quarterWidgetWidth = widgetWidth / 4,   // useful spacer
                allowThisMuchExtraSpaceInWidgetForATitle = 30, // the title in your widget
                widgetWidthWithoutSpacing = widgetWidth - (widgetSpacing * 0.5),
                widgetHeightWithTitle = widgetHeight + allowThisMuchExtraSpaceInWidgetForATitle, // final widget width

        // We have to explicitly pass in the size of the pie charts, so describe those here
                pieChartWidth = widgetWidth - 13,  // how wide is the pie chart
                pieChartRadius = pieChartWidth / 2, // pie chart reuse
                innerRadius = 30, // open circle in pie

        // The expanded widgets are described below. These numbers can't be derived from anything else, because you could
        //  in principle put this display anywhere.
                displayWidgetX = 260,// expanded widget X location.
                displayWidgetY = 320, // expanded widget Y location.
                displayWidgetWidth = 600, // expanded widget Y width.
                displayWidgetHeight = 660, // expanded widget Y height.
                bigPie = widgetWidth + (quarterWidgetWidth / 2), // size of pie in display mode

                colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f",// colors for our pie slices
                    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f",
                    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f"],

        // below are some names and text strings
                piename = ['a0', 'a1', 'a2', 'a3'], // internal names for the widgets
                textForExpandingButton = 'click to expand', // text on button to expand to full display
                textForContractingButton = 'click to contract', //text on button to contract unexpended widget

        //  This next set of variables are only for convenience.  They are derived strictly from those above,
        //   and they are consumed below in preference to those above.  The idea was to conceptually simplify
        //   some of the variables above and to those that describe either compressed or uncompressed widgets.
                compressedPos = [
                    {'x': margin.left + ((widgetWidth + widgetSpacing) * 0), 'y': 10},
                    {'x': margin.left + ((widgetWidth + widgetSpacing) * 1), 'y': 10},
                    {'x': margin.left + ((widgetWidth + widgetSpacing) * 2), 'y': 10},
                    {'x': margin.left + ((widgetWidth + widgetSpacing) * 3), 'y': 10}
                ],
                expandedPos = [
                    {'x': (widgetWidth * 0) + (quarterWidgetWidth * 1), 'y': 10},
                    {'x': (widgetWidth * 1) + (quarterWidgetWidth * 2), 'y': 10},
                    {'x': (widgetWidth * 2) + (quarterWidgetWidth * 3), 'y': 10}
                ],


        //-------widgetPosition------
        // JavaScript module. This portion of the code allows us to keep track of which widgets are expanded
        // and which remain in their original positions. There are a functions that allow you to ask the constructor
        // about its status ( examples:  isAnyWidgetExpanded() returns a Boolean to tell you if anything's expanded,
        // while expandedWidget () returns a number to tell you which widget has been expanded.
        //---------------------------
                widgetPosition = (function () {
                    // private property
                    var currentWidgetPosition = { 'up': [0, 1, 2, 3],
                                'down': [] },

                            isAnyWidgetExpanded = function () {   // returns a Boolean
                                return currentWidgetPosition.down.length > 0;
                            },

                            expandedWidget = function () {   // returns a number
                                if (currentWidgetPosition.down.length == 1) {
                                    return currentWidgetPosition.down[0];
                                } else {
                                    return -1;
                                }
                            },

                            unexpandedWidgets = function () {   // returns an array
                                return currentWidgetPosition.up;
                            },

                    // the main action routine.
                            expandThisWidget = function (widgetToBeExpanded) {  // number: 1 = success, 0 = failure
                                var indexOfDesiredWidget = 0;
                                // first make sure the incoming argument is inside the acceptable range
                                if ((widgetToBeExpanded < 0) || (widgetToBeExpanded > 3)) {
                                    return -1;
                                }
                                // another way to go wrong is to try to expand a widget that isn't in the top row to begin with
                                indexOfDesiredWidget = currentWidgetPosition.up.indexOf(widgetToBeExpanded);
                                if (indexOfDesiredWidget == -1) {
                                    return indexOfDesiredWidget;
                                }
                                // you can also go wrong if there is already a widget expanded
                                if (currentWidgetPosition.down.length != 0) {
                                    indexOfDesiredWidget = -1;
                                }

                                if (indexOfDesiredWidget > -1) {
                                    // everything looks good. Let's do what the caller has asked us to do.
                                    //First copy the widget to the down position
                                    currentWidgetPosition.down.push(currentWidgetPosition.up[indexOfDesiredWidget]);
                                    // Now remove it from the top row and collapse those around it
                                    currentWidgetPosition.up = currentWidgetPosition.up.slice(0, indexOfDesiredWidget).concat(
                                            currentWidgetPosition.up.slice(indexOfDesiredWidget + 1, 4));
                                }
                                return indexOfDesiredWidget;
                            },

                    // the other action routine, though this one is much simpler since there's only one choice
                            unexpandAllWidgets = function () {
                                currentWidgetPosition.up.push(currentWidgetPosition.down.pop());
                                currentWidgetPosition.up.sort(function (a, b) {
                                    return a - b;
                                });
                                currentWidgetPosition.down = [];
                            };
                    // end var

                    // now present the public API
                    return {
                        unexpandAllWidgets: unexpandAllWidgets,
                        expandThisWidget: expandThisWidget,
                        unexpandedWidgets: unexpandedWidgets,
                        expandedWidget: expandedWidget,
                        isAnyWidgetExpanded: isAnyWidgetExpanded
                    };


                }());


        var displayManipulator = (function () {

            var addPieChart = function (crossFilterVariable, id, key, colors, localPieChartWidth, localPieChartRadius, localInnerRadius) {
                        var dimensionVariable = crossFilterVariable.dimension(function (d) {
                            return d[key];
                        });
                        var dimensionVariableGroup = dimensionVariable.group().reduceSum(function (d) {
                            return 1;
                        });

                        return dc.pieChart("#" + id)
                                .width(localPieChartWidth)
                                .height(localPieChartWidth)
                                .transitionDuration(200)
                                .radius(localPieChartRadius)
                                .innerRadius(localInnerRadius)
                                .dimension(dimensionVariable)
                                .group(dimensionVariableGroup)
                                .colors(colors)
                                .label(function (d) {
                                    return d.data.key.toString() + ": " + d.data.value;
                                });
                    },


                    addDcTable = function (crossFilterVariable, id, key) {
                        var dimensionVariable = crossFilterVariable.dimension(function (d) {
                                    return d[key];
                                }),
                                dimensionVariableGroup = function (d) {
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
                                    }
                                ])
                                .order(d3.ascending)
                                .sortBy(function (d) {
                                    return d.assayId;
                                });
                    },


                    expandDataAreaForAllPieCharts = function (pieChartHolderElement) {
                        pieChartHolderElement.attr('height', displayWidgetY);
                    },


                    moveDataTableOutOfTheWay = function (dataTable, duration) {
                        dataTable.transition()
                                .duration(duration)
                                .style("top", displayWidgetY + displayWidgetHeight + "px");
                    },


                    shiftBackgroundWidgets = function (domDescription, horizontalPosition) {
                        domDescription
                                .transition()
                                .duration(1000)
                                .style("left", horizontalPosition + "px");
                    },


                    spotlightOneAndBackgroundThree = function (d, spotlight, background1, background2, background3, origButton, expandedPos) {
                        // first handle the spotlight element and then the three backup singers
                        spotlight
                                .style('padding-left', 10 + "px")
                                .transition()
                                .duration(200)
                                .style("top", d.display.coords.y + "px")
                                .transition()
                                .duration(400)
                                .style("left", d.display.coords.x + "px")
                                .style('height', d.display.size.height + "px")
                                .style('width', d.display.size.width + "px");
                        shiftBackgroundWidgets(background1, expandedPos[0].x);
                        shiftBackgroundWidgets(background2, expandedPos[1].x);
                        shiftBackgroundWidgets(background3, expandedPos[2].x);
                        origButton
                                .text(textForContractingButton)
                                .transition()
                                .delay(1000)
                                .duration(500)
                                .style('opacity', 1);
                    },

                    resetOneAndResettleThree = function (d, spotlight, background1, background2, background3, origButton, expandedPos) {
                        // first handle the spotlight element and then the three backup singers
                        spotlight.transition()
                                .duration(500)
                                .style('height', d.orig.size.height + "px")
                                .style('width', d.orig.size.width + "px")
                                .style('padding-left', '5px')
                                .transition()
                                .duration(500)
                                .style("left", d.orig.coords.x + "px")
                                .transition()
                                .duration(500)
                                .style("top", d.orig.coords.y + "px");

                        shiftBackgroundWidgets(background1, background1.data()[0].orig.coords.x);
                        shiftBackgroundWidgets(background2, background2.data()[0].orig.coords.x);
                        shiftBackgroundWidgets(background3, background3.data()[0].orig.coords.x);
                        var x = origButton
                                .text(textForExpandingButton)
                                .transition()
                                .delay(1000)
                                .duration(500)
                                .style('opacity', 1);
                    },

                    expandGraphicsArea = function (graphicsTarget) {

                        var bigarc = d3.svg.arc()
                                .innerRadius(innerRadius * 1.2)
                                .outerRadius(bigPie);

                        graphicsTarget
                                .attr('width', (widgetWidth * 2) + quarterWidgetWidth)
                                .attr('height', (widgetWidth * 2) + quarterWidgetWidth);

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

                    },

                    contractGraphicsArea = function (graphicsTarget) {

                        var arc = d3.svg.arc()
                                .innerRadius(innerRadius)
                                .outerRadius(pieChartRadius);

                        graphicsTarget
                                .transition()
                                .duration(1500)
                                .attr('width', pieChartWidth)
                                .attr('height', pieChartWidth);

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

                    };
            // end var

            // Public API for this module
            return {
                contractGraphicsArea:contractGraphicsArea,
                expandGraphicsArea:expandGraphicsArea,
                resetOneAndResettleThree:resetOneAndResettleThree,
                spotlightOneAndBackgroundThree:spotlightOneAndBackgroundThree,
                expandDataAreaForAllPieCharts:expandDataAreaForAllPieCharts,
                moveDataTableOutOfTheWay:moveDataTableOutOfTheWay,
                addDcTable:addDcTable,
                addPieChart:addPieChart
            };
        }() );


        //
        //   Get the data and make the plots using dc.js.  Use this as an opportunity to encapsulate any methods that are
        //    used strictly locally
        //
        var generateLinkedPies = (function () {

            // Private method used to pull the data in from the remote site
            var readInData = function (incoming) {

                        var processedAssays = {}; // Use for de-duplication
                        var developingAssayList = []; // This will be the return value

                        incoming.forEach(function (d, i) {

                            // de-duplication step
                            if (processedAssays[d.assayId] !== true) {
                                processedAssays[d.assayId] = true;

                                developingAssayList.push({
                                    index: i,
                                    assayId: d.assayId,
                                    GO_biological_process_term: d.data.GO_biological_process_term,
                                    assay_format: d.data.assay_format,
                                    assay_type: d.data.assay_type
                                });
                            }
                        });
                        return  developingAssayList;
                    },


            // Our main button handler callback
                    handleExpandOrContractClick = function (d, x) {
                        // we better decide whether where you want to expand or contract
                        var origButton = d3.select('#expbutton' + d.index)
                                .style('opacity', 0);

                        if (!widgetPosition.isAnyWidgetExpanded()) {
                            displayManipulator.expandDataAreaForAllPieCharts(d3.select('.pieCharts'));
                            displayManipulator.moveDataTableOutOfTheWay(d3.select('#data-table'), 500);
                            widgetPosition.expandThisWidget(d.index);
                            var expandedWidget = widgetPosition.expandedWidget();
                            var unexpandedWidget = widgetPosition.unexpandedWidgets();
                            displayManipulator.spotlightOneAndBackgroundThree(d, d3.select('#a' + expandedWidget),
                                    d3.select('#a' + unexpandedWidget[0]),
                                    d3.select('#a' + unexpandedWidget[1]),
                                    d3.select('#a' + unexpandedWidget[2]),
                                    origButton,
                                    expandedPos);
                            displayManipulator.expandGraphicsArea(d3.select('#a' + expandedWidget).select('.pieChart>svg'));
                        }

                        else if (widgetPosition.expandedWidget() == d.index) {
                            displayManipulator.contractGraphicsArea(d3.select('#a' + x).select('.pieChart>svg'));
                            var expandedWidget = widgetPosition.expandedWidget();
                            var unexpandedWidget = widgetPosition.unexpandedWidgets();
                            displayManipulator.resetOneAndResettleThree(d, d3.select('#a' + expandedWidget),
                                    d3.select('#a' + unexpandedWidget[0]),
                                    d3.select('#a' + unexpandedWidget[1]),
                                    d3.select('#a' + unexpandedWidget[2]),
                                    origButton,
                                    expandedPos);
                            widgetPosition.unexpandAllWidgets();
                        }

                    },

                    attachButtonsToThePieContainers = function (classOfPieContainers, callbackToExpandOrContractOnButtonClick, buttondata) {
                        var placeButtonsHere = d3.selectAll(classOfPieContainers)
                                .data(buttondata);

                        placeButtonsHere.append("div")
                                .text(textForExpandingButton)
                                .attr('class', 'expander')
                                .attr('id', function (d) {
                                    return 'expbutton' + d.index;
                                })
                                .on('click', callbackToExpandOrContractOnButtonClick);

                    };


            //   A fairly high-level method, used to call the other calls that get everything launched.
            prepareThePies = function () {

                //
                // the following data structure defines where everything sits on the page. It is attached
                //  to the data, and so it gets passed around to various callbacks. If you want to adjust
                // how this page looks, You'll probably need to change the values held below in  buttondata.
                //
                var buttondata = [
                    {    index: 0,
                        orig: {
                            coords: {
                                x: compressedPos[0].x,
                                y: compressedPos[0].y },
                            size: {
                                width: widgetWidthWithoutSpacing,
                                height: widgetHeightWithTitle }
                        },
                        display: {
                            coords: {
                                x: displayWidgetX,
                                y: displayWidgetY },
                            size: {
                                width: displayWidgetWidth,
                                height: displayWidgetHeight }
                        }
                    },
                    {    index: 1,
                        orig: {
                            coords: {
                                x: compressedPos[1].x,
                                y: compressedPos[1].y },
                            size: {
                                width: widgetWidthWithoutSpacing,
                                height: widgetHeightWithTitle }
                        },
                        display: {
                            coords: {
                                x: displayWidgetX,
                                y: displayWidgetY },
                            size: {
                                width: displayWidgetWidth,
                                height: displayWidgetHeight }
                        }
                    },
                    {    index: 2,
                        orig: {
                            coords: {
                                x: compressedPos[2].x,
                                y: compressedPos[2].y },
                            size: {
                                width: widgetWidthWithoutSpacing,
                                height: widgetHeightWithTitle }
                        },
                        display: {
                            coords: {
                                x: displayWidgetX,
                                y: displayWidgetY },
                            size: {
                                width: displayWidgetWidth,
                                height: displayWidgetHeight }
                        }
                    },
                    {   index: 3,
                        orig: {
                            coords: {
                                x: compressedPos[3].x,
                                y: compressedPos[3].y },
                            size: {
                                width: widgetWidthWithoutSpacing,
                                height: widgetHeightWithTitle }
                        },
                        display: {
                            coords: {
                                x: displayWidgetX,
                                y: displayWidgetY },
                            size: {
                                width: displayWidgetWidth,
                                height: displayWidgetHeight }
                        }
                    }
                ];

                // Retrieve the data do whatever we want to do with it
                d3.json("http://localhost:8028/cow/veryCross/feedMeJson", function (incomingData) {

                    // create an empty list, Just in case we get null data
                    var assays = [];

                    // Clean up the data.  De-dup, and assign
                    assays = readInData(incomingData);

                    // Create the crossfilter for the relevant dimensions and groups.
                    assay = crossfilter(assays);

                    // Build everything were going to display
                    allDataDcTable = displayManipulator.addDcTable(assay, 'data-table', 'assayId');
                    biologicalProcessPieChart = displayManipulator.addPieChart(assay, 'a0-chart', 'GO_biological_process_term', colors, pieChartWidth, pieChartRadius, innerRadius);
                    assayFormatPieChart = displayManipulator.addPieChart(assay, 'a1-chart', 'assay_format', colors, pieChartWidth, pieChartRadius, innerRadius);
                    assayIdDimensionPieChart = displayManipulator.addPieChart(assay, 'a2-chart', 'index', colors, pieChartWidth, pieChartRadius, innerRadius);
                    assayTypePieChart = displayManipulator.addPieChart(assay, 'a3-chart', 'assay_type', colors, pieChartWidth, pieChartRadius, innerRadius);

                    // We should be ready, display it
                    dc.renderAll();

                    // Finally, attach some data along with buttons and callbacks to the pie charts we've built
                    attachButtonsToThePieContainers('.pieChartContainer', handleExpandOrContractClick, buttondata);


                });// d3.json
            }; //prepareThePies
            return {
                prepareThePies: prepareThePies
            }
        }())//,


        // **********************************************************
        // The highest level call.  Everything starts from here.
        // **********************************************************
        generateLinkedPies.prepareThePies();


    }());

</script>

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

        <div id = "a0"  class = "pieChartContainer" style="left: 10px; top: 10px; width: 260px;  height: 300px;">
            <div id="a0-chart" class="pieChart">
                <span class="graphTitle">Biological process</span>
                <a class="reset" href="javascript:biologicalProcessPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

        </div>

        <div id = "a1"  class = "pieChartContainer" style="left: 280px; top: 10px; width: 260px; height: 300px;">
            <div id="a1-chart" class="pieChart">
                <span class="graphTitle">Assay format</span>
                <a class="reset" href="javascript:assayFormatPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

        </div>

        <div id = "a2"  class = "pieChartContainer" style="left: 550px; top: 10px;  width: 260px; height: 300px;">
            <div id="a2-chart" class="pieChart">
                <span class="graphTitle">Assay format</span>
                <a class="reset" href="javascript:assayIdDimensionPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

        </div>

        <div id = "a3"  class = "pieChartContainer" style="left: 820px; top: 10px; width: 260px; height: 300px;">
            <div id="a3-chart" class="pieChart">
                <span class="graphTitle">Assay type</span>
                <a class="reset" href="javascript:assayTypePieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
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
