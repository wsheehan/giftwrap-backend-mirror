// DOM
$(document).ready(function() {

	$('#designate-link').click(function(){
		$('#designate').show(250)
	});

	$('#gift_total_other').click(function(){
		$('[for="gift_total_other"]').prop('checked', true)
	});

})