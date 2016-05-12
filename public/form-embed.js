window.onload = function() {

	// Params
	var scriptPram = document.getElementById('load_form');
	var id = scriptPram.getAttribute('data-page');
	var query = window.location.search;

	// iFrame
	var iframe = document.createElement('iframe');
	iframe.style.width = "100%";
	iframe.style.height = "500px";
	iframe.frameBorder = "0";
	iframe.scrolling = "no";
	iframe.src = "https://localhost:3000/forms/" + id + query;
	document.getElementById("form-wrapper").appendChild(iframe);
	
};

// This is what should be put on the client's site
// <script id="load_form" src="https://localhost:3000/form-embed.js" data-page="1"></script>
// <div id="form-wrapper"></div>