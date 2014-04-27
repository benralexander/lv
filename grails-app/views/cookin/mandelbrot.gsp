<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 4/26/14
  Time: 1:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Mandelbrot set</title>
    <link rel="stylesheet" type="text/css" href="../css/ctrp/doseResponse.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>
<body>


<script>
    myNamespace = {};

    myNamespace.mandelbrot = function module() {
        var complexRange = [-2,2],
                realRange = [-2,2],
                numberDivisionsComplex = 100,
                numberDivisionsReal = 100,

        xScale = d3.scale.linear()
                .domain([-2,2])
                .range([0, 800]),
        yScale = d3.scale.linear()
                .domain([-2,2])
                .range([800, 0]),
        color = d3.scale.category20b();


        function holder(selection) {

            var computeColor = function (outerProducts) {
                return outerProducts.map(function (x){
                    return ({r: x.r, c: x.c, e: complexLibrary.determineEscape(x,18)});
                });
            },



            assignData = function (outerProducts) {
                var svgContainer = d3.select("body").append("svg")
                                                   .attr("width", 800)
                                                    .attr("height", 800);


                // Enter
                var rects = svgContainer.selectAll("rect")
                        .data(outerProducts)
                        .enter()
                        .append("rect");

                // Update
                rects
                        .attr('x',function (d) {
                            return (xScale(d.c)) ;
                        })
                        .attr('y',function (d) {
                            return (yScale(d.r)) ;
                        })
                        .attr('width',6)
                        .attr('height',6)
                        .style('fill',function (d) {
                            var co= d.e+1;
                            if (co!=1){
                                console.log('color='+co);
                            }
                            return d3.rgb(color(co)) ;
                        })
                        .style('stroke',function (d) {
                            return d3.rgb(color( d.esc+1)) ;
                        })
                        .style('stroke-width',1)
                ;

                // Exit
//                d3.select("body").selectAll("rect")
//                        .data(data)
//                        .exit()
//                        .remove();




//                d3.select("body").selectAll("rect")
//                        .data(outerProducts)
//                        .enter()
//                        .append("rect");
//
//                // Update
//                d3.select("body").selectAll("rect")
//                        .data(data)
//                        .x(function (d) {
//                            return (d.c) ;
//                        })
//                        .y(function (d) {
//                            return (d.r) ;
//                        })
//                        .width(1)
//                        .height(1)
//                        .color(function (d) {
//                            return d3.scale.category20b( d.esc+1) ;
//                        });
//
//                // Exit
//                d3.select("body").selectAll("rect")
//                        .data(data)
//                        .exit()
//                        .remove();

            },


            generateOuterProducts = function( complexRange,numberDivisionsComplex,
                                              realRange,numberDivisionsReal)  {

                // private method
                var generateVector = function( range,numberOfDivisions)  {
                    var minimum = range[0],
                            maximum = range[1],
                            numericalRange =  maximum - minimum,
                            sizeOfEachStep =  numericalRange /numberOfDivisions,
                            accumulatingArray = [];
                    for (  var i = 0 ; i < numberOfDivisions ; i++ )   {
                        accumulatingArray.push(minimum + (i*sizeOfEachStep))
                    }
                    return   accumulatingArray;
                },
                divisionsComplex = generateVector  (complexRange,numberDivisionsComplex),
                divisionsReal = generateVector  (realRange,numberDivisionsReal),
                outerProduct = [];

                // this is where the processing starts
                divisionsComplex.forEach(function (complexElement){
                    divisionsReal.forEach(function (realElement){
                        outerProduct.push ({r:realElement, c:complexElement})
                    })
                });
                return   outerProduct;
            };

            // this is where the processing starts
            selection.each(function(data) {
                // first regenerate the outer product of the range we will consider

                var outerProducts = generateOuterProducts( complexRange,numberDivisionsComplex,
                        realRange,numberDivisionsReal) ,
                computedColor = computeColor (outerProducts);
                assignData(computedColor);

            });


        }
        holder.complexRange = function(x) {
            if (!arguments.length) return complexRange;
            complexRange = x;
            return this;
        };
        holder.realRange = function(x) {
            if (!arguments.length) return realRange;
            realRange = x;
            return this;
        };

        return holder;
    };


    var complexLibrary=(function(){
        var _square=function(incoming){
                    var rSquared = Math.pow(incoming.r,2),
                        cSquared = Math.pow(incoming.c,2),
                        realComponent = rSquared- cSquared,
                        complexComponent = 2*incoming.r*incoming.c;
                    return {r:realComponent, c:complexComponent};
                },
                _add = function (incoming1,incoming2){
                    var realComponent =  incoming1.r + incoming2.r,
                         complexComponent = incoming1.c + incoming2.c;
                    return {r:realComponent, c:complexComponent};
                },
                determineEscape = function(incoming,maximumIterations) {
                    var loopNumber = 0,
                        returnValue = -1,
                        iteratingValue  = {r:incoming.r, c:incoming.c} ;
                    while ((loopNumber < maximumIterations)  &&
                            (iteratingValue.c < 2))  {
                        iteratingValue  = _add(_square (iteratingValue) ,iteratingValue);
                        loopNumber++;
                    }
                    if (loopNumber < maximumIterations) {
                        returnValue =  loopNumber;
                    } else {
                       console.log('manbdle');
                    }
                    return returnValue;
                };
        return {
            determineEscape:determineEscape
        }
    }());

    // Setters can also be chained directly to the returned function
    var mandelbrot =myNamespace.mandelbrot();

    d3.select('body').datum(['howdy','do']).call(mandelbrot);



    //
//
//
//
//    function mandlebrot() {
//        var _holder = {};
//        var _width = 1000, _height = 1000,
//                _svg,
//                duration = 500,
//                _xScale,
//                _yScale;
//
//        _holder.render = function () {
//            if (!_svg) {
//                _svg = d3.select("body").append("svg")
//                        .attr("height", _height)
//                        .attr("width", _width);
//            }
//
//            _holder.mandlebrotSet();
//        };
//
//        _xScale = d3.scale.linear()
//                .domain([0, _width])
//                .range([0, _width]);
//        _yScale = d3.scale.linear()
//                .domain([0, 1000])
//                .range([_height, 0]);
//
//        _holder.mandlebrotSet = function () {
//
//            console.log ('function mandlebrotSet') ;
//
//        }
//
//    }
//
//    var mandle = mandlebrot();
//    mandle.render();

</script>




</body>
</html>