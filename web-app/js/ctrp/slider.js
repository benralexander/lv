(function () {
    d3.slider = function (domainStart,domainEnd,rangeStart, rangeEnd) {
        // public variables
        var

        // private variables
        instance = {},
            x = {} ,
            svg = {} ,
            brush = {} ,
            handle = {} ,
            slider = {};

        var  ctor = function (domainStart,domainEnd,rangeStart, rangeEnd){
            x = d3.scale.linear()
                .domain([domainStart, domainEnd])
                .range([rangeStart, rangeEnd])
                .clamp(true);

            brush = d3.svg.brush()
                .x(x)
                .extent([rangeEnd, rangeEnd])
                .on("brush", brushed);

            svg = d3.select("#slider").append("svg")
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height / 2 + ")")
                .call(d3.svg.axis()
                    .scale(x)
                    .orient("bottom")
                    .tickFormat(function (d) {
                        return d + "°";
                    })
                    .tickSize(0)
                    .tickPadding(12))
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
                .attr("height", height);

            handle = slider.append("circle")
                .attr("class", "handle")
                .attr("transform", "translate(0," + height / 2 + ")")
                .attr("r", 9);


            return instance;

            function brushed() {
                var value = brush.extent()[0];

                if (d3.event.sourceEvent) { // not a programmatic event
                    value = x.invert(d3.mouse(this)[0]);
                    brush.extent([value, value]);
                }
                handle.attr("cx", x(value));
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

