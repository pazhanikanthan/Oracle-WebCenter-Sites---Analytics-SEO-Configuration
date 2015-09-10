var cookieName = '_wcs_TrackAnalytics';
var COOKIEOUTERDELIMITER = '-';
var COOKIEINNERDELIMITER = ':';

// Call AJAX
function invokeAnalyticsAJAX (urlMapping, analyticsId, analyticsData) {
	var xmlhttp = new XMLHttpRequest();
	var timestamp = new Date().getTime();
	xmlhttp.open("POST", '/cs/analytics-js/' + urlMapping + '/' + analyticsId + '-' + timestamp + '.js');
	xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	xmlhttp.send(JSON.stringify({analyticsData: analyticsData}));
}

//This will sort your array
function sortByEventId (element1, element2){
	var event1 = $(element1).attr('_wcs_TrackEvent');
	var event2 = $(element2).attr('_wcs_TrackEvent');
	return ((event1 < event2) ? -1 : ((event1 > event2) ? 1 : 0));
}

function unique(list) {
	var result = [];
	var assetArray = [];
	$.each(list, function(i, e) {
		if ($.inArray($(e).attr('_wcs_TrackAsset'), assetArray) == -1) {
			assetArray.push ($(e).attr('_wcs_TrackAsset'));
			result.push(e);
		}
	});
	return result;
}

function sendViewAnalytics (payLoadId) {
	var $payLoadDiv = $( '<div _wcs_TrackPayload="Payload:' + payLoadId + '" style="display: none;">' + payLoadId + '</div>' );
	$( "body" ).prepend( $payLoadDiv);
	var eventArray = [];
	if ($('a[_wcs_TrackEvent]') != undefined) {
		var linkArray = $('a[_wcs_TrackEvent]');
		linkArray = unique (linkArray);
		linkArray.sort(sortByEventId);
		var prevEventId = '#';
		var currEventId = '';
		var asset;
		var assetArray  = [];
		var firstLoop   = true;
		$(linkArray).each(function (){
			currEventId = $(this).attr('_wcs_TrackEvent');
			if (((prevEventId != '#') && (currEventId != prevEventId))) {
				var eventDataArray = prevEventId.split(':');
				var assetCloneArray = [].concat(assetArray);
				var trackEvent = { 'type' : '' + eventDataArray [0] + '', 'id' : '' + eventDataArray [1] + '', 'assets' : assetCloneArray }
				eventArray.push(trackEvent);
				assetArray.splice(0, assetArray.length);
			}
			var assetDataArray = $(this).attr('_wcs_TrackAsset').split(':');
			var asset = { 'type' : '' + assetDataArray [0] + '', 'id' : '' + assetDataArray [1] + '' }
			assetArray.push(asset);
			prevEventId = currEventId;
			firstLoop = false;
		});
		var eventDataArray = currEventId.split(':');
		var assetCloneArray = [].concat(assetArray);
		var trackEvent = { 'type' : '' + eventDataArray [0] + '', 'id' : '' + eventDataArray [1] + '', 'assets' : assetCloneArray }
		eventArray.push(trackEvent);
	}
	var analyticsData = { 'id' : '' + payLoadId + '', 'events' : eventArray, 'segments' : segmentArray }
	invokeAnalyticsAJAX ('v', '' + payLoadId + '', analyticsData);
}

$( document ).ready(function() {
	$('a[_wcs_TrackEvent]').click(function (event) {
		$.removeCookie(cookieName, {path: contextPath});
		var cookieVal = $('div').attr('_wcs_TrackPayload') + COOKIEOUTERDELIMITER +
						$(this).attr('_wcs_TrackEvent')    + COOKIEOUTERDELIMITER +
						$(this).attr('_wcs_TrackAsset');
		$.cookie(cookieName, cookieVal, {path: contextPath});
	});

	if (jQuery.cookie(cookieName)) {
		var eventArray 			= 	[];
		var assetArray 			= 	[];
		var cookieVal 			= 	jQuery.cookie(cookieName);
		var cookieOuterArray 	= 	cookieVal.split (COOKIEOUTERDELIMITER);
		var _wcs_TrackPayload 	= 	cookieOuterArray [0];
		var _wcs_TrackEvent 	= 	cookieOuterArray [1];
		var _wcs_TrackAsset 	= 	cookieOuterArray [2];
		var payloadDataArray 	= 	_wcs_TrackPayload.split (COOKIEINNERDELIMITER);
		var assetDataArray 		= 	_wcs_TrackAsset.split (COOKIEINNERDELIMITER);
		var eventDataArray 		= 	_wcs_TrackEvent.split (COOKIEINNERDELIMITER);
		var asset 				= 	{ 'type' : '' + assetDataArray [0] + '', 'id' : '' + assetDataArray [1] + '' }
		assetArray.push(asset);
		var trackEvent 			= 	{ 'type' : '' + eventDataArray [0] + '', 'id' : '' + eventDataArray [1] + '', 'assets' : assetArray }
		eventArray.push(trackEvent);
		var analyticsData 		= 	{ 'id' : '' + payloadDataArray [1] + '', 'events' : eventArray, 'segments' : segmentArray }
		invokeAnalyticsAJAX ('c', '' + payloadDataArray [1] + '', analyticsData);
		$.removeCookie(cookieName, {path: contextPath});
	}

});
