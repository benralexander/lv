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
        margin: 0 auto;
        max-width: 1400px;
    }

    .pieChart{
        position: relative;
    }
    .legendLine{
        line-height: 250%;
    }

    #graphs{

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

    .expandedGraphTitle{
        font-size: 160%;
        font-weight: 900;
        position: absolute;
    }


    .data-table-th {
        background: #146D8F;
        color: #FFFFFF;
        font-weight: 600;
        font-size: 160%;
        text-align: left;
    }

    table#data-table td, th  {
        text-align: left;
        margin: 0;
        outline: 0 none;
        list-style: none;
        border-spacing: 0px;
        border-bottom: 1px solid #6C6C6C;
        font-family: 'Open Sans';
        font-size: 18px;
        font-weight: bold;
        max-height: 20px;
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
        /*display: block;*/
        display: table;
        min-width: 100%;
        max-width: 1100px;
        font-family: 'Cabin';
        font-size: 14pt;
        border: 1px solid #6C6C6C;
        margin-top: 20px;
        margin-left: 10px;
        border-spacing: 0px;
    }
    table#data-table tr:first-child td {
        height: 0;
        padding: 0;
    }
    .expandButton{
        float: right;
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
    .contractButton{
        position:absolute;
        float: right;
        border: 1px solid #5d9046;
        background: #67AA25;
        color: #fff;
        font-family: Arial, Helvetica, Sans-Serif;
        text-decoration: none;
        width: 150px;
        font-size: 14px;
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


    @charset "UTF-8";
    #sunburstplaceholder {
        font-family:  sans-serif;
        font-size: 12px;
        margin: auto;
        position: relative;
    }
    #sunburstdiv {
        font-family: sans-serif;
        font-size: 12px;
        position: relative;
    }
    #molstruct {
        position: absolute;
        width: 150px;
        height: 150px;
        left: 375px;
        top: 485px;
    }

    .toolTextAppearance {
        font: 20px serif;
        font-weight: bold;
        margin: 5px;
        padding: 10px;
        background: #eeeeee;
        border: 1px solid blue;
        -moz-border-radius: 15px;
        border-radius: 15px;
    }

    .legend {
        font: 14px sans-serif;
        font-weight: bold;
    }

    .legendExplanation {
        font: 14px sans-serif;
        font-weight: normal;
        padding-top: 10px;
        padding-bottom: 15px;
        padding-left: 12px;
        padding-right: 12px;
    }

    .legendHolder {
        border: 3px solid black;
        font: 12px sans-serif;
        font-weight: bold;
        text-align: center;
        background: #eeeeee;
        width: 160px;
    }
    .indicateZoomIn {
        cursor:crosshair;
        cursor:-webkit-zoom-in;
        cursor:-moz-zoom-in;
    }
    .indicateZoomOut {
        cursor:crosshair;
        cursor:-webkit-zoom-out;
        cursor:-moz-zoom-out;
    }
    .indicateNoZoomingPossible {
        cursor:auto;
    }





    </style>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'style.css')}" />

<script>
    var assay = {};
    var assayIndex = {};
    var linkedVizData = (function (){
        var validator = {

            // all available checks
            types: {},

            // error messages in the current
            // validation session
            messages: [],

            // current validation config
            // name: validation type
            config: {},

            // the interface method
            // `data` is key => value pairs
            validate: function (data) {

                var i, msg, type, checker, result_ok;

                // reset all messages
                this.messages = [];

                for (i in data) {

                    if (data.hasOwnProperty(i)) {

                        type = this.config[i];
                        checker = this.types[type];

                        if (!type) {
                            continue; // no need to validate
                        }
                        if (!checker) { // uh-oh
                            throw {
                                name: "ValidationError",
                                message: "No handler to validate type " + type
                            };
                        }

                        result_ok = checker.validate(data[i]);
                        if (!result_ok) {
                            msg = "Invalid value for *" + i + "*, " + checker.instructions;
                            this.messages.push(msg);
                        }
                    }
                }
                return this.hasErrors();
            },

            // helper
            hasErrors: function () {
                return this.messages.length !== 0;
            }
        };



        validator.types.isNonEmpty = {
            validate: function (value) {
                return !!value;
            },
            instructions: "the value cannot be empty"
        };

        validator.types.isNumber = {
            validate: function (value) {
                return !isNaN(Number(value));
            },
            instructions: "the value can only be a valid number, e.g. 1, 3.14 or 2010"
        };

        validator.types.isAlphaNum = {
            validate: function (value) {
                return !String(value).replace(/[a-z0-9]/ig, "").length;
            },
            instructions: "the value can only contain characters and numbers, no special symbols"
        };
        // make sure that every element inside the category group passes some basic tests
        validator.types.categoryCheck = {
            validate: function (value) {
                var returnVal = true;
                if (value.length!=4) {
                    returnVal = false;
                }
                if (returnVal){
                    for (var loopCount = 0;loopCount < value.length ; loopCount++  ) {
                        if (returnVal) { returnVal =  !isNaN(Number(value[loopCount].CatIdx));  }
                        if (returnVal) { returnVal =  !String(value[loopCount].CatName).replace(/[a-z0-9\s]/ig, "").length;  }
                        if (returnVal) { returnVal =  !String(value[loopCount].CatDescr).replace(/[a-z0-9\s]/ig, "").length;  }
                        if (returnVal) { returnVal =  !String(value[loopCount].CatIdentity).replace(/[a-z0-9_]/ig, "").length;  }
                    }
                }
                return returnVal;
            },
            instructions: "failed core category check"
        };
        // make sure that every element inside the hierarchy group passes some basic tests
        validator.types.hierarchyCheck = {
            validate: function (value) {
                var returnVal = true;
                if (value.length!=4) {
                    returnVal = false;
                }
                if (returnVal){
                    for (var loopCount = 0;loopCount < value.length ; loopCount++  ) {
                        if (returnVal) { returnVal =  !isNaN(Number(value[loopCount].CatRef));  }
                        if (returnVal) { returnVal =  ((value[loopCount].HierType==='Graph') ||
                                (value[loopCount].HierType==='Tree'));  }
                    }
                }
                return returnVal;
            },
            instructions: "failed core hierarchy check"
        };
        // make sure that every element inside the hierarchy group passes some basic tests
        validator.types.assayCheck = {
            validate: function (value) {
                var returnVal = true;

                if (returnVal){
                    for (var loopCount = 0;loopCount < value.length ; loopCount++  ) {
                        if (returnVal) { returnVal =  !isNaN(Number(value[loopCount].AssayIdx));  }
                        if (returnVal) {
                            var  currentAssayIdx = Number(value[loopCount].AssayIdx);
                            returnVal = (assayIdList.indexOf(currentAssayIdx)<0);
                            if (!returnVal) {
                                additionalErrorInfo += ('repeated assay IDX='+currentAssayIdx);
                            } else {
                                assayIdList.push(currentAssayIdx);
                            }
                        }
                        if (returnVal) { returnVal =  !String(value[loopCount].AssayName).replace(/[a-z0-9\s\'\(\)\/_:-]/ig, "").length;
                            if (!returnVal) {additionalErrorInfo += ('undesirable character='+String(value[loopCount].AssayName).replace(/[a-z0-9\s\'\(\)\/_:-]/ig, ""));}}
                        if (!returnVal) alert(value[loopCount].AssayName);
                        if (returnVal) { returnVal =  !isNaN(Number(value[loopCount].AssayId));  }
                        if (!returnVal)  {
                            break;
                        }

                    }

                }
                return returnVal;
            },
            instructions: "failed core assay check"
        };
        // make sure that every element inside the hierarchy group passes some basic tests
        validator.types.assayCrossCheck = {
            validate: function (value) {
                var returnVal = true;
                if (returnVal){
                    for (var loopCount = 0;loopCount < value.length ; loopCount++  ) {
                        if (returnVal) {
                            var assayReferenceNumber = Number(value[loopCount].AssayRef);
                            returnVal =  !isNaN(assayReferenceNumber);
                            if (assayIdList.indexOf(assayReferenceNumber) < 0) {
                                returnVal = false;
                            }
                        }
                        if (!returnVal)  {
                            break;
                        }

                    }

                }
                return returnVal;
            },
            instructions: "failed core assay check"
        };




        validator.config = {
            Category: 'categoryCheck',
            Hierarchy: 'hierarchyCheck',
            Assays: 'assayCheck',
            AssayCross: 'assayCrossCheck'
        };

        var linkedData = {},

                additionalErrorInfo = "",

                assayIdList = [],

                parseData = function (incomingData)  {
                    linkedData =  incomingData;
                },
                numberOfWidgets = function ()  {
                    return linkedData.Category.length;
                },
                validateLinkedData = function ()  {
                    var returnVal = true;
                    validator.validate(linkedData);
                    if (validator.hasErrors()) {
                        returnVal = false;
                        var errorMessageReport =  validator.messages.join("\n");
                        console.log(errorMessageReport);
                        alert (errorMessageReport) ;
                    }
                    return returnVal;
                },

                appendConditionalStatusFields = function ()  {
                    var returnVal = true;
                    // Make a way to keep track of which elements of been selected as part of the drill down, sunburst visualization
                    for (var loopCount = 0;loopCount < linkedData.Hierarchy.length ; loopCount++  ) {
                        var hierarchyPointer =  linkedData.Hierarchy[loopCount];
                        if (hierarchyPointer.HierType === 'Tree') {
                            hierarchyPointer.Structure['rootName']='/';
                            if ( (!(hierarchyPointer.Structure===undefined))&&
                                 (!(hierarchyPointer.Structure.struct===undefined))&&
                                    (hierarchyPointer.Structure.struct.length>0))
                                addAMembershipIndicator(hierarchyPointer.Structure.struct[0],loopCount);
                        } else if (hierarchyPointer.HierType === 'Graph') {
                            hierarchyPointer.Structure['rootName']='/';
                        }
                    }
                    // Make a way to keep track of which elements have been selected through the cross-linking, pie-based selection mechanism
                    for (var loopCount = 0;loopCount < linkedData.AssayCross.length ; loopCount++  ) {
                        var AssayCrossPointer =  linkedData.AssayCross[loopCount];
                        AssayCrossPointer ["AssaySelected"]  = 1;
                    }
                    return returnVal;
                },
                findAssayId = function (assayRef)  {
                    // TODO we need to really look these up, presumably when we read the data and the first.
                    return linkedData.Assays[assayRef].AssayId;
                },
                retrieveLinkedData = function ()  {
                    var developingAssayList = [];
                    var weHaveDataToDisplay = false;
                    if (!(linkedData.AssayCross ===null)) {
                        var totalNumberOfAssayCrosses = linkedData.AssayCross.length;
                        for (var i = 0; i < totalNumberOfAssayCrosses; i++){
                            if (linkedData.AssayCross[i] != null){
                                weHaveDataToDisplay = true;
                                break;
                            }
                        }
                        if (weHaveDataToDisplay)  {
                            for (var i = 0; i < totalNumberOfAssayCrosses; i++){
                                var assayCross = linkedData.AssayCross[i];
                                if (assayCross != null){
                                    developingAssayList.push({
                                        index: i,
                                        assayId: findAssayId(assayCross.AssayRef),
                                        GO_biological_process_term: assayCross.data[0],
                                        assay_format: assayCross.data[1],
                                        assay_type: assayCross.data[2],
                                        protein_target: assayCross.data[3]
                                    });
                                }
                            }
                        }
                    }
                    return  developingAssayList;
                 },


               retrieveCurrentHierarchicalData = function (datatypeIndex)  {
                   var returnValue = {}; // this will be the current node in the tree
                   var currentRootName  =  linkedData.Hierarchy[datatypeIndex].Structure.rootName;
                   var currentRootNode  =  linkedData.Hierarchy[datatypeIndex].Structure.struct;
                   returnValue =  findNodeInTreeByName (currentRootNode[0],currentRootName);
                   if (returnValue=== undefined)  {
                       alert(' problem: could not find node named '+ currentRootName+'.')
                   } else {
                       return returnValue;
                   }
               },

                // Recursive descent: We do this one at the beginning to add both a membership
                //  indicator ( which gets set on an off pending on what the user clicks ) and
                //  a tree identifier ( since we have multiple sunburst trees and we need to be
                //  able to tell them apart in the click handler )
                addAMembershipIndicator  = function (currentNode, treeIdentifier)  {
                         if (!(currentNode.children === undefined)) {
                            for (var i = 0; i < currentNode.children.length; i++) {
                                addAMembershipIndicator(currentNode.children[i],treeIdentifier);
                                currentNode["member"] = 1;
                                currentNode["treeid"] = treeIdentifier;
                            }
                        }  else {
                             currentNode["member"] = 1;
                             currentNode["treeid"] = treeIdentifier;
                         }
                    },

                // Recursive descent: set the membership of every node at or below the current node
                //  to 'value'
                setMembershipIndicatorToValue  = function (currentNode,value)  {
                    if (!(currentNode.children === undefined)) {
                        for (var i = 0; i < currentNode.children.length; i++) {
                            setMembershipIndicatorToValue(currentNode.children[i], value);
                            currentNode.member = value;
                        }
                    }  else {
                        currentNode.member = value;
                    }
                },
                findNodeInTreeByName = function (currentNode,nameWeAreLookingFor)  {
                    if (currentNode.name === nameWeAreLookingFor) {
                        return   currentNode;
                    }
                    if (!(currentNode.children === undefined)) {
                        for (var i = 0; i < currentNode.children.length; i++) {
                            var currentAttempt = findNodeInTreeByName(currentNode.children[i],nameWeAreLookingFor);
                            if ( (!( currentAttempt===undefined))&&
                                    ( currentAttempt.name === nameWeAreLookingFor) )  {
                                return  currentAttempt;
                            }
//                          setTimeout("findNodeInTreeByName("+currentNode+","+nameWeAreLookingFor+")",1);
                        }
                    }
                },
                accumulatingAssays,
                getAssaysForActivatedNodes  = function (currentNode)  {
                if (!(currentNode.children === undefined)) {
                    for (var i = 0; i < currentNode.children.length; i++) {
                        getAssaysForActivatedNodes(currentNode.children[i]);
                        if (currentNode.member === 1) {
                            if (!(currentNode.assays === undefined))  {
                                accumulatingAssays = accumulatingAssays.concat(currentNode.assays);
                            }
                        }
                    }
                }  else {
                    if (currentNode.member === 1) {
                        if (!(currentNode.assays === undefined))  {
                            accumulatingAssays = accumulatingAssays.concat(currentNode.assays);
                        }
                    }
                }
            },

                    // Recursive descent: find a node by name
       generateUniqueListOfActivatedAssays  = function (hierarchyId){
            accumulatingAssays = Array();
            getAssaysForActivatedNodes(linkedData.Hierarchy[hierarchyId].Structure.struct [0]);
           var uniqueArray = [];
            if (accumulatingAssays.length > 0) {
                accumulatingAssays.sort();
                uniqueArray = accumulatingAssays.filter(function(elem, pos) {
                    return accumulatingAssays.indexOf(elem) == pos;
                })
            }
            return uniqueArray;
        },

        adjustMembershipBasedOnSunburstClick  = function (nodeName,possibleNode,hierarchyId)   {
            // This is where we mark things as clicked!
            var retrievedNode =   findNodeInTreeByName (linkedData.Hierarchy[hierarchyId].Structure.struct [0],nodeName);
            // First set the whole tree membership to off
            setMembershipIndicatorToValue(linkedData.Hierarchy[hierarchyId].Structure.struct [0],0);
            // Now set the selected subtree to on
            setMembershipIndicatorToValue(retrievedNode,1);
            // Now we need a list of all the nodes that are turned on
            var activatedAssayList = generateUniqueListOfActivatedAssays(hierarchyId);
            assayIndex.filterFunction(function(d){return (activatedAssayList.indexOf(d)>-1);});
            dc.redrawAll();
            return activatedAssayList;
        }//,
         //       filteredHierarchyData =

        return {
            parseData:parseData,
            appendConditionalStatusFields:appendConditionalStatusFields,
            validateLinkedData:validateLinkedData,
            numberOfWidgets: numberOfWidgets,
            retrieveCurrentHierarchicalData:retrieveCurrentHierarchicalData,
            retrieveLinkedData:retrieveLinkedData,
            adjustMembershipBasedOnSunburstClick:adjustMembershipBasedOnSunburstClick
//                validate:validator.validate
        }

    }());



    var linkedVisualizationModule = (function () {
        //
        //  Variables to describe the layout of the whole page, with special attention
        //   to the unexpanded widgets
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
                innerRadiusWhenExpanded = 100, // open circle in pie

        // The expanded widgets are described below. These numbers can't be derived from anything else, because you could
        //  in principle put this display anywhere.
                displayWidgetX = 10,// expanded widget X location.
                displayWidgetY = 320, // expanded widget Y location.
                displayWidgetWidth = 1000, // expanded widget Y width.
                displayWidgetHeight = 1000, // expanded widget Y height.
                bigPie = (displayWidgetWidth / 2) - displayWidgetX, // size of pie in display mode

        //  I need to have a color for every possible pie slice. Since the color map is largely arbitrary, d3 does not
        //   seem to provide An easy way to say "please give me another color unlike when you've given me before".  Note
        //   that the colors I want are not _entirely_ arbitrary because really light colors don't seem to look good in
        //   a pie chart filled with brighter colors, so I can't simply use randomizing function with a seed
                colors = [ '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                    '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                    '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                    '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
                    '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                    '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                    '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                    '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
                    '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                    '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                    '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                    '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
                    '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                    '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                    '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                    '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'];

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

            //  dc vars
                maximumRowsInTable = 150,


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
            var rememberClickEffectors = [],
                    disableAllPieClickEffectors = function () {
                        for (var widgetCounter = 0; widgetCounter < totalWidgetNumber; widgetCounter++) {
                            rememberClickEffectors [widgetCounter] = d3.selectAll('#a' + widgetCounter + '-chart>svg>g>.pie-slice>path').on('click');
                            d3.selectAll('#a' + widgetCounter + '-chart>svg>g>.pie-slice>path').on('click', null);
                        }
                    },
                    reenableAllPieClickEffectors = function () {
                        if (rememberClickEffectors === undefined) {
                            alert(' JavaScript error--an attempt was made to reenableAllPieClickEffectors before originally disabling those ClickEffectors');
                        } else {
                            for (var widgetCounter = 0; widgetCounter < totalWidgetNumber; widgetCounter++) {
                                d3.selectAll('#a' + widgetCounter + '-chart>svg>g>.pie-slice>path').on('click', rememberClickEffectors [widgetCounter]);
                            }
                        }
                    } ,
                    eraseAnyOrphanedTooltips = function () {
                        var orphanedTooltips = d3.selectAll('.toolTextAppearance');
                        if (!(orphanedTooltips === undefined)) {
                            orphanedTooltips.style('opacity', 0);
                        }
                    },
                    cleanUpAnyGraphicsWeAreDoneWith = function () {
                        var potentialOrphanedGraphics = d3.select('div#sunburstdiv>svg');
                        if ((!(potentialOrphanedGraphics === null))&&
                            (!(potentialOrphanedGraphics[0] === null))&&
                            (!(potentialOrphanedGraphics[0][0] === null)))       {
                            potentialOrphanedGraphics.remove();
                        }

                        var potentialOrphanedLegend = d3.select('div#sunburstlegend');
                        if ((!(potentialOrphanedLegend === null))&&
                            (!(potentialOrphanedLegend[0] === null))&&
                            (!(potentialOrphanedLegend[0][0] === null))) {
                            potentialOrphanedLegend.remove();
                        }
                    },

            // convenience routine for adding a pie chart
                    addPieChart = function (crossFilterVariable, id, key, colors, localPieChartWidth, localPieChartRadius, localInnerRadius) {
                        var dimensionVariable = crossFilterVariable.dimension(function (d) {
                                    return d[key];
                                }),
                                dimensionVariableGroup = dimensionVariable.group().reduceSum(function (d) {
                                    return 1;
                                }),
                                displayDataGroup = function (d) {
                                    var returnValue = d.data.key.toString() + " (" + d.data.value + ")";
                                    returnValue = returnValue.replace("http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=", "[GO]");
                                    returnValue = returnValue.replace("http://www.ncbi.nlm.nih.gov/gquery/?term=", "[NCBI]");
                                    return returnValue;
                                };


                        return dc.pieChart("#" + id)
                                .width(localPieChartWidth)
                                .height(localPieChartWidth)
                                .transitionDuration(200)
                                .radius(localPieChartRadius)
                                .innerRadius(localInnerRadius)
                                .dimension(dimensionVariable)
                                .group(dimensionVariableGroup)
                                .colors(colors)
                                .label(displayDataGroup);
                    },


                    addDcTable = function (crossFilterVariable, id, key) {
                        var dimensionVariable = crossFilterVariable.dimension(function (d) {
                                    return d[key];
                                }),
                                dimensionVariableGroup = function (d) {
                                    return "";
                                },
                                dimensionVariableGroupTotal = function (d) {
                                    return dimensionVariable.groupAll();
                                };

                        var theTable = dc.dataTable("#" + id)
                                .dimension(dimensionVariable)
                                .group(dimensionVariableGroup)
                                .size(maximumRowsInTable)
                                .columns([
                                    function (d) {
                                        return d.GO_biological_process_term;
                                    },
                                    function (d) {
                                        return d.assay_format;
                                    },
                                    function (d) {
                                        return d.protein_target;
                                    },
                                    function (d) {
                                        return d.assay_type;
                                    }
                                ])
                                .order(d3.ascending)
                                .sortBy(function (d) {
                                    return d.GO_biological_process_term;
                                });
                        //                        This datecount  function below doesn't seem to work for me. What's wrong?
                        //                        dc.dataCount("#data-count")
                        //                                .dimension(dimensionVariable)
                        //                                .group(dimensionVariableGroupTotal);

                        return  theTable;
                    },


                    expandDataAreaForAllPieCharts = function (pieChartHolderElement) {
                        pieChartHolderElement.attr('height', displayWidgetY);
                    },


                    moveDataTableOutOfTheWay = function (dataTable) {
                        dataTable.transition()
                                .duration(500)
                                .style("top", 50 + displayWidgetY + displayWidgetHeight + "px");  // Extra spaces for 'click to contract' button
                    },

                    moveDataTableBackToItsOriginalPosition = function (dataTable) {
                        dataTable.transition()
                                .delay(1000)
                                .duration(500)
                                .style("top", "300px");  // Extra spaces for 'click to contract' button
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

                        //   Turn off the text label based on click event for background widgets
                        background1.selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'none');
                        background2.selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'none');
                        background3.selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'none');

                        //  Turn off the expander button, since the user needs to contract the expanded
                        //  widget before they try to expand the new one. It would be nice to click that
                        //  button for them, but D three does not support that sort of activation is you are
                        //  using bound data. I should probably connect to those data dynamically to get around
                        //  this problem.
                        background1.selectAll('.expandButton').style('pointer-events', 'none').style('opacity', 0.5);
                        background2.selectAll('.expandButton').style('pointer-events', 'none').style('opacity', 0.5);
                        background3.selectAll('.expandButton').style('pointer-events', 'none').style('opacity', 0.5);

                        origButton
                                .text(textForContractingButton)
                                .attr('class', 'contractButton')
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
                        background1.selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'auto');
                        background2.selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'auto');
                        background3.selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'auto');
                        //  Turn back on the expander buttons
                        //  widget before they try to expand the new one. It would be nice to click that
                        //  button for them, but D three does not support that sort of activation is you are
                        //  using bound data. I should probably connect to those data dynamically to get around
                        //  this problem.
                        background1.selectAll('.expandButton').style('pointer-events', 'auto').style('opacity', 1);
                        background2.selectAll('.expandButton').style('pointer-events', 'auto').style('opacity', 1);
                        background3.selectAll('.expandButton').style('pointer-events', 'auto').style('opacity', 1);

                        var x = origButton
                                .text(textForExpandingButton)
                                .attr('class', 'expandButton')
                                .transition()
                                .delay(1000)
                                .duration(500)
                                .style('opacity', 1);
                    },

                    expandGraphicsArea = function (graphicsTarget, graphicsTitle) {

                        var bigarc = d3.svg.arc()
                                .innerRadius(innerRadiusWhenExpanded)
                                .outerRadius(bigPie);

                        graphicsTarget
                                .attr('width', displayWidgetWidth)
                                .attr('height', displayWidgetHeight + 50); // Extra room for the 'click to contract' button

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
                                .attr("transform", "translate(368,375)");    // We need use explicit numbers here, not variables. This would be something to fix

                        graphicsTitle.attr('class', 'expandedGraphTitle');
                    },

                    contractGraphicsArea = function (graphicsTarget, graphicsTitle) {

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

                        graphicsTitle.attr('class', 'graphTitle');

                    },
                    removeTheSun = function () {
                        d3.selectAll('#suburst_container').style('pointer-events', 'none')
                                .transition()
                                .delay(0)
                                .duration(500)
                                .style('opacity', '0')
                    }

            swapAPieForTheSun = function (pieDiv, sunburstContainer, expandedButtonNum, callbackToExpandOrContractOnButtonClick) {
                pieDiv.style('pointer-events', 'none')
                        .transition()
                        .delay(1000)
                        .duration(500)
                        .style('opacity', '0');
                sunburstContainer.style('pointer-events', null)
                        .transition()
                        .delay(1000)
                        .duration(500)
                        .style('opacity', '1');
                if (linkedVizData.retrieveCurrentHierarchicalData(2).children !== undefined) {
                    createASunburst( 1000, 1000,5,1000,continuousColorScale,'div#sunburstdiv', 672376 );
                    createALegend(120, 200,100,continuousColorScale,'div#legendGoesHere',minimumValue, maximumValue);
                    d3.selectAll('#suburst_container').style('pointer-events', null);
                } else {
                    d3.select('div#sunburstdiv')
                            .append('div')
                            .attr("width", 1000)
                            .attr("height", 1000 )
                            .style("padding-top", '200px' )
                            .style("text-align", 'center' )
                            .append("h1")
                            .html("No off-embargo assay data are  available for this compound." +
                                    "Please either choose a different compound, or else come" +
                                    " back later when more assay data may have accumulated.");
                }
                d3.select('#sunburstContractor')
                    // This next step gets a little bit ugly.  What we want to do is make the
                    // Sunburst disappear, and then have the pie charts rearrange themselves like always.
                    // Unfortunately D3 does not provide a standardized way to execute a click ( thereby
                    // Initiating the associated callback ) if you have data associated with your object,
                    // Which we most certainly do. Therefore I have to mix up my own copy of the data
                    // that the callback routine for one of the pie charts would receive, and then explicitly
                    // execute the callback method. There has to be a better way to get the desired effect,
                    // though for what it's worth this approach is fully functional ( just butt-ugly, that's all)
                        .on('click', function (d) {
                            sunburstContainer.style('pointer-events', 'none')
                                    .style('opacity', '0');
                            pieDiv.style('pointer-events', null)
                                    .style('opacity', '1');
                            var molecularStructure = d3.selectAll('.molstruct')
                                    .style('opacity', '0');
                            var substituteData = {    index: expandedButtonNum,
                                orig: {
                                    coords: {
                                        x: compressedPos[expandedButtonNum].x,
                                        y: compressedPos[expandedButtonNum].y },
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
                            callbackToExpandOrContractOnButtonClick(substituteData, expandedButtonNum);
                        });
                var molecularStructure = d3.selectAll('.molstruct')
                        .transition()
                        .delay(1000)
                        .duration(500)
                        .style('opacity', '1');

            };

            // end var

            // Public API for this module
            return {
                disableAllPieClickEffectors: disableAllPieClickEffectors,
                reenableAllPieClickEffectors: reenableAllPieClickEffectors,
                eraseAnyOrphanedTooltips: eraseAnyOrphanedTooltips,
                cleanUpAnyGraphicsWeAreDoneWith: cleanUpAnyGraphicsWeAreDoneWith,
                contractGraphicsArea: contractGraphicsArea,
                expandGraphicsArea: expandGraphicsArea,
                resetOneAndResettleThree: resetOneAndResettleThree,
                spotlightOneAndBackgroundThree: spotlightOneAndBackgroundThree,
                expandDataAreaForAllPieCharts: expandDataAreaForAllPieCharts,
                moveDataTableOutOfTheWay: moveDataTableOutOfTheWay,
                moveDataTableBackToItsOriginalPosition: moveDataTableBackToItsOriginalPosition,
                addDcTable: addDcTable,
                addPieChart: addPieChart,
                swapAPieForTheSun: swapAPieForTheSun
            };
        }() );

        //
        //   Get the data and make the plots using dc.js.  Use this as an opportunity to encapsulate any methods that are
        //    used strictly locally
        //
        var generateLinkedPies = (function () {


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


            // Private method used to pull the data in from the remote site
//            var readInData = function (incoming) {
//
//                        var processedAssays = {}; // Use for de-duplication
//                        var developingAssayList = []; // This will be the return value
//
//                        incoming.forEach(function (d, i) {
//
//                            // de-duplication step
//                            if (processedAssays[d.assayId] !== true) {
//                                processedAssays[d.assayId] = true;
//
//                                developingAssayList.push({
//                                    index: i,
//                                    assayId: d.assayId,
//                                    GO_biological_process_term: d.data.GO_biological_process_term,
//                                    assay_format: d.data.assay_format,
//                                    assay_type: d.data.assay_type,
//                                    protein_target: d.data.protein_target
//                                });
//                            }
//                        });
//                        return  developingAssayList;
//                    },
            var readInData = function () {

                        return    linkedVizData.retrieveLinkedData();

            },


            // Our main button handler callback
                    handleExpandOrContractClick = function (d, x) {
                        // we better decide whether where you want to expand or contract
                        var origButton = d3.select('#expbutton' + d.index)
                                        .style('opacity', 0),
                                expandedWidget,
                                unexpandedWidget,
                                expandContractButton;

                        if (!widgetPosition.isAnyWidgetExpanded()) {
                            displayManipulator.disableAllPieClickEffectors();
                            displayManipulator.expandDataAreaForAllPieCharts(d3.select('.pieCharts'));
                            displayManipulator.moveDataTableOutOfTheWay(d3.select('#data-table'));
                            widgetPosition.expandThisWidget(d.index);
                            expandedWidget = widgetPosition.expandedWidget();
                            unexpandedWidget = widgetPosition.unexpandedWidgets();
                            displayManipulator.spotlightOneAndBackgroundThree(d, d3.select('#a' + expandedWidget),
                                    d3.select('#a' + unexpandedWidget[0]),
                                    d3.select('#a' + unexpandedWidget[1]),
                                    d3.select('#a' + unexpandedWidget[2]),
                                    origButton,
                                    expandedPos);
                            expandContractButton = d3.select('#a' + expandedWidget + '-chart>.graphTitle')
                            displayManipulator.expandGraphicsArea(d3.select('#a' + expandedWidget).select('.pieChart>svg'),
                                    expandContractButton);
                            if (expandContractButton.text() === 'Protein target') {
                                displayManipulator.swapAPieForTheSun(d3.select('#a' + expandedWidget), d3.selectAll('#suburst_container'), expandedWidget, handleExpandOrContractClick);
                            }

                        }

                        else if (widgetPosition.expandedWidget() == d.index) {
                            expandedWidget = widgetPosition.expandedWidget();
                            unexpandedWidget = widgetPosition.unexpandedWidgets();
                            displayManipulator.contractGraphicsArea(d3.select('#a' + x).select('.pieChart>svg'),
                                    d3.select('#a' + expandedWidget + '-chart>.expandedGraphTitle'));
                            displayManipulator.resetOneAndResettleThree(d, d3.select('#a' + expandedWidget),
                                    d3.select('#a' + unexpandedWidget[0]),
                                    d3.select('#a' + unexpandedWidget[1]),
                                    d3.select('#a' + unexpandedWidget[2]),
                                    origButton,
                                    expandedPos);
                            widgetPosition.unexpandAllWidgets();
                            displayManipulator.moveDataTableBackToItsOriginalPosition(d3.select('#data-table'));
                            displayManipulator.reenableAllPieClickEffectors();
                            displayManipulator.eraseAnyOrphanedTooltips();
                            displayManipulator.cleanUpAnyGraphicsWeAreDoneWith();
                        }

                    },

                    attachButtonsToThePieContainers = function (classOfPieContainers, callbackToExpandOrContractOnButtonClick, buttondata, sunburstContainer) {
                        var placeButtonsHere = d3.selectAll(classOfPieContainers)
                                .data(buttondata);

                        placeButtonsHere.append("div")
                                .text(textForExpandingButton)
                                .attr('class', 'expandButton')
                                .attr('id', function (d) {
                                    return 'expbutton' + d.index;
                                })
                                .on('click', callbackToExpandOrContractOnButtonClick);

                        // Add a button for causing misunderstood disappear
                        sunburstContainer.append("div")
                                .text(textForContractingButton)
                                .attr('class', 'contractButton')
                                .attr('id', 'sunburstContractor')
                                .data(buttondata);

                    },

                    verifyLinkedData = function () {
                        console.log('hi ho');
                        d3.json("http://localhost:8028/cow/veryCross/feedMeLinkedData", function (incomingData) {
                            // create an empty list, Just in case we get null data
                            linkedVizData.parseData(incomingData);
                            if (!linkedVizData.validateLinkedData()){
                                console.log(' we have trouble with incoming linked data');
                                throw new Exception ('bad data');
                            }  else {
                                linkedVizData.appendConditionalStatusFields()
                            }
                            presentLinkedData();
                        });// d3.json

                    },


                    presentLinkedData = function () {
                        // create an empty list, Just in case we get null data
                        var assays = [];

                        // Clean up the data.  De-dup, and assign
                        assays = readInData();

                        // Create the crossfilter for the relevant dimensions and groups.
                        assay = crossfilter(assays);

                        // Build everything were going to display
                        allDataDcTable = displayManipulator.addDcTable(assay, 'data-table', 'assayId');
                        biologicalProcessPieChart = displayManipulator.addPieChart(assay, 'a0-chart', 'GO_biological_process_term', colors, pieChartWidth, pieChartRadius, innerRadius);
                        assayFormatPieChart = displayManipulator.addPieChart(assay, 'a1-chart', 'assay_format', colors, pieChartWidth, pieChartRadius, innerRadius);
                        assayIdDimensionPieChart = displayManipulator.addPieChart(assay, 'a2-chart', 'protein_target', colors, pieChartWidth, pieChartRadius, innerRadius);
                        assayTypePieChart = displayManipulator.addPieChart(assay, 'a3-chart', 'assay_type', colors, pieChartWidth, pieChartRadius, innerRadius);

                        assayIndex = assay.dimension(function (d) {
                            return d['index'];
                        });

                        // We should be ready, display it
                        dc.renderAll();

                        // Finally, attach some data along with buttons and callbacks to the pie charts we've built
                        attachButtonsToThePieContainers('.pieChartContainer', handleExpandOrContractClick, buttondata, d3.selectAll('#suburst_container'));


                    },

            //   A fairly high-level method, used to call the other calls that get everything launched.
                    prepareThePies = function () {

                        //
                        // the following data structure defines where everything sits on the page. It is attached
                        //  to the data, and so it gets passed around to various callbacks. If you want to adjust
                        // how this page looks, You'll probably need to change the values held below in  buttondata.
                        //

                        // Retrieve the data do whatever we want to do with it
//                        d3.json("http://localhost:8028/cow/veryCross/feedMeJson", function (incomingData) {
//                          presentLinkedData = function () {
//                            // create an empty list, Just in case we get null data
//                            var assays = [];
//
//                            // Clean up the data.  De-dup, and assign
//                            assays = readInData(incomingData);
//
//                            // Create the crossfilter for the relevant dimensions and groups.
//                            assay = crossfilter(assays);
//
//                            // Build everything were going to display
//                            allDataDcTable = displayManipulator.addDcTable(assay, 'data-table', 'assayId');
//                            biologicalProcessPieChart = displayManipulator.addPieChart(assay, 'a0-chart', 'GO_biological_process_term', colors, pieChartWidth, pieChartRadius, innerRadius);
//                            assayFormatPieChart = displayManipulator.addPieChart(assay, 'a1-chart', 'assay_format', colors, pieChartWidth, pieChartRadius, innerRadius);
//                            assayIdDimensionPieChart = displayManipulator.addPieChart(assay, 'a2-chart', 'protein_target', colors, pieChartWidth, pieChartRadius, innerRadius);
//                            assayTypePieChart = displayManipulator.addPieChart(assay, 'a3-chart', 'assay_type', colors, pieChartWidth, pieChartRadius, innerRadius);
//
//                            // We should be ready, display it
//                            dc.renderAll();
//
//                            // Finally, attach some data along with buttons and callbacks to the pie charts we've built
//                            attachButtonsToThePieContainers('.pieChartContainer', handleExpandOrContractClick, buttondata, d3.selectAll('#suburst_container'));
//
//
//                        }
                    }; //prepareThePies
            return {
                verifyLinkedData: verifyLinkedData,
                prepareThePies: prepareThePies,
                presentLinkedData: presentLinkedData
            }
        }())


        // **********************************************************
        // The highest level call.  Everything starts from here.
        // **********************************************************
        generateLinkedPies.verifyLinkedData();  // generateLinkedData();verifyLinkedData
        generateLinkedPies.prepareThePies();
       // generateLinkedPies.presentLinkedData ();


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
                <span class="graphTitle">Protein target</span>
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

<table id="data-table" class="table table-hover dc-data-table"  style="position:absolute; left: 0px; top: 300px;">
    <thead>
    <tr class="header">
        <th style='width: 25%' class="data-table-th">Biological process</th>
        <th style='width: 25%' class="data-table-th">Assay format</th>
        <th style='width: 25%' class="data-table-th">Proteins target</th>
        <th style='width: 25%' class="data-table-th">Assay type</th>
    </tr>
    </thead>
</table>
<div id="widthTest" class="legendLine"></div>

<div id="suburst_container" class="container-fluid" style="position:absolute; left: 10px; top: 1000px;">
    <div class="row-fluid">
        <div class="span6">





        </div>

        <div class="span6" style="text-align: center; vertical-align: bottom;">


        </div>

    </div>


    <script>
        var createALegend = function (legendWidth, legendHeight, numberOfDivisions, colorScale, domSelector, minimumValue, maximumValue) {
            var  numberOfTics = 10,
                    dynamicRange = maximumValue - minimumValue;

            //
            // First build the core the legend, which is used no matter what the dynamic range
            //

            var rootLegendHolder = d3.select(domSelector).append("div")
                    .attr("id", "sunburstlegend")
                    .attr("class", "legendHolder")
                    .html('<br />Color assignment:<br /> x = active / <br />(active + inactive)');

            rootLegendHolder.append('hr')
                    .attr("width", '100%')
                    .attr("color", '#000');

            //
            // Define a few private methods that we will use later
            //
            var zeroDynamicRange = function (rootLegendHolder,maximumValue) {
                rootLegendHolder.append('div')
                        .attr('class', 'legendExplanation')
                        .html('Dynamic range is 0.   All arcs had value <strong>'+maximumValue+'</strong> and the color scheme is therefore constant.');
            }


            var nonzeroDynamicRange = function (numberOfTics,rootLegendHolder,legendWidth,legendHeight,colorScale,numberOfDivisions) {
                var arr = Array.apply(null, {length:numberOfDivisions + 1}).map(Number.call, Number),
                        intervals = (legendHeight) / numberOfDivisions;

                var legendHolder = rootLegendHolder.append("svg")
                        .attr("width", legendWidth)
                        .attr("height", legendHeight + 10)
                        .attr("transform", "translate(" + legendWidth / 2 + "," + (legendHeight * 0.5 + 5) + ")");

                var theLegend = legendHolder.selectAll('g')
                        .data(arr)
                        .enter()
                        .append('g')
                        .attr('class', 'legend');
                theLegend.append('rect')
                        .attr('x', legendWidth - 80)
                        .attr('y', function (d, i) {
                            return (i * intervals) + 6;
                        })
                        .attr('width', 10)
                        .attr('height', intervals)
                        .style('fill', function (d, i) {
                            return colorScale(i / numberOfDivisions);//color(d.name);
                        });

                var textSpacing = (legendHeight) / (numberOfTics * 2);
                theLegend.append('text')
                        .attr('x', legendWidth - 60)
                        .attr('y', function (d, i) {
                            return (i * 2) + 11;
                        })
                        .text(function (d, i) {
                            if ((i % textSpacing) === 0) {
                                var valToWrite = (i / numberOfDivisions);
                                return valToWrite.toString();
                            }
                            else
                                return '';
                        });
            }

            // Finally build the rest of the legends depending on whether the dynamic range
            //  is 0 or nonzero
            if (dynamicRange === 0) {
                zeroDynamicRange(rootLegendHolder,maximumValue);

            } else {
                nonzeroDynamicRange (numberOfTics,rootLegendHolder,legendWidth,legendHeight,colorScale,numberOfDivisions);

            }
        }


        var ColorManagementRoutines = function (colorScale) {

            // Safety trick for constructors
            if (!(this instanceof ColorManagementRoutines)) {
                return new ColorManagementRoutines();
            }

            // public methods
            this.colorArcFill = function (d) {
                var returnValue = new String();
                if (d.ac != undefined) {
                    var actives = parseInt(d.ac);
                    var inactives = parseInt(d.inac);
                    if ((actives + inactives) === 0) // this should never happen, but safety first!
                        return "#fff";
                    var prop = actives / (actives + inactives);
                    returnValue = colorScale(prop);
                } else {
                    returnValue = "#FF00FF";
                }
                return returnValue;
            };

            this.colorText = function (d) {
                return '#000';
            };
        };


        var TooltipHandler = function ()  {
            // Safety trick for constructors
            if (! (this instanceof TooltipHandler)){
                return new TooltipHandler ();
            }

            var tooltip = d3.select("body")
                    .append("div")
                    .style("opacity", "0")
                    .style("position", "absolute")
                    .style("z-index", "10")
                    .attr("class", "toolTextAppearance");

            this.mouseOver = function(d) {
                if (d.name != '/') {
                    tooltip.html(d.name + '<br/>' + 'active in ' + d.ac + '<br/>' + 'inactive in ' + d.inac)
                            .transition()
                            .duration(200)
                            .style("opacity", "1");
                    return;
                }
                else {
                    return tooltip.html(null).style("opacity", "0");
                }

            };
            this.mouseMove = function (d) {
                if (d.name === '/')  {
                    return tooltip.html(null).style("opacity", "0");
                }  else {
                    return tooltip .style("top", (d3.event.pageY - 10) + "px")
                            .style("left", (d3.event.pageX + 10) + "px");
                }

            };
            this.mouseOut =  function () {
                return tooltip.style("opacity", "0");
            };
        };





        function createASunburst(width, height, padding, duration, colorScale, domSelector, cid) {

            var tooltipHandler  = new TooltipHandler ();
            var colorManagementRoutines = new ColorManagementRoutines(colorScale);
            var radius = Math.min(width, height) / 2;


            var SunburstAnimation = function ()  {
                        // Safety trick for constructors
                        if (! (this instanceof SunburstAnimation)){
                            return new SunburstAnimation ();
                        }

                        // Need to keep track of how Zoomed we are
                        var currentZoomLevel = 0;
                        this.zoomLevel = function (newZoomLevel){
                            if (newZoomLevel === undefined){
                                return  currentZoomLevel;
                            }  else {
                                currentZoomLevel =  newZoomLevel;
                            }
                        }


                        this.arcTween = function (d) {
                            var my = maxY(d),
                                    xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
                                    yd = d3.interpolate(y.domain(), [d.y, my]),
                                    yr = d3.interpolate(y.range(), [d.y ? 100 : 0, radius]);
                            return function (d) {
                                return function (t) {
                                    x.domain(xd(t));
                                    y.domain(yd(t)).range(yr(t));
                                    return arc(d);
                                };
                            };
                        };

                        var maxY = function (d) {
                            return d.children ? Math.max.apply(Math, d.children.map(maxY)) : d.y + d.dy;
                        }

                        var isParentOf = function (p, c) {
                            if (p === c) return true;
                            if (p.children) {
                                return p.children.some(function (d) {
                                    return isParentOf(d, c);
                                });
                            }
                            return false;
                        };

                        this.isParentOf = isParentOf;

                    },
                    sunburstAnimation = SunburstAnimation();

            var pict = d3.select("body")
                    .append("div")
                    .style("position", "absolute")
                    .style("top", "565px")
                    .style("border", "1")
                    .style("left", "445px")
                    .attr("height", "150")
                    .attr("width", "150")
                    .style("z-index", "100")
                    .attr("class", "molstruct")
                    .style("pointer-events","none")
                    .append("img")
                    .attr("src", "/bardwebclient/chemAxon/generateStructureImageFromCID?cid="+cid+"&width=150&height=150");

            var svg = d3.select(domSelector).append("svg")
                    .attr("width", width)
                    .attr("height", height )
                    .attr("id", 'sunburst_graphics_holder')
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + (height /2 ) + ")");


            var x = d3.scale.linear()
                    .range([0, 2 * Math.PI]);

            var y = d3.scale.linear()
                    .range([0, radius]);


            var partition = d3.layout.partition()
                    .value(function (d) {
                        return d.size;
                    });

            var arc = d3.svg.arc()
                    .startAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x)));
                    })
                    .endAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx)));
                    })
                    .innerRadius(function (d) {
                        return Math.max(0, y(d.y));
                    })
                    .outerRadius(function (d) {
                        return Math.max(0, y(d.y + d.dy));
                    });

            // Method local to createASunburst to keep track of our depth
            var createIdForNode = function (incomingName) {
                var returnValue = 'null';
                var preliminaryGeneratedId = String(incomingName).replace(/\s/g,'_');
                if (preliminaryGeneratedId === '/') {
                    returnValue = 'root';
                } else {
                    returnValue = preliminaryGeneratedId;
                }
                return returnValue;
            }

            //
            // Change the cursor to zoom-in or zoom-out or nothing, all depending on the current expansion
            //  level of the sunburst.
            //
            var adjustSunburstCursor = function (d) {
                //
                // first deal with all non-root arcs
                //
                if ( !(d.parent  === undefined) &&
                        !(d.parent.name  === undefined) )  {
                    sunburstAnimation.zoomLevel(d.depth);
                    var parentName =  d.parent.name;
                    var nodeName =  d.name;
                    // reset the cursor for the last center of the sunburst, since it is no longer
                    // ready to support a zoom out.  Note that this select statement will also grab
                    // nny other stray classes indicating zoom out.
                    var previousCenterpiece = d3.select('.indicateZoomOut');
                    if (!(previousCenterpiece === undefined)){
                        previousCenterpiece.classed('indicateZoomIn', true)
                                .classed('indicateZoomOut', false)
                                .classed('indicateNoZoomingPossible', false);
                    }
                    var arcThatWasLastZoomed = d3.selectAll('.indicateNoZoomingPossible');
                    if (!(arcThatWasLastZoomed === undefined)){
                        arcThatWasLastZoomed.classed('indicateNoZoomingPossible', function(d){
                            return (d.name === "/");
                        });
                        arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                            return (!(d.name === "/"));
                        });
                    }
                    // Now deal with the parent node, which DOES need to adopt
                    // a cursor indicating that a zoom out is possible.
                    var parentNode =  d3.select('#'+createIdForNode(parentName));
                    if (sunburstAnimation.zoomLevel()>0)   {
                        parentNode.classed('indicateZoomOut', true)
                                .classed('indicateZoomIn', false)
                                .classed('indicateNoZoomingPossible', false);
                    }
                    // Take the current arc ( the one that was clicked ) and
                    // turn off any mouse handling at all, since After clicking an arc
                    // it becomes fully expanded, and there is no purpose to clicking it again.
                    var currentNode =  d3.select('#'+createIdForNode(nodeName));
                    currentNode.classed('indicateZoomOut', false)
                            .classed('indicateZoomIn', false)
                            .classed('indicateNoZoomingPossible', true);

                }  // next deal with the root arc, in case the user clicked it.
                else if ( !(d  === undefined) &&
                        !(d.name  === undefined) ) {  // Root node clicked -- reset mouse ptr
                    sunburstAnimation.zoomLevel(d.depth);
                    var nodeName =  d.name;
                    // whatever had no cursor needs to be turned on
                    var arcThatWasLastZoomed = d3.selectAll('.indicateNoZoomingPossible');
                    if (!(arcThatWasLastZoomed === undefined)){
                        arcThatWasLastZoomed.classed('indicateNoZoomingPossible', function(d){
                            return (d.name === "/");
                        });
                        arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                            return (!(d.name === "/"));
                        });
                    }
                    // take the current arc and turn the cursor off
                    var currentNode =  d3.select('#'+createIdForNode(nodeName));
                    currentNode.classed('indicateZoomOut', false)
                            .classed('indicateZoomIn', false)
                            .classed('indicateNoZoomingPossible', true);
                }
            }


            var path = svg.datum(linkedVizData.retrieveCurrentHierarchicalData(2)).selectAll("path")
                    .data(partition.nodes)
                    .enter().append("path")
                    .attr("d", arc)
                    .attr("id", function (d) {
                        return createIdForNode(d.name);
                    })
                    .classed('indicateZoomIn', function(d) { return (d.depth || d.name!='/');} )
                    .classed('indicateNoZoomingPossible', function(d) { return (!(d.depth || d.name!='/'));} )
                    .style("stroke", "#fff")
                    .style("fill", function (d) {
                        return colorManagementRoutines.colorArcFill(d);
                    })
                    .on("click", click)
                    .on("mouseover", tooltipHandler.mouseOver)
                    .on("mousemove", tooltipHandler.mouseMove)
                    .on("mouseout",tooltipHandler.mouseOut );


            var text = svg.datum(linkedVizData.retrieveCurrentHierarchicalData(2)).selectAll("text").data(partition.nodes);

            // Interpolate the scales!
            function click(d) {
                adjustSunburstCursor(d);
                linkedVizData.adjustMembershipBasedOnSunburstClick (d.name, d, d.treeid);
                path.transition()
                        .duration(duration)
                        .attrTween("d", sunburstAnimation.arcTween(d));

                // Somewhat of a hack as we rely on arcTween updating the scales.
                text.style("visibility", function (e) {
                    return sunburstAnimation.isParentOf(d, e) ? null : d3.select(this).style("visibility");
                })
                        .transition()
                        .duration(duration)
                        .attrTween("text-anchor", function (d) {
                            return function () {
                                return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                            };
                        })
                        .attrTween("transform", function (d) {
                            var multiline = (d.name || "").split(" ").length > 1;
                            return function () {
                                var angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                        rotate = angle + (multiline ? -.5 : 0);
                                return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                            };
                        })
                        .style("fill-opacity", function (e) {
                            return sunburstAnimation.isParentOf(d, e) ? 1 : 1e-6;
                        })
                        .each("end", function (e) {
                            d3.select(this).style("visibility", sunburstAnimation.isParentOf(d, e) ? null : "hidden");
                        });
            }


            var textEnter = text.enter().append("svg:text")
                    .style("fill-opacity", 1)
                    .style("pointer-events", "none")
                    .style("fill", function (d) {
                        return  colorManagementRoutines.colorText(d);
                    })
                    .attr("text-anchor", function (d) {
                        return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                    })
                    .attr("dy", ".2em")
                    .attr("transform", function (d) {
                        var multiline = (d.name || "").split(" ").length > 1,
                                angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                rotate = angle + (multiline ? -.5 : 0);
                        return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                    })
                    .on("click", click);


            textEnter.append("tspan")
                    .attr("x", 0)
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[0] : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[1] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[2] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[3] || "" : "";
                    });

            // Need to make some adjustments to fit the Sunburst in with the linked pies
            var adjustSunburstToFitInWithThePies = (function () {
                var sunburstContainer = d3.selectAll('#suburst_container')
                        .style('left', '-10px')
                        .style('top', '320px')
                        .style('pointer-events', 'none')
                        .style('opacity', '0');
                var molecularStructure = d3.selectAll('.molstruct')
                        .style('top', '765px')
                        .style('opacity', '0');
            })();
        }




    </script>


    <script>
//        var $data = [{"name":"/", "ac":"0", "inac":"0", "children": [
//                     ...
    var minimumValue=0;
    var maximumValue=1;

    var continuousColorScale = d3.scale.linear()
            .domain([0, 1])
            .interpolate(d3.interpolateRgb)
            .range(["#deffd9", "#74c476"]);

    </script>


    <div class="row-fluid">
        <div class="span9 pull-left">

            <div id="sunburstdiv">

                <div id="sunburstdiv_empty">

                </div>
            </div>

        </div>

        <div class="span3" style="padding-top: 50px;  height: 600px;">
            <div style="float:right;">
                <div id="legendGoesHere"></div>

            </div>

            <div style="text-align: center; vertical-align: bottom;">

                <select id="coloringOptions" style="visibility: hidden">
                    <option value="1"
                    >Color by activity</option>
                    <option value="2"
                    >Split classes by activity</option>
                    <option value="3" >Color by class</option>
                </select>
                <div  style="padding-top: 320px;"></div>
                <select id="activity" style="visibility: hidden">
                    <option value="1" >Active only</option>
                    <option value="2" >Inactive only</option>
                    <option value="3"
                            selected>Active and Inactive</option>
                </select>

            </div>

        </div>
    </div>
</div>

</body>
</html>