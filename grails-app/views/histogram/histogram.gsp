<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>BARD : Experiment Result : 3325</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    %{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dc.css')}" />--}%
    %{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'style.css')}" />--}%
    <script src="../js/d3.min.js"></script>
    <script src="../js/dc.js"></script>
    <script src="../js/crossfilter.min.js"></script>





    %{--<script src="/bardwebclient/static/plugins/jquery-1.7.1/js/jquery/jquery-1.7.1.min.js" type="text/javascript" ></script>--}%
    %{--<link href="/bardwebclient/static/css/flick/jquery-ui-1.8.20.custom.css" type="text/css" rel="stylesheet" media="screen, projection" />--}%
    %{--<script src="/bardwebclient/static/plugins/jquery-ui-1.8.15/jquery-ui/js/jquery-ui-1.8.15.custom.min.js" type="text/javascript" ></script>--}%
    %{--<link href="/bardwebclient/static/bundle-bundle_core_head.css" type="text/css" rel="stylesheet" media="screen, projection" />--}%
    %{--<link href="/bardwebclient/static/bundle-fixtaglib_head.css" type="text/css" rel="stylesheet" media="screen, projection" />--}%
    %{--<link href="/bardwebclient/static/bundle-bundle_bootstrap_head.css" type="text/css" rel="stylesheet" media="screen, projection" />--}%
    %{--<link href="/bardwebclient/static/css/cbas.css" type="text/css" rel="stylesheet" media="screen, projection" />--}%
    %{--<script src="/bardwebclient/static/bundle-bundle_cart_head.js" type="text/javascript" ></script>--}%
    %{--<link href="/bardwebclient/static/bundle-bundle_cart_head.css" type="text/css" rel="stylesheet" media="screen, projection" />--}%


</head>

<body>
<div class="container-fluid">

<div class="row-fluid header">

<div id="histogramHere"></div>


<div class="span6">


    <script>
       function  drawHistogram(domMarker,jsondata){
            var margin = {top: 30, right: 20, bottom: 30, left: 50},
            width = 600 - margin.left - margin.right,
            height = 270 - margin.top - margin.bottom;

           var w = 500;
           var h = 100;
           var barPadding = 1;

           var dataset = [ 5, 10, 13, 19, 21, 25, 22, 18, 15, 13,
               11, 12, 15, 20, 18, 17, 16, 18, 23, 25 ];


        var xScale = d3.scale.ordinal()
                .domain([jsondata[0].min,jsondata[0].max])
                .range(0,width);
//                .rangeRoundBands([0, width]);
        var yScale = d3.scale.linear()
                .domain([0, 83196])
                .range([0, height]);


           //Create SVG element
           var svg = d3.select("#histogramHere")
                   .append("svg")
                   .attr("width", width)
                   .attr("height", height);

           svg.selectAll("rect")
                   .data(jsondata[0].histogram)
                   .enter()
                   .append("rect")
                   .attr("x", function(d, i) {
                       return i * (width / jsondata[0].histogram.length);
                   })
                   .attr("y",function(d){
                       return height-yScale(d[0]);
                   })
                   .attr("width", (width / jsondata[0].histogram.length)-1)
                   .attr("height", function(d){
                       return yScale(d[0]);
                   });


       }







        //        var margin = {top: 30, right: 20, bottom: 30, left: 50},
//                width = 600 - margin.left - margin.right,
//                height = 270 - margin.top - margin.bottom;
//        var parseDate = d3.time.format("%d-%b-%y").parse;
//        var jsondata;
//
//        function drawHistogram(divName,dataObject) {
//
//            var histogram = d3.layout.histogram() (pos_data);
//            var x = d3.scale().ordinal()
//                .domain(histogram.map(function(d) { return d.x; }))
//                .rangeRoundBands([0, width]);
//        var y = d3.scale.linear().domain([0, d3.max(histogram.map(function(d) { return d.y; }))])
//                .range([0, height]);












//        var xAxis = d3.svg.axis()
//                .scale(x)
//                .orient("bottom")
//                .ticks(5);
//        var yAxis = d3.svg.axis()
//                .scale(y)
//                .orient("left")
//                .ticks(5);
//        var area = d3.svg.area()
//                .x(function(d) { return x(d.date); })
//                .y0(height)
//                .y1(function(d) { return y(d.close); });
//        var valueline = d3.svg.line()
//                .x(function (d) {
//                    return x(d.date);
//                })
//                .y(function (d) {
//                    return y(d.close);
//                });





//        var svg = d3.select("body")
//                .append("svg")
//                .attr("width", width + margin.left + margin.right)
//                .attr("height", height + margin.top + margin.bottom)
//                .append("g")
//                .attr("transform", "translate(" + margin.left + "," + margin.top +
//                ")");
//        // function for the x grid lines
//        function make_x_axis() {
//            return d3.svg.axis()
//                    .scale(x)
//                    .orient("bottom")
//                    .ticks(5)
//        }
//        // function for the y grid lines
//        function make_y_axis() {
//            return d3.svg.axis()
//                    .scale(y)
//                    .orient("left")
//                    .ticks(5)
//        }




//            console.log(jsondata);
//        }
//        function load(){ // <-E
            d3.json("http://localhost:8028/cow/histogram/feedMeJson", function(error,dataFromServer) {
                if (error) {
                    return console.log(error);
                }
                jsondata = dataFromServer;
            drawHistogram(d3.select('#histogramHere'),jsondata);
        });
//        }
//        window.onload=load();


//        // Get the data
//        d3.tsv("http://localhost:8028/cow/histogram/feedMeJson", function (error, data) {
//            data.forEach(function (d) {
//                d.date = parseDate(d.date);
//                d.close = +d.close;
//            });
//// Scale the range of the data
//            x.domain(d3.extent(data, function (d) {
//                return d.date;
//            }));
//            y.domain([0, d3.max(data, function (d) {
//                return d.close;
//            })]);
//            svg.append("path")
//                    .datum(data)
//                    .attr("class", "area")
//                    .attr("d", area);
//            // Draw the x Grid lines
//            svg.append("g")
//                    .attr("class", "grid")
//                    .attr("transform", "translate(0," + height + ")")
//                    .call(make_x_axis()
//                    .tickSize(-height, 0, 0)
//                    .tickFormat("")
//            )
//            // Draw the y Grid lines
//            svg.append("g")
//                    .attr("class", "grid")
//                    .call(make_y_axis()
//                    .tickSize(-width, 0, 0)
//                    .tickFormat("")
//            )
//            svg.append("path") // Add the valueline path.
//                    .attr("d", valueline(data));
//            svg.append("g") // Add the X Axis
//                    .attr("class", "x axis")
//                    .attr("transform", "translate(0," + height + ")")
//                    .call(xAxis);
//            svg.append("g") // Add the Y Axis
//                    .attr("class", "y axis")
//                    .call(yAxis);
//            svg.append("text")
//                    .attr("transform", "rotate(-90)")
//                    .attr("y", 6)
//                    .attr("x", margin.top - (height / 2))
//                    .attr("dy", ".71em")
//                    .style("text-anchor", "end")
//                    .attr("class", "shadow")
//                    .text("Price ($)");
//// Add the text label for the Y axis
//            svg.append("text")
//                    .attr("transform", "rotate(-90)")
//                    .attr("y", 6)
//                    .attr("x", margin.top - (height / 2))
//                    .attr("dy", ".71em")
//                    .style("text-anchor", "end")
//                    .text("Price ($)");
//// Add the title
//            svg.append("text")
//                    .attr("x", (width / 2))
//                    .attr("y", 0 - (margin.top / 2))
//                    .attr("text-anchor", "middle")
//                    .style("font-size", "16px")
//                    .style("text-decoration", "underline")
//                    .text("Price vs Date Graph");
//        });
    </script>



    <div class="modal hide" id="idModalDiv">
        <div class="modal-header">
            <a class="close" data-dismiss="modal">×</a>

            <h3>Enter a Comma separated list of IDs</h3>
        </div>

        <div class="modal-body">
            <textarea class="field span12" id="idSearchString" name="idSearchString" rows="15"></textarea>
        </div>

        <div class="modal-footer">
        </div>

    </div>

</div>

<div class="span3">
    <div class="center-aligned">
        <div id="login-form">

            <form action="/bardwebclient/bardLogout/index" method="post" name="logoutForm" id="logoutForm" >
                Logged in as: <span
                    style="font-weight: bold;">balexand</span>&nbsp;&nbsp;
                <button type="submit" class="btn btn-mini" id="logoutButton">Logout</button>
            </form>


        </div>

    </div>


    <div class="well well-small">

        <div id="summaryView">
            <div class="row-fluid">
                <div class="span12 center-aligned">
                    <h3>Query Cart</h3>
                    <a class="trigger btn btn-mini" href="#">View/edit</a>
                    <div class="dropdown">
                        <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" role="button" data-target="#">
                            Visualize <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu pull-right" role="menu">
                            <li><a href="/bardwebclient/molSpreadSheet/index">Molecular Spreadsheet</a></li>
                            <li>
                                <a href="/bardwebclient/queryCart/toDesktopClient" target="_blank">Desktop Client</a></li>

                        </ul>
                    </div>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <ul class="unstyled horizontal-list">

                        <li>Empty</li>




                    </ul>
                </div>
            </div>
        </div>


    </div>

    <div class="panel" style="z-index: 10">
        <a class="trigger" href="#">Click to hide query cart</a>

        <table class="QcartAppearance" id="detailView">

            <tbody id="sarCartRefill">
            <tr>
                <td>

                    <h5><span class="qcartTitle">Query Cart -</span> <span class="qcartResults">Selected Results</span></h5>
                    <h6>0 results selected</h6>
                    <h5>COMPOUNDS</h5>

                    <table class="QcartSubsection">



                    </table>

                </td>
            </tr>
            <tr>
                <td>

                    <h5>ASSAY DEFINITIONS</h5>
                    <table>

                    </table>

                </td>
            </tr>
            <tr>
                <td>


                    <h5>PROJECTS</h5>
                    <table>

                    </table>

                </td>
            </tr>
            <tr>
                <td>


                    <br/>
                    <div class="leftofline">
                        <div class="btn-group" style="vertical-align: bottom;">
                            <a class="btn dropdown-toggle" data-toggle="dropdown"  role="button" data-target="#">
                                <i class="icon-eye-open"></i> Visualize
                                <span class="caret"></span>
                            </a>

                        </div>
                    </div>

                    <div class="rightofline">

                        <a class="removeAllFromCart btn" role="button" href="#" >
                            Clear all
                        </a>

                    </div>

                </td>
            </tr>
            </tbody>
        </table>


    </div>

</div>

</div>




<div class="row-fluid" id="showExperimentDiv">

<div class="span3">

    <div class="facets">
        <form action="/bardwebclient/?id=ExperimentFacetForm" method="post" name="ExperimentFacetForm" id="ExperimentFacetForm" >

            <p>Total: 200</p>

            <input type="submit" name="applyFilters" value="Apply Filters" id="ExperimentFacetForm_Button" class="btn btn-small" />
            <input type="button" class="btn btn-small" id="ExperimentFacetForm_ResetButton" value="Clear All Filters"
                   name="resetFilters">

            <h2>Options</h2>
            <input type="hidden" name="searchString" value="73" id="searchString" />







            <fieldset>
                <h3>Plot axis</h3>




                <label class="checkbox">

                    <input type="hidden" name="_filters[0].filterValue" /><input type="checkbox" name="filters[0].filterValue" checked="checked" value="Normalize Y-Axis" class="ExperimentFacetForm_Chk" id="filters[0].filterValue"  /> Normalize Y-Axis
                </label>
                <input type="hidden" name="filters[0].filterName" value="plot_axis" id="filters[0].filterName" />








            </fieldset>


            <fieldset>
                <h3>Activity outcome</h3>




                <label class="checkbox">

                    <input type="hidden" name="_filters[1].filterValue" /><input type="checkbox" name="filters[1].filterValue" checked="checked" value="Active Compounds" class="ExperimentFacetForm_Chk" id="filters[1].filterValue"  /> Active Compounds (200)
                </label>
                <input type="hidden" name="filters[1].filterName" value="activity_outcome" id="filters[1].filterName" />








            </fieldset>

            <input type="hidden" name="formName" value="ExperimentFacetForm" id="formName" />
        </form>
    </div>

</div>
<input type="hidden" name="experimentId" id="experimentId" value="102"/>

<div class="span9">
<div id="experimentalResults">

<p>
    <b>Title: High-throughput multiplex screening for ABC transporter inhibitors: specifically ABCG2 screen, ABCB1 counter-screen</b>
</p>


<p>
    <b>Assay ID :

        <a href="/bardwebclient/bardWebInterface/showAssay/84?searchString=73">
            3330
        </a>

    </b>
    <b>Confidence Level: 1</b>
</p>

<div class="row-fluid">

<input type="hidden" name="paginationUrl" id="paginationUrl" value=""/>

<div class="pagination offset3">
    <div class="pagination"><ul><li class="prev"><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=180&amp;max=10">Previous</a>
    </li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=0&amp;max=10"
            class="step">1</a></li><li class="disabled"><span>...</span></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=100&amp;max=10"
            class="step">11</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=110&amp;max=10"
            class="step">12</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=120&amp;max=10"
            class="step">13</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=130&amp;max=10"
            class="step">14</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=140&amp;max=10"
            class="step">15</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=150&amp;max=10"
            class="step">16</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=160&amp;max=10"
            class="step">17</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=170&amp;max=10"
            class="step">18</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=180&amp;max=10"
            class="step">19</a></li><li class="active"><span>20</span></li><li class="next disabled"><span>Next</span>
    </li></ul></div>
</div>

<div id="resultData">

<div class="row-fluid">

<table class="cbasOutterTable">
<thead>
<tr align="center">

    <th>
        SID
    </th>

    <th>
        CID
    </th>

    <th>
        Structure
    </th>

    <th>
        Outcome
    </th>

    <th>
        Results
    </th>

    <th>
        Experiment Descriptors
    </th>

</tr>
</thead>

<tbody>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24812948">

          PubChem

            24812948
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=16193843">

            16193843
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct

            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="CC(C)CSC1=NSC2=NC(=O)\C(=C/C3=COC4=CC=CC=C4C3=O)C(=N)N12"
                            rel="tooltip">Smiles : CC(C)CSC1=NSC2=NC(=O)\C(=C/C3 ... More</li>


                        <li><a href="#" data-detail-id="sid_24812948" class="analogs"
                               data-structure-search-params="Similarity:16193843">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=16193843&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="HMS2612K18"
                               data-cart-id="16193843"
                               data-cart-type="Compound"
                               data-cart-smiles="CC(C)CSC1=NSC2=NC(=O)\C(=C/C3=COC4=CC=CC=C4C3=O)C(=N)N12"
                               data-cart-numActive="5"
                               data-cart-numAssays="84">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/16193843">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>261.07</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.814</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24813276">

           PubChem

            24813276
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=16193971">

            16193971
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

           struct

            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="O=C(\C=C\C1=CC=C(C=C1)N2CCC(=N2)C3=CC=CC=C3)C4=CC=CC=C4"
                            rel="tooltip">Smiles : O=C(\C=C\C1=CC=C(C=C1)N2CCC(= ... More</li>


                        <li><a href="#" data-detail-id="sid_24813276" class="analogs"
                               data-structure-search-params="Similarity:16193971">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=16193971&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="HMS2623O21"
                               data-cart-id="16193971"
                               data-cart-type="Compound"
                               data-cart-smiles="O=C(\C=C\C1=CC=C(C=C1)N2CCC(=N2)C3=CC=CC=C3)C4=CC=CC=C4"
                               data-cart-numActive="6"
                               data-cart-numAssays="76">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/16193971">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>81.24</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.674</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24818202">

            png

            24818202
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=3516975">

            3516975
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="CC1=NC(=NC(=C1)C2=C(Br)C=CS2)N3C=CC=C3"
                            rel="tooltip">Smiles : CC1=NC(=NC(=C1)C2=C(Br)C=CS2) ... More</li>


                        <li><a href="#" data-detail-id="sid_24818202" class="analogs"
                               data-structure-search-params="Similarity:3516975">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=3516975&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="HMS2707O03"
                               data-cart-id="3516975"
                               data-cart-type="Compound"
                               data-cart-smiles="CC1=NC(=NC(=C1)C2=C(Br)C=CS2)N3C=CC=C3"
                               data-cart-numActive="7"
                               data-cart-numAssays="83">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/3516975">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>92.34</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.654</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24820374">

            png

            24820374
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=5524030">

            5524030
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="COC(=O)C1=C(OC(=O)C(NC(=O)C2=CC(Cl)=CC=C2)=C1)\C=C\NC3=CC(C)=CC(C)=C3"
                            rel="tooltip">Smiles : COC(=O)C1=C(OC(=O)C(NC(=O)C2= ... More</li>


                        <li><a href="#" data-detail-id="sid_24820374" class="analogs"
                               data-structure-search-params="Similarity:5524030">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=5524030&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="MolPort-002-851-485"
                               data-cart-id="5524030"
                               data-cart-type="Compound"
                               data-cart-smiles="COC(=O)C1=C(OC(=O)C(NC(=O)C2=CC(Cl)=CC=C2)=C1)\C=C\NC3=CC(C)=CC(C)=C3"
                               data-cart-numActive="6"
                               data-cart-numAssays="78">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/5524030">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>135.09</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.694</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24821031">

            png

            24821031
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=5524036">

            5524036
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="COC(=O)C1=C(OC(=O)C(NC(=O)C2=CC=CC=C2)=C1)\C=C\NC3=CC=C(OC4=CC=CC=C4)C=C3"
                            rel="tooltip">Smiles : COC(=O)C1=C(OC(=O)C(NC(=O)C2= ... More</li>


                        <li><a href="#" data-detail-id="sid_24821031" class="analogs"
                               data-structure-search-params="Similarity:5524036">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=5524036&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="HMS2646C04"
                               data-cart-id="5524036"
                               data-cart-type="Compound"
                               data-cart-smiles="COC(=O)C1=C(OC(=O)C(NC(=O)C2=CC=CC=C2)=C1)\C=C\NC3=CC=C(OC4=CC=CC=C4)C=C3"
                               data-cart-numActive="17"
                               data-cart-numAssays="84">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/5524036">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>116.39</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.734</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24822843">


            24822843
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=16195322">

            16195322
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

           struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="[I-].CC[N+]1=C(\C=C\C2=CNC3=CC=CC=C23)C=CC4=C1C=CC(C)=C4"
                            rel="tooltip">Smiles : [I-].CC[N+]1=C(\C=C\C2=CNC3=C ... More</li>


                        <li><a href="#" data-detail-id="sid_24822843" class="analogs"
                               data-structure-search-params="Similarity:16195322">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=16195322&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="1-ethyl-2-[(E)-2-(1H-indol-3-yl)ethenyl]-6-methylquinolin-1-ium;iodide"
                               data-cart-id="16195322"
                               data-cart-type="Compound"
                               data-cart-smiles="[I-].CC[N+]1=C(\C=C\C2=CNC3=CC=CC=C23)C=CC4=C1C=CC(C)=C4"
                               data-cart-numActive="8"
                               data-cart-numAssays="59">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/16195322">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>83.98</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.72</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24823466">

            24823466
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=16001802">

            16001802
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="CC(=O)NC1=CC=C(N\C=C2/C(=O)C(=CC3=CC=CC=C23)C(=O)NC4=CC=CC=C4)C=C1"
                            rel="tooltip">Smiles : CC(=O)NC1=CC=C(N\C=C2/C(=O)C( ... More</li>


                        <li><a href="#" data-detail-id="sid_24823466" class="analogs"
                               data-structure-search-params="Similarity:16001802">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=16001802&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="HMS2599L19"
                               data-cart-id="16001802"
                               data-cart-type="Compound"
                               data-cart-smiles="CC(=O)NC1=CC=C(N\C=C2/C(=O)C(=CC3=CC=CC=C23)C(=O)NC4=CC=CC=C4)C=C1"
                               data-cart-numActive="6"
                               data-cart-numAssays="78">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/16001802">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>103.2</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.7</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24826438">



            24826438
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=4406525">

            4406525
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="CN1CCN(CC1)C2=CC3=CC(CCC3CC2)=C(C#N)C#N"
                            rel="tooltip">Smiles : CN1CCN(CC1)C2=CC3=CC(CCC3CC2) ... More</li>


                        <li><a href="#" data-detail-id="sid_24826438" class="analogs"
                               data-structure-search-params="Similarity:4406525">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=4406525&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="T0503-3329"
                               data-cart-id="4406525"
                               data-cart-type="Compound"
                               data-cart-smiles="CN1CCN(CC1)C2=CC3=CC(CCC3CC2)=C(C#N)C#N"
                               data-cart-numActive="13"
                               data-cart-numAssays="79">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/4406525">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>84.96</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.783</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24833190">


            24833190
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=2421787">

            2421787
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li>Smiles : CC(C)CCOC1=CC=CC(OCC(O)=O)=C1</li>


                        <li><a href="#" data-detail-id="sid_24833190" class="analogs"
                               data-structure-search-params="Similarity:2421787">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=2421787&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="T0515-7410"
                               data-cart-id="2421787"
                               data-cart-type="Compound"
                               data-cart-smiles="CC(C)CCOC1=CC=CC(OCC(O)=O)=C1"
                               data-cart-numActive="6"
                               data-cart-numAssays="87">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/2421787">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>107.54</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.826</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

<tr class="cbasOutterTableRow" align="center">

    <td class="cbasOutterTableCell">
        <a href="http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid=24841258">


            24841258
        </a>
    </td>




    <td class="cbasOutterTableCell">
        <a href="/bardwebclient/bardWebInterface/showCompound?cid=2431643">

            2431643
        </a>
    </td>




    <td class="cbasOutterTableCell">

        <div class="compound-info">

            struct
            <div class="compound-info-dropdown">
                <span class="btn-group">
                    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><i
                            class="icon-info-sign"></i> <span
                            class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">

                        <li title="CC(C)C(=O)NC1=CC(C)=NN1C2=NC3=CC=CC=C3S2"
                            rel="tooltip">Smiles : CC(C)C(=O)NC1=CC(C)=NN1C2=NC3 ... More</li>


                        <li><a href="#" data-detail-id="sid_24841258" class="analogs"
                               data-structure-search-params="Similarity:2431643">Search For Analogs</a>
                            &nbsp; &nbsp;Threshold (0-100%) : <input type="number" min="0" max="100" step="1"
                                                                     name="cutoff"
                                                                     value="90" size="4" id="cutoff"/>
                        </li>
                        <li>
                            <a href="/bardwebclient/molSpreadSheet/showExperimentDetails?cid=2431643&amp;transpose=true">Show Experimental Details</a>
                        </li>

                        <li>
                            <a href="javascript:void(0);" name="saveToCartLink" class="addToCartLink"
                               data-cart-name="HMS2691A03"
                               data-cart-id="2431643"
                               data-cart-type="Compound"
                               data-cart-smiles="CC(C)C(=O)NC1=CC(C)=NN1C2=NC3=CC=CC=C3S2"
                               data-cart-numActive="4"
                               data-cart-numAssays="89">Save to Cart For Analysis</a>
                        </li>

                        <li>
                            <a href="/bardwebclient/bardWebInterface/showCompoundBioActivitySummary/2431643">Bio-activity Summary</a>
                        </li>
                    </ul>
                </span>
            </div>
        </div>

    </td>




    <td class="cbasOutterTableCell">
        <p>Active</p>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <table class="">
                            <tr align="center">
                                <td class='lineSpacing'>
                                    <p><b><small>percent inhibition</small>

                                        <a href="/bardwebclient/dictionaryTerms/#998" target="datadictionary">
                                            <i class="icon-question-sign"></i>
                                        </a>

                                    </b></p>

                                    <p><small>80.96</small></p>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>




    <td class="cbasOutterTableCell">

        <table>
            <tbody>

            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>PubChem outcome : Active</small></b></p>

                    </div>
                </td>

            </tr>





            <tr align="center">

                <td>
                    <div>

                        <p class="lineSpacing"><b><small>Z-score : 0.64</small></b></p>

                    </div>
                </td>

            </tr>

            </tbody>
        </table>
    </td>

</tr>

</tbody>
</table>
</div>

</div>

<div class="pagination offset3">
    <div class="pagination"><ul><li class="prev"><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=180&amp;max=10">Previous</a>
    </li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=0&amp;max=10"
            class="step">1</a></li><li class="disabled"><span>...</span></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=100&amp;max=10"
            class="step">11</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=110&amp;max=10"
            class="step">12</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=120&amp;max=10"
            class="step">13</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=130&amp;max=10"
            class="step">14</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=140&amp;max=10"
            class="step">15</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=150&amp;max=10"
            class="step">16</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=160&amp;max=10"
            class="step">17</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=170&amp;max=10"
            class="step">18</a></li><li><a
            href="/bardwebclient/bardWebInterface/showExperiment/102?normalizeYAxis=Y_NORM_AXIS&amp;offset=180&amp;max=10"
            class="step">19</a></li><li class="active"><span>20</span></li><li class="next disabled"><span>Next</span>
    </li></ul></div>
</div>

</div>

</div>
</div>
</div>


<div class="row-fluid bard-footer">
    <div class="span5">
        <div>
            <ul class="horizontal-block-list">
                <li><a href="http://bard.nih.gov">About</a></li>
                <li><a href="http://bard.nih.gov">Help</a></li>
                <li><a href="http://bard.nih.gov">Technology</a></li>
            </ul>
        </div>
    </div>

    <div class="span5 bard-footer-versioninfo muted">
        <div>
            <b>Version:</b> 0.1 <b>branch:</b> iteration.025 <b>revision:</b> 3958e5742bec22768032549e6d5e8865fc2e399e
        </div>
    </div>


</div>

</div>


</body>
</html>