<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="analytics" uri="http://www.oracle.com/webcenter/sites/analytics" %>

<c:set var="loopEndIndex" value="${fn:length(results.event.assets)}"/>
<c:if test="${loopEndIndex gt 5}">
    <c:set var="loopEndIndex" value="4"/>
</c:if>
<div class="span6">
    <c:choose><c:when test="${results.event.topConversionRenderable == 'true'}">
    <h3>Top 5 Conversion Chart</h3>
    <svg id="conversionChart" class="mypiechart"></svg>
    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            var conversionData = [
            <c:forEach var="associatedAsset" items="${results.event.assets}" begin="0" end="${loopEndIndex}">
                { key: "<analytics:getAssetAttributeValue asset='${associatedAsset}' property='label'/> (${associatedAsset.conversionRate} %)", id: "${associatedAsset.id}", y: ${associatedAsset.conversionRate} },
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
            d3.select("#conversionChart")
                  .datum(conversionData)
                  .transition().duration(1200)
                  .attr('width', width)
                  .attr('height', height)
                  .call(pieChart);
            pieChart.tooltipContent(function(key, y, e, graph) {
                tooltip_str = '<b>'+key+'</b>';
                return tooltip_str;
            });
            pieChart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });
            return pieChart;
        });
    });
    </script>
    </c:when><c:otherwise>
        <img src="${pageContext.request.contextPath}/reports/images/no_data.png" border="0"/>
    </c:otherwise></c:choose>
</div>
<c:if test="${empty param.showchart}">
<div class="span6">
    <table id="assetTable" class="table table-bordered table-hover">
        <tr class="info" id="header">
            <th class="text">Asset Name</th>
            <th class="text-center"># of times Viewed</th>
            <th class="text-center"># of times Clicked</th>
            <th class="text-center">Total</th>
            <th class="text-center">Conversion Rate (%)</th>
        </tr>
        <c:forEach var="associatedAsset" items="${results.event.assets}" begin="0" end="${loopEndIndex}">
        <tr>
            <td class="text"><analytics:getAssetAttributeValue asset='${associatedAsset}' property='label'/></td>
            <td class="text-center">${associatedAsset.totalViewed}</td>
            <td class="text-center">${associatedAsset.totalClicked}</td>
            <td class="text-center">${(associatedAsset.totalViewed + associatedAsset.totalClicked)}</td>
            <td class="text-center">${associatedAsset.conversionRate} %</td>
        </tr>
        </c:forEach>
    </table>
</div>
</c:if>
