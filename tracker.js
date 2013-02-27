// Modify these values
var siteID = 0;
var analyticsUrl = 'http://fast-escarpment-9659.herokuapp.com'
// Modify these values

var arriveTime;

window.onload = function() {
	arriveTime = new Date().getTime();
}

window.onbeforeunload = function() {
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 1) {
			console.log('The call to open(...) succeeded.');
		}
		if (xhr.readyState == 2) {
			console.log('The call to send(...) succeeded.  Waiting for response...');
		}
		if (xhr.readyState == 3) {
			console.log('The response is coming in!');
		}
		if (xhr.readyState == 4) {
			console.log('We now have the complete response: ' + xhr.response);
		}
	}
	
	var duration = ((new Date().getTime()) - arriveTime) / 1000.0;
	var params = 'url=' + location.pathname + '&duration=' + duration;
	xhr.open('POST', analyticsUrl + '/sites/' + siteID + '/visit', false);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send(params);
}