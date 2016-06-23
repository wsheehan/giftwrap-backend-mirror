// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

	document.getElementById("campaign_title").onkeyup = function() {
		document.getElementById("title-preview").getElementsByTagName('span')[0].innerHTML = this.value
	}
	document.getElementById("campaign_body").onkeyup = function() {
		document.getElementById("body-preview").innerHTML = this.value
	}

	$(".donorlist-show").click(function(){
		$(".check-mark", this).toggleClass("checked")
	})
	// checkMarks = document.getElementsByClassName("check-mark")
	// for (i = 0; i < checkMarks.length; i++) {
	// 	checkMarks[i].addEventListener('click', function() {
	// 		this.style.backgroundColor = 'red';
	// 		console.log("hello")
	// 	});
	// }

});

