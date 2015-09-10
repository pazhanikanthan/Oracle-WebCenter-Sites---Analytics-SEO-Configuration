<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="qs" uri="/WEB-INF/futuretense_cs/qs.tld"%>
<cs:ftcs>
    <c:remove var="currentAssetName" scope="request"/>
    <qs:getattributedata name="currentAsset" attributes="name" assettype="${param.assetType}" assetid="${param.assetId}" locale='${args.siteLocale}' />
    <c:set var="currentAssetName" scope="request" value="${currentAsset.name}"/>
</cs:ftcs>
