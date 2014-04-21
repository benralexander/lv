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

                var descend = function(triangleGroup,level) {
                    if (level>0){
                        triangleGroup.forEach(function(d,i){
                            var triangleDef =   d3.select(d).datum();
                            _boxer.sierpinskiTriangle(triangleDef.cx,triangleDef.cy,triangleDef.h, level) ;
                        });
                    }
                }

                if (levels>1) {

                    levels -= 1;

                    var quadOfTriangles =  _boxer.quadTriangle (cx,cy,h,levels);

                    descend(quadOfTriangles.filter(function(d){return(d.label==='a')})[0],levels) ;

                    descend(quadOfTriangles.filter(function(d){return(d.label==='b')})[0],levels) ;

                    descend(quadOfTriangles.filter(function(d){return(d.label==='c')})[0],levels) ;
                }


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
                        .attr('fill',function(){return "rgba(255,0,0,0.2)"})
                        .attr('stroke','#00f')
                        .attr('stroke-width','1')
                        .attr('points',function (d, i) {
//                            return (xScale(d.cx+(d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2)))  +' '+
//                                    (xScale(d.cx- (d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2))) +' '+
//                                    (xScale(d.cx))  +','+ (yScale(d.cy + (d.h/2)))
//
//                        })  ;

                            return (xScale(d.cx))  +','+ (yScale(d.cy)) +' '+
                                   (xScale(d.cx))  +','+ (yScale(d.cy))  +' '+
                                   (xScale(d.cx))  +','+ (yScale(d.cy))
})  ;
                box.transition()
                        .duration(duration*8)
                        .attr('points',function (d, i) {
                            return (xScale(d.cx- (d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2))) +' '+
                                   (xScale(d.cx))  +','+ (yScale(d.cy + (d.h/2)))  +' '+
                                   (xScale(d.cx+(d.h/tan45)))  +','+ (yScale(d.cy- (d.h/2)))
                        })  ;
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