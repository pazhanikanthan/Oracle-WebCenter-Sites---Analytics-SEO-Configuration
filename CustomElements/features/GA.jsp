<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="analytics" uri="http://www.oracle.com/webcenter/sites/analytics" %>
<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ taglib prefix="qs" uri="/WEB-INF/futuretense_cs/qs.tld"%>
<%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><%@ page import="java.util.*, 
                   oracle.webcenter.sites.framework.analytics.model.google.*,
                   org.apache.commons.lang.StringUtils"%>
<%-- CustomElements/features/GA
    Description : Scribe GA Feature Element
    Version : 1.0
    Authors : Paz Periasamy
    History: 
--%><cs:ftcs>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<c:set var="embedInIframe"        value='<%=ics.GetVar ("embedInIframe")%>' />
<script src="${pageContext.request.contextPath}/reports/jquery/js/jquery.js"></script>

<c:choose><c:when test="${embedInIframe == 'true'}">
    <c:set var="assetType"  value='<%=ics.GetVar ("assetType")%>' />
    <c:set var="assetId"    value='<%=ics.GetVar ("assetId")%>' />
    <c:set var="iframeURL"  value='${pageContext.request.contextPath}/Satellite?pagename=feature-ga&assetType=${assetType}&assetId=${assetId}' />

<script type="text/javascript">
$(document).ready(function() {
    var iframe = $('#iframeAnalytics');
    setTimeout(function() {
        iframe.attr('src', '${iframeURL}');
    },
    1000);
});
</script>
<style>
    #loadAnalyticsImg{position:absolute;z-index:999;}
    #loadAnalyticsImg div{display:table-cell;width:1421px;height:800px;background:#fff;text-align:center;vertical-align:middle;}
</style>
<div id="loadAnalyticsImg"><div><img src="${pageContext.request.contextPath}/js/fw/images/ui/wem/loading.gif" /></div></div>
<iframe id="iframeAnalytics" style="width: 100%; height: 800px; border: 0"></iframe>
</c:when><c:otherwise>

<assetset:setasset name="currentAsset" type='<%=ics.GetVar("assetType")%>' id='<%=ics.GetVar("assetId")%>' />
<qs:getattributedata name="asset" attributes="name" assettype='<%=ics.GetVar("assetType")%>' assetid='<%=ics.GetVar("assetId")%>'/>

<render:callelement elementname="Utilities/Assets/GetLink" args="siteLocale,d">
    <render:argument name="type"    value='<%=ics.GetVar("assetType")%>'/>
    <render:argument name="id"      value='<%=ics.GetVar("assetId")%>'/>
    <render:argument name="prefix"  value="assetLink"/>
</render:callelement>

<c:set var="assetUrlBefore" value="${assetLink.url}"/>
<c:set var="assetUrl" value='<%=formatAssetUrl ((String)pageContext.getAttribute ("assetUrlBefore"), request.getContextPath ())%>'/>
<c:set var="assetName" value="${asset.name}"/>
<ics:if condition='<%="Page".equalsIgnoreCase (ics.GetVar("assetType"))%>'><ics:then>
<assetset:getattributevalues name="currentAsset" attribute="metaTitle" listvarname="metaTitle" typename="PageAttribute" />
<ics:listget listname="metaTitle" fieldname="value" output="assetTitle" />
</ics:then></ics:if>

<ics:if condition='<%="AVIArticle".equalsIgnoreCase (ics.GetVar("assetType"))%>'><ics:then>
<assetset:getattributevalues name="currentAsset" attribute="headline" listvarname="headline" typename="ContentAttribute" />
<ics:listget listname="headline" fieldname="value" output="assetTitle" />
</ics:then></ics:if>

<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/bootstrap.css">
<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/jquery/css/jquery-ui.css">
<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/datepicker.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/reports/bootstrap/css/token-input.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/reports/bootstrap/css/token-input-facebook.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/reports/jquery/js/jquery-tokeninput.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/reports/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/reports/bootstrap/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/reports/google/js/jsapi.js"></script>

<analytics:getGAResults var="gaResults" filters='ga:pagePath=~${assetUrl}*' metrics="ga:pageviews" maxResults="50" months="2" dimensions="ga:week"/>
<c:choose><c:when test="${fn:length(gaResults.data) == '0'}">
    <span class="label badge-important">No Analytic record(s) found.</span>
</c:when><c:otherwise>
<%-- START OF REPORT --%>
    <div class="container-fluid">

        <div class="accordion" id="accordion2">
            <div class="accordion-group">
                <div class="accordion-heading">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse_google_analytics">
                        <span class="label label-info">Click here to view detailed Reports</span>
                    </a>
                </div>
                <div id="collapse_google_analytics" class="accordion-body collapse" style="height: 0px;">
                    <table id="dataTable" class="table table-bordered table-hover">
                        <tr class="info" id="header">
                            <th class="text">URL:</th>
                            <th class="text">User ID:</th>
                            <th class="text">Password:</th>
                        </tr>
                        <tr>
                            <td class="text">https://www.google.com/analytics/</td>
                            <td class="text">webcentersites.analytics@gmail.com</td>
                            <td class="text">fwadmin1</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <%--
                <ul class="nav nav-tabs" data-tabs="tabs">
                    <li class="active"><a data-toggle="tab" href="#ByWeek">Page Views by Week</a></li>
                    <li class=""><a data-toggle="tab" href="#ByLang">Page Views by Language</a></li>
                </ul>
                --%>
                <div class="tab-content">
                    <div class="tab-pane active" id="ByWeek">
                        <div class="span8">
                            <script type="text/javascript">
                                // Load the Visualization API and the piechart package.
                                google.load("visualization", "1", {packages:["corechart"]});
                                // Set a callback to run when the Google Visualization API is loaded.
                                google.setOnLoadCallback(drawBarChart);
                                // Callback that creates and populates a data table,
                                // instantiates the pie chart, passes in the data and
                                // draws it.
                                function drawBarChart() {
                                    // Create the data table.
                                    var data = google.visualization.arrayToDataTable([
                                    <%=createLineChartJSONArray ((AnalyticsResults)request.getAttribute ("gaResults"), (String)pageContext.getAttribute ("assetName"))%>
                                    ]);
                                    // Set chart options
                                    var options = {'title':'Page Views by Week', pointSize: 6, curveType: 'function', 'width':600, 'height':300};
                                    // Instantiate and draw our chart, passing in some options.
                                    var chart = new google.visualization.LineChart(document.getElementById('byweek_div'));
                                    chart.draw(data, options);
                                }
                            </script>
                            <div id="byweek_div"></div>
                        </div>
                        <div class="span4">
                            <table id="dataTable" class="table table-bordered table-hover">
                                <tr class="info" id="header">
                                <c:forEach items="${gaResults.headers}" var="gaHeader" varStatus="loopIndex">
                                    <th class="text-center"><%=getLabel ((String)pageContext.getAttribute ("gaHeader"))%></th>
                                </c:forEach>
                                </tr>    
                                <c:forEach items="${gaResults.data}" var="gaData" varStatus="loopIndex">
                                <tr id="ByWeek_${loopIndex.index}">
                                    <td class="text-center">${gaData['ga:week']}</td>
                                    <td class="text-center">${gaData['ga:pageviews']}</td>
                                </tr>    
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</c:otherwise></c:choose>


</c:otherwise></c:choose>
<script type="text/javascript">
$(document).ready(function() {
    var loadAnalyticsImgDiv = window.parent.document.getElementById ("loadAnalyticsImg");
    loadAnalyticsImgDiv.innerHTML = "&nbsp;";
});
</script>


<%!

    public static Map <String, String> labels = new HashMap <String, String> ();

    public static String getLabel (String field) {
        
        if (labels.isEmpty ()) {
            labels.put ("ga:week",          "Week");
            labels.put ("ga:pageviews",     "Page Views");
        }
        
        return labels.get (field);
    }

    public static String createLineChartJSONArray(AnalyticsResults analyticsResults, String assetName) {
        StringBuilder builder       =   new StringBuilder ("");
        StringBuilder header        =   new StringBuilder ("");
        List <String> legends       =   new ArrayList <String> ();
        Map <String, Map <String, String>> transposedData       =   new LinkedHashMap <String, Map <String, String>> ();
        
        header.append ("['Week', ");
        for (AnalyticsData data : analyticsResults.getData()) {
            String week         =   (String) data.get("ga:week");
            String pageviews    =   (String) data.get("ga:pageviews");
            if (legends.indexOf(assetName) == -1) {
                legends.add (assetName);
                header.append ("'" + assetName +  "',");
            }
            Map <String, String> dataMap = null;
            if (transposedData.containsKey(week)) {
                dataMap = transposedData.get(week);
            }
            else {
                dataMap = new LinkedHashMap <String, String> ();
                transposedData.put(week, dataMap);
            }
            dataMap.put(assetName, pageviews);
        }
        header.append ("],\n");
        builder.append(header.toString());
        Iterator <String> weekIter = transposedData.keySet().iterator();
        while (weekIter.hasNext()) {
            String week = weekIter.next();
            builder.append ("[");
            builder.append ("'" + week +  "',");
            Map <String, String> dataMap = transposedData.get(week);
            for (String legend : legends) {
                String pageview = StringUtils.defaultIfEmpty(dataMap.get(legend), "0");
                builder.append (pageview + ",");
            }
            builder.append ("],\n");
        }
        return builder.toString();
    }
    
    public static String formatAssetUrl (String assetUrl, String contextPath) {
        if (assetUrl != null) {
            if (!assetUrl.startsWith (contextPath)) { // This is not a vanity URL
                int cidIndex = assetUrl.indexOf ("cid=");
                if (cidIndex != -1) {
                    assetUrl = assetUrl.substring (cidIndex, assetUrl.indexOf ("&", cidIndex));
                }
            }
        }
        return assetUrl;
    }
%>
</cs:ftcs>