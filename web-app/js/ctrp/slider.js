(function () {
    d3.slider = function (domainStart,
                          domainEnd,
                          rangeStart,
                          rangeEnd,
                          orientation/*must be either 'vertical' or 'horizontal'*/) {
        // public variables
        var

        // private variables
        instance = {},
            x = {} ,
            svg = {} ,
            brush = {} ,
            handle = {} ,
            slider = {},
            width=300,
            height=300;

        var  ctor = function (domainStart,domainEnd,rangeStart, rangeEnd){
            x = d3.scale.linear()
                .domain([domainStart, domainEnd])
                .range([rangeStart, rangeEnd])
                .clamp(true);

            if (orientation ==='horizontal')    {
                brush = d3.svg.brush()
                    .x(x) ;
            } else {
                brush = d3.svg.brush()
                    .y(x);
            }
            brush.extent([rangeEnd, rangeEnd])
                .on("brush", brushed);


            svg = d3.select("#slider").append("svg")
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            if (orientation ==='horizontal')    {
                svg.append("g")
                    .attr("class", "x axis")
                    .attr("transform", "translate(0," + height / 2 + ")")
                    .call(d3.svg.axis()
                        .scale(x)
                        .orient("bottom")
                        .tickFormat(function (d) {
                            return d ;
                        })
                        .tickSize(0)
                        .tickPadding(12));

            } else {
                svg.append("g")
                    .attr("class", "x axis")
                    .attr("transform", "translate("+height+"," + height / 2 + ")")
                        .call(d3.svg.axis()
                            .scale(x)
                            .orient("left")
                            .tickFormat(function (d) {
                                return d ;
                            })
                            .tickSize(0)
                            .tickPadding(12)) ;

            }
////            svg
//                svg.append("g")
//                .attr("class", "x axis")
//                .attr("transform", "translate("+height+"," + height / 2 + ")")
//                    .call(d3.svg.axis()
//                    .scale(x)
//                    .orient("left")
//                    .tickFormat(function (d) {
//                        return d + "°";
//                    })
//                    .tickSize(0)
//                    .tickPadding(12))
                svg
                .select(".domain")
                .select(function () {
                    return this.parentNode.appendChild(this.cloneNode(true));
                })
                .attr("class", "halo");

            slider = svg.append("g")
                .attr("class", "slider")
                .call(brush);

            slider.selectAll(".extent,.resize")
                .remove();

            slider.select(".background")
                .attr("height", height)
                .attr("width", width);

            handle = slider.append("circle")
                .attr("class", "handle")
                .attr("transform", "translate(0," + height / 2 + ")")
                .attr("r", 9);


            return instance;

            function brushed() {
                var value;
                if (orientation ==='horizontal') {
                    value = brush.extent()[0];
                }  else {
                    value = brush.extent()[1];
                }


                if (d3.event.sourceEvent) { // not a programmatic event
                    if (orientation ==='horizontal') {
                        value = x.invert(d3.mouse(this)[0]);
                        brush.extent([value, value]);
                        handle.attr("cx", x(value));
                    }  else {
                        value = x.invert(d3.mouse(this)[1]);
                        brush.extent([value, value]);
                        handle.attr("cy", x(value));
                    }


                }

                if (!isNaN(value)) {
                    interquartileMultiplier = value;
                    chart.whiskers(iqr(interquartileMultiplier)).render();
                }
            }


        };
        ctor(domainStart,domainEnd,rangeStart, rangeEnd);


        instance.render = function () {

            slider.call(brush.event);       };

        return instance;

    };

    function defaultSliderEvent(value) {
        return;
    }



})();

