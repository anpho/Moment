var request;
function getTEXT(url, callback) {
	request = new XMLHttpRequest();
	request.onreadystatechange = function() {
		pind.value=request.readyState;
		if (request.readyState === XMLHttpRequest.DONE) {
			if (request.status === 200) {
				console.log("Response = " + request.responseText);
				callback(request.responseText);
			} else {
				console.log("Status: " + request.status
						+ ", Status Text: " + request.statusText);
				callback(null);
			}
		}
	}
	request.open("GET", url, true);
	request.send();
}
