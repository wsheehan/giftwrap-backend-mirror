// DOM
$(document).ready(function() {

	// Show designations on click
	$('#designate-link').click(function(){
		$('#designate').show(250)
	});

	// Connect 'Other' Text box to Checkbox
	$('#gift_total_other').click(function(){
		$('[for="gift_total_other"]').prop('checked', true)
	});
	$('#gift_total_other').on('change', function(){
		$('[for="gift_total_other"]').attr('value', $(this).val())
	});

	// Hide Payment on Pledge
	$('[name="gift[gift_type]').click(function(){
		console.log(this.id)
		if (this.id == "gift_type_pledge") {
			$('#braintree-dropin').hide(200);
		} else {
			$('#braintree-dropin').show(200);
		}
	})

})