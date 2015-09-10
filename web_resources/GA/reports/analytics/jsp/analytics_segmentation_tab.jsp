<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="analytics" uri="http://www.oracle.com/webcenter/sites/analytics" %>

<div class="span6">
<c:choose><c:when test="${fn:length(results.event.assets) gt 0}">
<h3>Segmentation</h3>
<svg id="segmentationTimelineChart" class="mypiechart"></svg>
<script language="javascript" type="text/javascript"> 
    var segmentPieChartData = [
    <c:forEach var="segment" items="${results.segments}">
      <c:if test="${segment.selected eq 'true'}">
        { key: "<analytics:getAssetAttributeValue asset='${segment}' property='label'/>", id: "${segment.id}", y: ${segment.totalViewed} },
      </c:if>
    </c:forEach>
      ];
    nv.addGraph(function() {
        var width = 400, height = 400;
        var pieChart = nv.models.pieChart()
            .x(function(d) { return d.key })
            .y(function(d) { return d.y })
            .color(d3.scale.category10().range())
            .showLegend (false)
            .width(width)
            .height(height);
        d3.select("#segmentationTimelineChart")
              .datum(segmentPieChartData)
              .transition().duration(1200)
              .attr('width', width)
              .attr('height', height)
              .call(pieChart);
        d3.selectAll('.nv-slice').on('click', function(d, i) {
            document.getElementById('Link-' + d.data.id).click ();
        });
        pieChart.tooltipContent(function(key, y, e, graph) {
            tooltip_str = '<b>'+key+'</b> ' + '(' +  parseInt (y, 10) + ')';
            return tooltip_str;
        });
        pieChart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });
        return pieChart;
    });
</script>
</c:when><c:otherwise>
    <img src="${pageContext.request.contextPath}/reports/images/no_data.png" border="0"/>
</c:otherwise></c:choose>
<c:forEach var="segment" items="${results.segments}">
<c:if test="${segment.selected eq 'true'}">
    <a style="display:none" href="analytics_detail.jsp?event_id=${param.event_id}&filterSegments=${segment.id}&startDate=${param.startDate}&endDate=${param.endDate}&action=apply-filter&activate=segmentation" id="Link-${segment.id}" name="Link-${segment.id}"></a><br/>
</c:if>
</c:forEach>
</div>

<div class="span6">
<c:choose><c:when test="${fn:length(results.event.assets) gt 0}">
<h3>Segment Timeline</h3>
<div id="segmentationTimelineChart" class='with-3d-shadow with-transitions'>
    <svg> </svg>
</div>
<script language="javascript" type="text/javascript"> 
    var pieTimelineChartData = [
    <c:forEach var="segment" items="${results.segments}">
      <c:if test="${segment.selected eq 'true'}">
        { "key" : "<analytics:getAssetAttributeValue asset='${segment}' property='label'/>" , "values" : 
            [
                <c:forEach var="timeSeries" items="${segment.timeSeries}">
                <c:set var="dateAsString" value="${timeSeries.key}"/>
                [<%=getTimeInMilliSec ((String) pageContext.getAttribute ("dateAsString"))%>, ${timeSeries.value}],
                </c:forEach>
            ]
        },
      </c:if>
    </c:forEach>
    ].map(function(series) {
      series.values = series.values.map(function(d) { return {x: d[0], y: d[1] } });
      return series;
    });
    nv.addGraph(function() {
        var width = 500, height = 400;
        var pieTimelineChart = nv.models.linePlusBarChart()
            .margin({top: 30, right: 60, bottom: 50, left: 70})
            .x(function(d,i) { return i })
            .color(d3.scale.category10().range())
            .showLegend (false)
            .width(width)
            .height(height);
        pieTimelineChart.xAxis.tickFormat(function(d) {
              var dx = pieTimelineChartData[0].values[d] && pieTimelineChartData[0].values[d].x || 0;
              return dx ? d3.time.format('%x')(new Date(dx)) : '';
              }).showMaxMin(false);
        pieTimelineChart.y1Axis.tickFormat(d3.format(',f'));
        pieTimelineChart.y2Axis.tickFormat(function(d) { return + d3.format(',.0f')(d) });
        pieTimelineChart.bars.forceY([0]).padData(false);
        d3.select('#segmentationTimelineChart svg').datum(pieTimelineChartData).transition().duration(500).call(pieTimelineChart);
        nv.utils.windowResize(pieTimelineChart.update);
        pieTimelineChart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });
        return pieTimelineChart;
    });
</script>
</c:when><c:otherwise>
    <img src="${pageContext.request.contextPath}/reports/images/no_data.png" border="0"/>
</c:otherwise></c:choose>
<c:forEach var="segment" items="${results.segments}">
<c:if test="${segment.selected eq 'true'}">
    <a style="display:none" href="analytics_detail.jsp?event_id=${param.event_id}&filterSegments=${segment.id}&startDate=${param.startDate}&endDate=${param.endDate}&action=apply-filter&activate=segmentation" id="Link-${segment.id}" name="Link-${segment.id}"></a><br/>
</c:if>
</c:forEach>
</div>


<%!
    public static long getTimeInMilliSec (String dateAsString) throws Exception {
        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat ("dd-MM-yyyy");
        return dateFormat.parse (dateAsString).getTime ();
    }
%>