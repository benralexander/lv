<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Pie Chart</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>

<script type="text/javascript">
    function pieChart() {
        var _chart = {};

        var _width = 500, _height = 500,
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


<script type="text/javascript">


        function box() {
            var _boxer = {};
            var _width = 500, _height = 500,
                    _data = [],
                    _colors = d3.scale.category20(),
                    _svg,
                    _bodyG,
                    _pieG,
                    _radius = 200,
                    _innerRadius = 100,
                    duration = 2000;

            _boxer.render = function () {
                if (!_svg) {
                    _svg = d3.select("body").append("svg")
                            .attr("height", _height)
                            .attr("width", _width);
                }

                _boxer.makebox (_svg);
            };



            _boxer.makebox = function () {
                var sin30 = Math.sin(30);
                var box = _svg.selectAll("rect.box")
                        .data([100, 200, 300]);

                box.enter().append("rect")
                        .attr("class", "box")
                        .attr('fill','#f00')
                        .attr("x", 0)
                        .attr("y", function (d) {
                            return (100);
                        })
                        .attr("width", _width)
                        .attr("height", function (d) {
                            return 200;
                        });

                box.transition()
                        .duration(duration)
                        .attr("y", function (d) {
                            return 200;
                        })
                        .attr("height", function (d) {
                            return 400;
                        });

                box.exit().remove();

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