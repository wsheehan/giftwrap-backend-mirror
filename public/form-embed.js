window.onload = function() {

	// Params
	var scriptParam = document.getElementById('load_form');
	var id = scriptParam.getAttribute('data-page');
	var query = window.location.search;
	console.log(query);

	// iFrame
	var iframe = document.createElement('iframe');
	iframe.style.width = "100%";
	//iframe.style.height = "1000px";
	iframe.id = "giftFrame";
	//newheight = document.getElementById(id).contentWindow.document .body.scrollHeight;
	//console.log(newheight)
	iframe.frameBorder = "0";
	iframe.scrolling = "no";
	iframe.src = "https://localhost:3000/forms/" + id + query;
	document.getElementById("form-wrapper").appendChild(iframe)
	//iframe.onload = autoResize("giftFrame");

	// Resize Function
	function autoResize(id){
	    var newheight;

	    if(document.getElementById){
	        newheight = document.getElementById(id).contentWindow.document .body.scrollHeight;
	        console.log(newheight)
	    }

	    document.getElementById(id).height = (newheight) + "px";
	    console.log("hello?")
	}
	
};

// This is what should be put on the client's site
// <script id="load_form" src="https://localhost:3000/form-embed.js" data-page="1"></script>
// <div id="form-wrapper"></div>