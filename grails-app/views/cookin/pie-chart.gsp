<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Pie Chart</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <style>
        .triangle {
            stroke
        }
    </style>
</head>

<body>

<script type="text/javascript">
    function pieChart() {
        var _chart = {};

        var _width = 1000, _height = 1000,
                _data = [],
                _colors = d3.scale.category20(),
                _svg,
                _bodyG,
                _pieG,
                _radius = 200,
                _innerRadius = 100;

        _chart.render = function () {
            if (!_svg) {
                _svg = d3.select("body").append("svg")
                        .attr("height", _height)
                        .attr("width", _width);
            }

            renderBody(_svg);
        };

        function renderBody(svg) {
            if (!_bodyG)
                _bodyG = svg.append("g")
                        .attr("class", "body");

            renderPie();
        }

        function renderPie() {
            var pie = d3.layout.pie() // <-A
                    .sort(function (d) {
                        return d.value;
                    })
                    .value(function (d) {
                        return d.value;
                    });

            var arc = d3.svg.arc()
                    .outerRadius(_radius)
                    .innerRadius(_innerRadius);

            if (!_pieG)
                _pieG = _bodyG.append("g")
                        .attr("class", "pie")
                        .attr("transform", "translate("
                                + _radius
                                + ","
                                + _radius + ")");

            renderSlices(pie, arc);

            renderLabels(pie, arc);
        }

        function renderSlices(pie, arc) {
            var slices = _pieG.selectAll("path.arc")
                    .data(pie(_data)); // <-B

            slices.enter()
                    .append("path")
                    .attr("class", "arc")
                    .attr("fill", function (d, i) {
                        return _colors(i);
                    });

            slices.transition()
                    .attrTween("d", function (d) {
                        var currentArc = this.__current__; // <-C

                        if (!currentArc)
                            currentArc = {startAngle: 0,
                                endAngle: 0};
                        console.log("startAngle=" + currentArc.startAngle + ", endAngle=" + currentArc.endAngle + ".")
                        var interpolate = d3.interpolate(
                                currentArc, d);

                        this.__current__ = interpolate(1);//<-D

                        return function (t) {
                            return arc(interpolate(t));
                        };
                    });
        }

        function renderLabels(pie, arc) {
            var labels = _pieG.selectAll("text.label")
                    .data(pie(_data)); // <-E

            labels.enter()
                    .append("text")
                    .attr("class", "label");

            labels.transition()
                    .attr("transform", function (d) {
                        return "translate("
                                + arc.centroid(d) + ")"; // <-F
                    })
                    .attr("dy", ".35em")
                    .attr("text-anchor", "middle")
                    .text(function (d) {
                        return d.data.id;
                    });
        }

        _chart.width = function (w) {
            if (!arguments.length) return _width;
            _width = w;
            return _chart;
        };

        _chart.height = function (h) {
            if (!arguments.length) return _height;
            _height = h;
            return _chart;
        };

        _chart.colors = function (c) {
            if (!arguments.length) return _colors;
            _colors = c;
            return _chart;
        };

        _chart.radius = function (r) {
            if (!arguments.length) return _radius;
            _radius = r;
            return _chart;
        };

        _chart.innerRadius = function (r) {
            if (!arguments.length) return _innerRadius;
            _innerRadius = r;
            return _chart;
        };

        _chart.data = function (d) {
            if (!arguments.length) return _data;
            _data = d;
            return _chart;
        };

        return _chart;
    }

    function randomData() {
        return Math.random() * 9 + 1;
    }

    function update() {
        for (var j = 0; j < data.length; ++j)
            data[j].value = randomData();

        chart.render();
    }

    var numberOfDataPoint = 3,
            data = [];

    data = d3.range(numberOfDataPoint).map(function (i) {
        return {id: i, value: randomData()};
    });

//    var chart = pieChart()
//            .radius(200)
//            .innerRadius(100)
//            .data(data);
//
//    chart.render();
    console.log('a');

</script>


<script>


        function box() {
            var _boxer = {};
            var _width = 1000, _height = 1000,
                    _data = [],
                    _colors = d3.scale.category20(),
                    _svg,
                    _bodyG,
                    _pieG,
                    _radius = 200,
                    _innerRadius = 100,
                    duration = 500,
                    _xScale,
                    _yScale,
                    tan45 = Math.tan(45);

            _boxer.render = function () {
                if (!_svg) {
                    _svg = d3.select("body").append("svg")
                            .attr("height", _height)
                            .attr("width", _width);
                }

                _boxer.sierpinskiTriangle (400,400,600,8);
            };

            xScale=d3.scale.linear()
                    .domain([0,_width])
                    .range([0,_width]);
            yScale=d3.scale.linear()
                    .domain([0,1000])
                    .range([_height,0]);

            _boxer.sierpinskiTriangle = function(cx,cy,h,levels) {
                console.log('entering sierpinskiTriangle');

                var descend = function(triangleGroup,level) {
                    if (level>0){
                        triangleGroup.forEach(function(d,i){
                            var oneTriangle = d3.select(d);
                            var triangleDef =   oneTriangle.datum();
                            _boxer.sierpinskiTriangle(triangleDef.cx,triangleDef.cy,triangleDef.h, level) ;
                        });
                    }
                }


                if (levels>0){
                    levels -= 1;

                }  else {
                    return;
                }

                var quadOfTriangles =  _boxer.quadTriangle (cx,cy,h,levels);
                    var triangles = quadOfTriangles.filter(function(d){return(d.label==='a')});
                    console.log('a triangles='+triangles.length+', level='+levels+'.');
                    descend(triangles[0],levels) ;
                     triangles = quadOfTriangles.filter(function(d){return(d.label==='b')});

                    console.log('b triangles='+triangles.length+', level='+levels+'.');
                descend(triangles[0],levels) ;
                     triangles = quadOfTriangles.filter(function(d){return(d.label==='c')});
                    console.log('c triangles='+triangles.length+', level='+levels+'.');
                descend(triangles[0],levels) ;

//                    console.log('levels # '+levels+', with '+triangles[0].length+'triangles.');


//                    descend (d3.selectAll('.recursion'+levels).filter(function(d){
//                        console.log(d);
//                        return(d.label==='a')
//                    })[0]);
////                    descend (d3.selectAll('.recursion'+levels).filter(function(d){console.log(d);return(d.label==='b')})[0]);
//                    descend (d3.selectAll('.recursion'+levels).filter(function(d){console.log(d);return(d.label==='c')})[0]);

//                    descend (triangles[0]);



//                    triangles[0].forEach(function(d,i){
//                        var oneTriangleDomElement = d[0];
//                        var oneTriangle = d3.select(d);
//                        var triangleDef =   oneTriangle.datum();
//                        _boxer.sierpinskiTriangle(triangleDef.cx,triangleDef.cy,triangleDef.h, levels) ;
//                    });
 //               }



            }


            _boxer.quadTriangle = function (cx,cy,h,level) {
                var box = _svg.selectAll("polygon.triangle")
                        .data([{cx:(((2*cx)-(h/tan45))/2), cy:(((2*cy)-(h/2))/2), h:h/2, label:'a'},
                            {cx:cx, cy:(((2*cy)+(h/2))/2), h:h/2, label:'b'},
                            {cx:(((2*cx)+(h/tan45))/2), cy:(((2*cy)-(h/2))/2), h:h/2, label:'c'}]);

                box.enter().append("polygon")
                        .attr("class", "triangle")
                        .attr("class", function (d, i) {return ("recursion"+level+" sid_"+ d.label)})
                        //.attr("class", function (d, i) {return "sid_"+ d.label})
                        .attr('fill',function(){return "rgba(255,0,0,0.1)"})
                        .attr('stroke','#00f')
                        .attr('stroke-width','1')
                        .attr('points',function (d, i) {
//                            return (xScale(d.cx))  +','+ (yScale(d.cy)) +' '+
//                                   (xScale(d.cx))  +','+ (yScale(d.cy))  +' '+
//                                   (xScale(d.cx))  +','+ (yScale(d.cy))})  ;
                return (xScale(d.cx- (d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2))) +' '+
                        (xScale(d.cx))  +','+ (yScale(d.cy + (d.h/2)))  +' '+
                        (xScale(d.cx+(d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2)))})  ;



//                var x0 = h/tan45,
//                heightOver2 = h/2.0,
//                        cx2 = cx+500;
                box.transition()
                        .duration(duration)
                        .attr('points',function (d, i) {
                            return (xScale(d.cx- (d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2))) +' '+
                                   (xScale(d.cx))  +','+ (yScale(d.cy + (d.h/2)))  +' '+
                                   (xScale(d.cx+(d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2)))})  ;
                 box.exit().remove();

                return box;

            }








            return  _boxer;
//
        }

        console.log('about to make something...');
        var boxme = box();
        boxme.render();





</script>

<div class="control-group">
    <button onclick="update()">Update</button>
</div>

</body>

</html>