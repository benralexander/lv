(function () {

    d3.sierpinskiTriangle = function () {


        var chart = {},
            margin = {top: 10, right: 20, bottom: 10, left: 50},
            width = 1000 - margin.left - margin.right,
            height = 1000 - margin.top - margin.bottom,
            svg,
            levelsOfDescent = 8,
            selectionIdentifier,
            duration = 500,
            tan45 = Math.tan(45),
            xScale = d3.scale.linear()
                .domain([0, width])
                .range([0, width]),
            yScale = d3.scale.linear()
                .domain([0, 1000])
                .range([height, 0]);

        chart.render = function () {
            if (!svg) {
                svg = d3.select(selectionIdentifier).append("svg")
                    .attr("height", height)
                    .attr("width", width);
            }

            chart.sierpinskiRecursiveDescent(width/2, height/2, (3*width/4), levelsOfDescent);
        };

        chart.clear = function () {
            if (svg) {
               // svg = d3.select(selectionIdentifier).append("svg").remove();
                svg.selectAll("polygon") .remove();
            }

            return   chart;
        };


        // the first call, the one that initiates the descent and makes sure that it is called for
        //   each of the 3 sub-triangles
        chart.sierpinskiRecursiveDescent = function (cx, cy, h, levels) {

            // here's the subroutine that actually performs the descent
            var descend = function (triangleGroup, level) {
                if (level > 0) {
                    triangleGroup.forEach(function (d, i) {
                        var triangleDef = d3.select(d).datum();
                        chart.sierpinskiRecursiveDescent(triangleDef.cx, triangleDef.cy, triangleDef.h, level);
                    });
                }
            }

            if (levels > 1) {   //don't recurs forever

                levels -= 1;

                var quadOfTriangles = chart.renderASingleTriangle(cx, cy, h, levels);

                descend(quadOfTriangles.filter(function (d) {
                    return(d.label === 'a')
                })[0], levels);

                descend(quadOfTriangles.filter(function (d) {
                    return(d.label === 'b')
                })[0], levels);

                descend(quadOfTriangles.filter(function (d) {
                    return(d.label === 'c')
                })[0], levels);
            }


        }


        chart.renderASingleTriangle = function (cx, cy, h, level) {
            var triangle = svg.selectAll("polygon.triangle")
                .data([
                    {cx: (((2 * cx) - (h / tan45)) / 2), cy: (((2 * cy) - (h / 2)) / 2), h: h / 2, label: 'a'},
                    {cx: cx, cy: (((2 * cy) + (h / 2)) / 2), h: h / 2, label: 'b'},
                    {cx: (((2 * cx) + (h / tan45)) / 2), cy: (((2 * cy) - (h / 2)) / 2), h: h / 2, label: 'c'}
                ]);

            triangle.enter().append("polygon")
                .attr("class", function (d, i) {
                    return ("recursion" + level + " sid_" + d.label)
                })
//                .attr('fill', function () {
//                    return "rgba(255,0,0,0.2)"
//                })
//                .attr('stroke', '#00f')
//                .attr('stroke-width', '1')
                .attr('points', function (d, i) {

                    return (xScale(d.cx)) + ',' + (yScale(d.cy)) + ' ' +
                        (xScale(d.cx)) + ',' + (yScale(d.cy)) + ' ' +
                        (xScale(d.cx)) + ',' + (yScale(d.cy))
                });
            triangle.transition()
                .duration(duration * 8)
                .attr('points', function (d, i) {
                    return (xScale(d.cx - (d.h / tan45))) + ',' + (yScale(d.cy - (d.h / 2))) + ' ' +
                        (xScale(d.cx)) + ',' + (yScale(d.cy + (d.h / 2))) + ' ' +
                        (xScale(d.cx + (d.h / tan45))) + ',' + (yScale(d.cy - (d.h / 2)))
                });
            triangle.exit().remove();

            return triangle;

        }

        chart.levelsOfDescent = function (w) {
            if (!arguments.length) return levelsOfDescent;
            levelsOfDescent = w;
            return chart;
        };

        // identify the dominant element upon which we will hang this graphic
        chart.selectionIdentifier = function (x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            return chart;
        };





        chart.reverser = function () {
            var triangles = svg.selectAll("polygon");

            triangles
                .attr('fill', function () {
                    return "#ff0000"
                })
                .attr('points', function (d, i) {
                    return (xScale(d.cx - (d.h / tan45))) + ',' + (yScale(d.cy - (d.h / 2))) + ' ' +
                        (xScale(d.cx)) + ',' + (yScale(d.cy + (d.h / 2))) + ' ' +
                        (xScale(d.cx + (d.h / tan45))) + ',' + (yScale(d.cy - (d.h / 2)))
                });

            triangles.transition()
                .duration(duration * 4)
                .attr('fill', function () {
                    return "#00ff00"
                })
                .attr('points', function (d, i) {
                    return (xScale(d.cx - (d.h / tan45))) + ',' + (0.5 * yScale(d.cy - (d.h / 2))) + ' ' +
                        (xScale(d.cx)) + ',' + (0.5 * yScale(d.cy + (d.h / 2))) + ' ' +
                        (xScale(d.cx + (d.h / tan45))) + ',' + (0.5 * yScale(d.cy - (d.h / 2)))
                });


            return triangles;


        }


        chart.resetColor = function () {
            svg.selectAll("polygon")
                .attr('fill', function () {
                    return "rgba(255,0,0,0.2)"
                });
        }


        return  chart;
    }

})();
