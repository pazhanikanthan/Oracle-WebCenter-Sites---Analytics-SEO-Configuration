<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.oracle.com/webcenter/sites/seo" prefix="seo" %>
<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%-- CustomElements/features/SEO
    Description : Scribe SEO Feature Element
    Version : 1.0
    Authors : Paz Periasamy
    History: 
--%><cs:ftcs>

<c:set var="embedInIframe"        value='<%=ics.GetVar ("embedInIframe")%>' />

<script src="${pageContext.request.contextPath}/reports/jquery/js/jquery.js"></script>

<c:choose><c:when test="${embedInIframe == 'true'}">
    <c:set var="assetType"  value='<%=ics.GetVar ("assetType")%>' />
    <c:set var="assetId"    value='<%=ics.GetVar ("assetId")%>' />
    <c:set var="iframeURL"  value='/cs/Satellite?pagename=feature-soe&assetType=${assetType}&assetId=${assetId}' />

<script type="text/javascript">
$(document).ready(function() {
    var iframe = $('#iframeSEO');
    setTimeout(function() {
        iframe.attr('src', '${iframeURL}');
    },
    1000);
});
</script>
<style>
    #loadSEOImg{position:absolute;z-index:999;}
    #loadSEOImg div{display:table-cell;width:1421px;height:800px;background:#fff;text-align:center;vertical-align:middle;}
</style>
<div id="loadSEOImg"><div><img src="/cs/js/fw/images/ui/wem/loading.gif" /></div></div>
<iframe id="iframeSEO" style="width: 100%; height: 800px; border: 0"></iframe>
</c:when><c:otherwise>

<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/bootstrap.css">
<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/jquery/css/jquery-ui.css">
<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/reports/bootstrap/css/datepicker.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/reports/bootstrap/css/token-input.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/reports/bootstrap/css/token-input-facebook.css" type="text/css" />
<script src="${pageContext.request.contextPath}/reports/jquery/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/reports/jquery/js/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/reports/jquery/js/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/reports/jquery/js/jquery-tokeninput.js"></script>
<script src="${pageContext.request.contextPath}/reports/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/reports/bootstrap/js/bootstrap-datepicker.js"></script>
<render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/>

<%
    List <String> keywords = new ArrayList <String> ();
    List <String> missingFields = new ArrayList <String> ();
%>

<assetset:setasset name="currentAsset" type='<%=ics.GetVar("assetType")%>' id='<%=ics.GetVar("assetId")%>' />

<ics:if condition='<%="Page".equalsIgnoreCase (ics.GetVar("assetType"))%>'><ics:then>
<assetset:getattributevalues name="currentAsset" attribute="keywords" listvarname="keywords" typename="PageAttribute" />
<ics:listloop listname="keywords">
    <ics:listget listname="keywords" fieldname="value" output="keyword"/>
    <% keywords.add (ics.GetVar ("keyword")); %><br/>
</ics:listloop>

<assetset:getattributevalues name="currentAsset" attribute="metaTitle" listvarname="metaTitle" typename="PageAttribute" />
<ics:listget listname="metaTitle" fieldname="value" output="metaTitle" />

<assetset:getattributevalues name="currentAsset" attribute="metaDescription" listvarname="metaDescription" typename="PageAttribute" />
<ics:listget listname="metaDescription" fieldname="value" output="metaDescription" />

<assetset:getattributevalues name="currentAsset" attribute="title" listvarname="title" typename="PageAttribute" />
<ics:listget listname="title" fieldname="value" output="metaHeadline" />

<assetset:getattributevalues name="currentAsset" attribute="metaTitle" listvarname="metaTitle" typename="PageAttribute" />
<ics:listget listname="metaTitle" fieldname="value" output="body" />

<%
    if (StringUtils.isBlank (ics.GetVar ("metaTitle"))) {
        missingFields.add ("Title");
    }
    if (StringUtils.isBlank (ics.GetVar ("metaDescription"))) {
        missingFields.add ("Description");
    }
    if (StringUtils.isBlank (ics.GetVar ("metaHeadline"))) {
        missingFields.add ("Headline");
    }
    if (StringUtils.isBlank (ics.GetVar ("body"))) {
        missingFields.add ("Body");
    }
%>
</ics:then></ics:if>

<ics:if condition='<%="AVIArticle".equalsIgnoreCase (ics.GetVar("assetType"))%>'><ics:then>
<assetset:getattributevalues name="currentAsset" attribute="keywords" listvarname="keywords" typename="ContentAttribute" />
<ics:listloop listname="keywords">
    <ics:listget listname="keywords" fieldname="value" output="keyword"/>
    <% keywords.add (ics.GetVar ("keyword")); %><br/>
</ics:listloop>

<assetset:getattributevalues name="currentAsset" attribute="headline" listvarname="metaTitle" typename="ContentAttribute" />
<ics:listget listname="metaTitle" fieldname="value" output="metaTitle" />

<assetset:getattributevalues name="currentAsset" attribute="subheadline" listvarname="subheadline" typename="ContentAttribute" />
<ics:listget listname="subheadline" fieldname="value" output="metaDescription" />

<assetset:getattributevalues name="currentAsset" attribute="headline" listvarname="headline" typename="ContentAttribute" />
<ics:listget listname="headline" fieldname="value" output="metaHeadline" />

<assetset:getattributevalues name="currentAsset" attribute="abstract" listvarname="abstract" typename="ContentAttribute" />
<ics:listget listname="abstract" fieldname="value" output="body" />

<%
    if (StringUtils.isBlank (ics.GetVar ("metaTitle")) || StringUtils.isBlank (ics.GetVar ("metaHeadline"))) {
        missingFields.add ("Headline");
    }
    if (StringUtils.isBlank (ics.GetVar ("metaDescription"))) {
        missingFields.add ("Sub Headline");
    }
    if (StringUtils.isBlank (ics.GetVar ("body"))) {
        missingFields.add ("Abstract");
    }
%>
</ics:then></ics:if>

<c:set var="htmlTitleVar"       value='<%=ics.GetVar ("metaTitle")%>' />
<c:set var="htmlDescriptionVar" value='<%=ics.GetVar ("metaDescription")%>' />
<c:set var="htmlHeadlineVar"    value='<%=ics.GetVar ("metaHeadline")%>' />
<c:set var="htmlBodyVar"        value='<%=ics.GetVar ("body")%>' />
<c:set var="domainVar"          value="localhost.local" />


<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <ul class="nav nav-tabs" data-tabs="tabs">
                <li class="active"><a data-toggle="tab" href="#Keywords">Keywords</a></li>
                <li class=""><a data-toggle="tab" href="#Content">Content Analysis</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="Keywords">
                    <div class="span12">
                        <c:choose><c:when test="<%=keywords.isEmpty ()%>">
                            <span class="label badge-important">Missing Keywords metadata.</span>
                        </c:when><c:otherwise>
                            <ul class="nav nav-tabs" data-tabs="tabs">
                            <c:forEach items="<%=keywords%>" var="keyword" varStatus="loopIndex">
                                <c:choose><c:when test="${loopIndex.index == 0}">
                                    <c:set var="className" value="active" />
                                </c:when><c:otherwise>
                                    <c:set var="className" value="" />
                                </c:otherwise></c:choose>
                                <li class="${className}"><a data-toggle="tab" href="#keyword_${loopIndex.index}">${keyword}</a></li>
                            </c:forEach>
                            </ul>
                            <div class="tab-content">
                            <c:forEach items="<%=keywords%>" var="keyword" varStatus="loopIndex">
                                <c:choose><c:when test="${loopIndex.index == 0}">
                                    <c:set var="className" value="active" />
                                </c:when><c:otherwise>
                                    <c:set var="className" value="" />
                                </c:otherwise></c:choose>
                                <div class="tab-pane ${className}" id="keyword_${loopIndex.index}">
                                    <oscache:cache key="keyword_${keyword}" scope="application" groups="CACHE_SEO">
                                    <seo:getKeywordAnalysis var="keywordAnalysis" keyword="${keyword}" domainVar="${domainVar}"/>
                                    <table id="dataTable" class="table table-bordered table-hover">
                                        <tr class="info" id="header">
                                            <th class="text-center">Difficulty</th>
                                            <th class="text-center">Content</th>
                                            <th class="text-center">Score Links</th>
                                            <th class="text-center">Facebook Likes</th>
                                            <th class="text-center">Gender Target (Male)</th>
                                            <th class="text-center">Gender Target (Female)</th>
                                            <th class="text-center">Primary Age Target</th>
                                            <th class="text-center">Primary Age Target %</th>
                                            <th class="text-center">Secondary Age Target</th>
                                            <th class="text-center">Secondary Age Target %</th>
                                            <th class="text-center">Average cost per click (in USD$)</th>
                                            <th class="text-center">Annual extact Search Volume</th>
                                            <th class="text-center">Monthly extact Search Volume</th>
                                        </tr>
                                        <tr>
                                            <td class="text-center">${keywordAnalysis.scoreDifficulty}</td>
                                            <td class="text-center">${keywordAnalysis.scoreContent}</td>
                                            <td class="text-center">${keywordAnalysis.scoreLinks}</td>
                                            <td class="text-center">${keywordAnalysis.scoreFacebookLikes}</td>
                                            <td class="text-center">${keywordAnalysis.scoreGenderMale}</td>
                                            <td class="text-center">${keywordAnalysis.scoreGenderFemale}</td>
                                            <td class="text-center">${keywordAnalysis.agePrimaryDescription}</td>
                                            <td class="text-center">${keywordAnalysis.agePrimaryValue}</td>
                                            <td class="text-center">${keywordAnalysis.ageSecondaryDescription}</td>
                                            <td class="text-center">${keywordAnalysis.ageSecondaryValue}</td>
                                            <td class="text-center">${keywordAnalysis.ppc}</td>
                                            <td class="text-center">${keywordAnalysis.volumeAnnual}</td>
                                            <td class="text-center">${keywordAnalysis.volumeMonthly}</td>
                                        </tr>
                                    </table>
                                    <seo:getKeywordSuggestions var="suggestions" keyword="${keyword}"/>
                                    <table id="dataTable" class="table table-bordered table-hover">
                                        <tr class="info" id="header">
                                            <th class="text">Suggested Keyword</th>
                                            <th class="text-center">Keyword Competition<br>(the higher the value, the more competitive)</th>
                                            <th class="text-center">Relative Popularity</th>
                                        </tr>
                                        <c:forEach items="${suggestions}" var="suggestion" varStatus="suggestionIndex">
                                        <tr id="${suggestionIndex.index}">
                                            <td class="text">${suggestion.term}</td>
                                            <td class="text-center">${suggestion.competition}</td>
                                            <td class="text-center">${suggestion.popularity}</td>
                                        </tr>
                                        </c:forEach>
                                    </table>
                                    </oscache:cache>
                                </div>
                            </c:forEach>
                            </div>
                        </c:otherwise></c:choose>
                    </div>
                </div>
                <div class="tab-pane" id="Content">
                    <div class="tab-content">
                        <c:choose><c:when test="<%=!missingFields.isEmpty ()%>">
                            <span class="label badge-important">One of more metadata fields missing <%=missingFields%>.</span>
                        </c:when><c:otherwise>
                        <oscache1:cache key="content_${htmlTitleVar}_${htmlDescriptionVar}_${htmlHeadlineVar}_${htmlBodyVar}" scope="application" groups="CACHE_SEO">
                        <seo:getContentAnalysis var="contentAnalysis" htmlTitleVar="${htmlTitleVar}" htmlDescriptionVar="${htmlDescriptionVar}" htmlHeadlineVar="${htmlHeadlineVar}" htmlBodyVar="${htmlBodyVar}" domainVar="${domainVar}"/>
                        <table id="dataTable" class="table table-bordered table-hover">
                            <tr class="info" id="header">
                                <th class="text">Item</th>
                                <th class="text">Results</th>
                            </tr>
                            <tr>
                                <td class="text"><%=getLabel("docScore")%></td>
                                <td class="text">${contentAnalysis.docScore}</td>
                            </tr>
                            <tr>
                                <td class="text"><%=getLabel("fleschScore")%></td>
                                <td class="text">${contentAnalysis.fleschScore}</td>
                            </tr>
                            <tr>
                                <td class="text">Keywords Analysis</td>
                                <td class="text">

                                <div class="container-fluid">  
                                    <div class="accordion" id="accordion2"> 
                                    <c:forEach items="${contentAnalysis.keywords}" var="keyword" varStatus="keywordIndex">
                                        <div class="accordion-group">  
                                            <div class="accordion-heading">
                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse_${keywordIndex.index}">
                                                    <span class="label label-inverse">${keyword.text}</span>
                                                    <span class="badge badge-${keyword.kwcIndicator}">Score: ${keyword.kwc}</span>
                                                    <c:if test="${fn:length(keyword.kwe) > 0}">
                                                    <span class="badge badge-info">${fn:length(keyword.kwe)} or more suggestion(s) available</span>
                                                    </c:if>
                                                </a>  
                                            </div>  
                                            <div id="collapse_${keywordIndex.index}" class="accordion-body collapse" style="height: 0px; ">  
                                                <table id="dataTable" class="table table-bordered table-hover">
                                                    <tr class="info" id="header">
                                                        <th class="text">Item</th>
                                                        <th class="text">Results</th>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwc")%></td>
                                                        <td class="text">${keyword.kwc}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwd")%></td>
                                                        <td class="text">${keyword.kwd}</td>
                                                    </tr>
                                                    <c:if test="${fn:length(keyword.kwe) > 0}">
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwe")%></td>
                                                        <td class="text">
                                                        <ol>
                                                        <c:forEach items="${keyword.kwe}" var="kwe" varStatus="kweIndex">
                                                            <li><%=getLabel((String) pageContext.getAttribute ("kwe"))%></li>
                                                        </c:forEach>
                                                        </ol>
                                                        </td>
                                                    </tr>
                                                    </c:if>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwf")%></td>
                                                        <td class="text">${keyword.kwf}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwlText")%></td>
                                                        <td class="text">${keyword.kwlText}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwo")%></td>
                                                        <td class="text">${keyword.kwo}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwod")%></td>
                                                        <td class="text">${keyword.kwod}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwp")%></td>
                                                        <td class="text">${keyword.kwp}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwr")%></td>
                                                        <td class="text">${keyword.kwr}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kws")%></td>
                                                        <td class="text">${keyword.kws}</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text"><%=getLabel("kwl")%></td>
                                                        <td class="text">${keyword.kwl}</td>
                                                    </tr>
                                                </table>
                                            </div>  
                                        </div>  
                                    </c:forEach>    
                                    </div>  
                                </div>  
                                
                                </td>
                            </tr>
                            <tr>
                                <td class="text"><%=getLabel("docScoreE")%></td>
                                <td class="text">
                                <ol>
                                <c:forEach items="${contentAnalysis.docScoresE}" var="docScoresE" varStatus="docScoresEIndex">
                                    <li><%=getLabel((String) pageContext.getAttribute ("docScoresE"))%></li>
                                </c:forEach>
                                </ol>
                                </td>
                            </tr>
                            <tr>
                                <td class="text"><%=getLabel("scribeScore")%></td>
                                <td class="text">${contentAnalysis.scribeScore}</td>
                            </tr>
                            <tr>
                                <td class="text"><%=getLabel("tags")%></td>
                                <td class="text">
                                <c:forEach items="${contentAnalysis.tags}" var="tag" varStatus="tagsIndex">
                                    <span class="label">${tag}</span>
                                </c:forEach>
                                </td>
                            </tr>
                        </table>
                        </oscache1:cache>
                        </c:otherwise></c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</c:otherwise></c:choose>

<script type="text/javascript">
$(document).ready(function() {
    var loadSEOImgDiv = window.parent.document.getElementById ("loadSEOImg");
    loadSEOImgDiv.innerHTML = "&nbsp;";
});
</script>


</cs:ftcs>

<%!

    public static Map <String, String> labels = new HashMap <String, String> ();

    public static String getLabel (String field) {
        
        if (labels.isEmpty ()) {
            labels.put ("docScore",     "Document Score");
            labels.put ("fleschScore",  "Structural & Word Choices Score");
            labels.put ("scribeScore",  "Overall Score");
            labels.put ("docScoreE",    "Suggestions to increase Document Score");
            labels.put ("TitleLen",     "The html-title is less than 3 words, add more words");
            labels.put ("TitleCharLen", "The html-title is greater than 72 characters, use less");
            labels.put ("MetaCharLen",  "The html-description is greater than 165 characters, use less");
            labels.put ("BodyLen",      "The html-body is less than 250 unique words, add more");
            labels.put ("Hyper",        "No hyperlinks found, add more");
            labels.put ("HyperLen",     "No hyperlinks in the first 700 characters, add");
            labels.put ("NoPKW",        "No Primary Keyword found in content");
            labels.put ("tags",         "Related topical terms for the content");
            
            labels.put ("kwc",          "Keyword's score based on the writing style of the author");
            labels.put ("kwd",          "Keyword's density");
            labels.put ("kwe",          "Suggestions to increase Keyword's score");
            labels.put ("KwET",         "Keyword not in html-title");
            labels.put ("KwETP",        "Keyword not in the beginning of the html-title");
            labels.put ("KwEM",         "Keyword not in the html-description");
            labels.put ("KwEMP",        "Keyword not in the beginning of the html-description");
            labels.put ("KwED",         "Keyword density is more than 10%");
            labels.put ("KwELF",        "Keyword density for the term is less than the median keyword density of the document");
            labels.put ("KwEH",         "Keyword not in the anchor title of a hyperlink in the htmlbody");
            labels.put ("kwf",          "How many times this keyword appears in the user's content");
            labels.put ("kwlText",      "Numeric value of Keyword's importance");
            labels.put ("kwo",          "Grid score of the keyword");
            labels.put ("kwod",         "Text that is presented to the user in relation to the keyword's position in the grid");
            labels.put ("kwp",          "Prominence of the keyword");
            labels.put ("kwr",          "Rank of the keyword in relation to the others");
            labels.put ("kws",          "Keyword's score based on the content");
            labels.put ("kwl",          "Keyword's important in the user's content");

        }
        
        return labels.get (field);
    }
%>