document.addEventListener("DOMContentLoaded", function() {

	// Params
	var scriptParam = document.getElementById('load_form');
	var id = scriptParam.dataset.formId;
	var appId = scriptParam.dataset.appId;
	var query = window.location.search;

	// iFrame
	var iframe = document.createElement('iframe');
	iframe.style.width = "100%";
	iframe.id = "giftFrame";
	iframe.frameBorder = "0";
	iframe.marginheight = "0";
	iframe.scrolling = "no";
	iframe.src = "http://localhost:3001/forms/" + id + "?request_url=" + window.location.href + "&app_id=" + appId + query;
	document.getElementById("form-wrapper").appendChild(iframe)
	
	// Create browser compatible event handler.
  	var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
  	var eventer = window[eventMethod];
  	var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";
  	// Listen for a message from the iframe.
  	eventer(messageEvent, function(event) {
	  	var origin = event.origin || event.originalEvent.origin;
	  	if (origin !== 'http://localhost:3001')
	  		return;
	  	var giftFrame = document.getElementById('giftFrame');
		var setHeight = (event.data + 30).toString();
		giftFrame.height = setHeight + 'px';
  	}, false);

});

// This is what should be put on the client's site
// <script id="load_form" src="https://localhost:3000/form-embed.js" data-page="1"></script>
// <div id="form-wrapper"></div>