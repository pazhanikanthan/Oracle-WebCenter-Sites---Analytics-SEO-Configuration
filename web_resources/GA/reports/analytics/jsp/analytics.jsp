<%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"%>
<%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"%>
<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"%>
<%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"%>
<%@ taglib prefix="analytics" uri="http://www.oracle.com/webcenter/sites/analytics" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<cs:ftcs>
    <c:if test="${not empty ANALYTICS_PAYLOAD.id}">
    <script type="text/javascript">
        var contextPath     =   '${pageContext.request.contextPath}';
        var segmentArray    =   [];
        <commercecontext:getsegments listvarname="segmentlist"/>
        <ics:if condition='<%=ics.GetList("segmentlist",false)!=null && ics.GetList("segmentlist",false).hasData()%>'><ics:then>
            <ics:listloop listname="segmentlist">
                <asset:list list='segmentNameList' type='Segments' field1='id' value1='<%=(ics.GetList("segmentlist", false).getValue("assetid"))%>'/>
                var segment = { 'type' : 'Segments', 'id' : '<%=ics.GetList("segmentNameList").getValue("id")%>' }
                segmentArray.push(segment);
            </ics:listloop>
        </ics:then></ics:if>
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/analytics/js/analytics.js"></script>
    <script type="text/javascript">
        $( document ).ready(function() {
            sendViewAnalytics ('${ANALYTICS_PAYLOAD.id}');
        });
    </script>
    </c:if>
</cs:ftcs>
