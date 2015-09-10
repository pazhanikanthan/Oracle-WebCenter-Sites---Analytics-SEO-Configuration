<%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"%>
<%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"%>
<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"%>
<%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="qs" uri="/WEB-INF/futuretense_cs/qs.tld"%>
<%@ taglib prefix="analytics" uri="http://www.oracle.com/webcenter/sites/analytics" %>
<%@ page import="java.util.Date,java.util.Calendar"%>
<cs:ftcs>

    <!-- CSS Files -->
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/bootstrap.css" type="text/css">
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/datepicker.css" type="text/css">
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/token-input.css" type="text/css">
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/token-input-facebook.css" type="text/css">
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/jquery/css/jquery-ui.css" type="text/css">
    <link type="text/css" href="${pageContext.request.contextPath}/reports/nvd3/css/nv.d3.css" rel="stylesheet">



<style>
.row-fluid .summaryspan12 {
    height: 400px;
    width: 100%;
}
</style>

    <!-- JS Files -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery-tokeninput.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/reports/bootstrap/js/bootstrap-datepicker.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/lib/d3.v3.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/nv.d3.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/legend.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/pie.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/pieChart.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/axis.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/multiBarHorizontal.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/multiBarHorizontalChart.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/utils.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/tooltip.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/interactiveLayer.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/scatter.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/stackedArea.js"></script>
    <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/reports/nvd3/js/models/stackedAreaChart.js"></script>


    <script type="text/javascript">
    $( document ).ready(function() {
        $('#datepickerStart').datepicker();
        $('#datepickerEnd').datepicker();
        $('.dropdown-menu').on('click', function(e) {
            if($(this).hasClass('dropdown-menu-form')) {
                e.stopPropagation();
            }
        });
    });
    </script>

    <analytics:results cid="${param.event_id}" var="results"/>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="tab-content">
                <div class="span12"><br/>
                <qs:getattributedata name="event" attributes="name" assettype="${(results.event.type != null) ? results.event.type : 'AdvCols'}" assetid="${param.event_id}" locale='${args.siteLocale}' />
                    <div class="row-fluid">
                    <div class="span6">
                    <table id="eventTable" width="50%" class="table table-bordered table-hover">
                        <tr>
                            <td class="header" width="30%"><b>Name:</b></td>
                            <td class="text">${event.name}&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="header"><b>ID:</b></td>
                            <td class="text">${param.event_id}&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="header"><b>Type:</b></td>
                            <td class="text">${results.event.type}&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="header"><b>Number of times Recommended: </b></td>
                            <td class="text">${results.event.totalViewed}&nbsp;</td>
                        </tr>
                    </table>
                    </div>
                    <div class="span6">
                    <form name="filterForm">
                    <table id="eventTable" width="50%" class="table table-bordered table-hover">
                        <tr>
                            <td class="header"><b>Segments:</b></td>
                            <td class="text">
                                <div class="btn-group">
                                  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                    <c:choose><c:when test="${fn:length(param.filterSegments) gt 0}">
                                    One or more Segment (s) selected
                                    </c:when><c:otherwise>
                                    No Segment (s)
                                    </c:otherwise></c:choose>
                                    <span class="caret"></span>
                                  </button>
                                  <ul class="dropdown-menu dropdown-menu-form" role="menu">
                                  <c:forEach var="segment" items="${results.segments}">
                                    <c:set var="currentSegmentId" value="${segment.id}"/>
                                    <label class="checkbox"><input <%=getChecked (request.getParameterValues ("filterSegments"), (String) pageContext.getAttribute ("currentSegmentId"))%> name="filterSegments" type="checkbox" value="${segment.id}"/><analytics:getAssetAttributeValue asset='${segment}' property='label'/></label>
                                  </c:forEach>
                                  </ul>
                                </div>
                            </td>
                            <td class="text" colspan="2">
                                  <c:forEach var="segment" items="${results.segments}">
                                  <c:set var="currentSegmentId" value="${segment.id}"/>
                                  <c:set var="checked" value='<%=getChecked (request.getParameterValues ("filterSegments"), (String) pageContext.getAttribute ("currentSegmentId"))%>'/>
                                  <c:if test="${checked eq 'CHECKED'}"><span class="badge badge-warning"><analytics:getAssetAttributeValue asset='${segment}' property='label'/></span></c:if>&nbsp;
                                  </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <td class="header"><b>Start Date:</b></td>
                            <td class="text">
                                <div class="input-append date" id="datepickerStart" data-date-format="dd-mm-yyyy">
                                    <input class="span6" size="16" type="text" name="startDate" value="${param.startDate}" readonly="readonly" />
                                    <span class="add-on"><i class="icon-calendar"></i></span>
                                </div>
                            </td>
                            <td class="header"><b>End Date:</b></td>
                            <td class="text">
                                <div class="input-append date" id="datepickerEnd" data-date-format="dd-mm-yyyy">
                                    <input class="span6" size="16" type="text" name="endDate" value="${param.endDate}" readonly="readonly" />
                                    <span class="add-on"><i class="icon-calendar"></i></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="text" colspan="4" align="right">
                                <input type="hidden" value="${param.event_id}" name="event_id"/>
                                <input type="hidden" value="apply-filter" name="action"/>
                                <div class="btn-group">
                                  <button type="submit" class="btn btn-info"><b>Apply Filter</b></button>
                                </div>
                                <a href="analytics_detail.jsp?event_id=${param.event_id}" class="btn btn-info">Clear Filter</a>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                                        Date Range <span class="caret"></span>
                                    </button>
                                    <fmt:formatDate pattern="dd-MM-yyyy" value="<%=getCurrentDate ()%>" var="currentDate"/>
                                    <fmt:formatDate pattern="dd-MM-yyyy" value="<%=getLast24HourDate ()%>" var="last24hourdate"/>
                                    <fmt:formatDate pattern="dd-MM-yyyy" value="<%=getLast7DaysDate ()%>" var="last7daysdate"/>
                                    <fmt:formatDate pattern="dd-MM-yyyy" value="<%=getLast365DaysDate ()%>" var="last365daysdate"/>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="analytics_detail.jsp?event_id=${param.event_id}&startDate=${last24hourdate}&endDate=${currentDate}&action=apply-filter">Last 24 hours</a></li>
                                        <li><a href="analytics_detail.jsp?event_id=${param.event_id}&startDate=${last7daysdate}&endDate=${currentDate}&action=apply-filter">Last 7 days</a></li>
                                        <li><a href="analytics_detail.jsp?event_id=${param.event_id}&startDate=${last365daysdate}&endDate=${currentDate}&action=apply-filter">Last 365 days</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </table>
                    </form>

                    </div>
                    </div>
                
                <c:choose><c:when test="${results.recordFound}">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="navbar"><div class="navbar-inner"><span class="brand">Testing Results</span>
                            <ul class="nav nav-pills" data-tabs="tabs">
                                <li class="active"><a data-toggle="tab" href="#SummaryTab">Summary</a></li>
                                <li class=""><a data-toggle="tab" href="#ConversionTab">Top 5 Conversions</a></li>
                                <li class=""><a data-toggle="tab" href="#DetailResultsTab">Detail Results</a></li>
                            </ul>
                            </div></div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="SummaryTab">
                                <div class="summaryspan12">
                                    <jsp:include page="analytics_timeline_tab.jsp" flush="true"/>
                                    <div class="summaryspan12">
                                        <jsp:include page="analytics_segmentation_tab.jsp" flush="true"/>
                                    </div>
                                </div>
                                </div>
                                <div class="tab-pane " id="ConversionTab">
                                    <jsp:include page="analytics_conversion_tab.jsp" flush="true">
                                        <jsp:param name="graphIndex" value="3" />
                                    </jsp:include>
                                </div>
                                <div class="tab-pane" id="DetailResultsTab">
                                    <table id="assetTable" class="table table-bordered table-hover">
                                        <tr class="info" id="header">
                                            <th class="text">Asset Name</th>
                                            <th class="text">Asset Type</th>
                                            <th class="text-center">Asset Id</th>
                                            <th class="text-center"># of times Viewed</th>
                                            <th class="text-center"># of times Clicked</th>
                                            <th class="text-center">Conversion Rate (%)</th>
                                        </tr>
                                        <c:forEach var="associatedAsset" items="${results.event.assets}">
                                        <tr>
                                            <td class="text"><analytics:getAssetAttributeValue asset='${associatedAsset}' property='label'/></td>
                                            <td class="text">${associatedAsset.type}</td>
                                            <td class="text-center">${associatedAsset.id}</td>
                                            <td class="text-center">${associatedAsset.totalViewed}</td>
                                            <td class="text-center">${associatedAsset.totalClicked}</td>
                                            <td class="text-center">${associatedAsset.conversionRate} %</td>
                                        </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:when><c:otherwise>
                    <span class="label badge-important">No Record(s) found!</span>
                </c:otherwise></c:choose>
                </div>
            </div>
        </div>
    </div>

</cs:ftcs>


<%!
    public static String getChecked (String [] filterSegments, String currentSegmentId) {
        if (filterSegments != null && filterSegments.length > 0) {
            for (String filterSegment : filterSegments) {
                if (filterSegment.equals (currentSegmentId)) {
                    return "CHECKED";
                }
            }
        }
        return "";
    }
    
    public static Date getLast24HourDate () {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.HOUR_OF_DAY, -24);
        return cal.getTime ();
    }
    
    public static Date getLast7DaysDate () {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -7);
        return cal.getTime ();
    }

    public static Date getLast365DaysDate () {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -365);
        return cal.getTime ();
    }
    
    public static Date getCurrentDate () {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, +1);
        return cal.getTime ();
    }
%>