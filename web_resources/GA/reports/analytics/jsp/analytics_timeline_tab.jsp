<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="span12">
    <div class='with-3d-shadow with-transitions'>
        <h3>Traffic Overview</h3>
        <svg id="timelineChart"></svg>
    </div>

    <script language="javascript" type="text/javascript">

        var histcatexplong = [ 
            { 
                "key" : "Viewed", 
                "values" :  [
                                <c:forEach var="clickVsView" items="${results.clickVsView}">
                                [${clickVsView.date.time}, ${clickVsView.viewCount}],
                                </c:forEach>
                            ]
            },
            { 
                "key" : "Clicked", 
                "values" :  [
                                <c:forEach var="clickVsView" items="${results.clickVsView}">
                                [${clickVsView.date.time}, ${clickVsView.clickCount}],
                                </c:forEach>
                            ]
            }
        ];

        var colors = d3.scale.category20();
        keyColor = function(d, i) {return colors(d.key)};

        var chart;
        nv.addGraph(function() {
          chart = nv.models.stackedAreaChart()
                        .width(1300).height(500)
                        .useInteractiveGuideline(true)
                        .x(function(d) { return d[0] })
                        .y(function(d) { return d[1] })
                        .color(keyColor)
                        .transitionDuration(300)
                        .showControls(false)
                        .clipEdge(true);

          chart.xAxis.tickFormat(function(d) { return d3.time.format('%x')(new Date(d)) });
          chart.yAxis.tickFormat(d3.format(',.0f'));
          d3.select('#timelineChart')
            .datum(histcatexplong)
            .transition().duration(0)
            .call(chart);

          nv.utils.windowResize(chart.update);
          chart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });
          return chart;
        });

    </script>
</div>