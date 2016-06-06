// DOM
$(document).ready(function() {

	// Show designations on click
	document.getElementById("designate-link").addEventListener("click", function() {
		document.getElementById("designate").style.display = 'initial'
	})

	// Connect 'Other' Text box to Checkbox
	$('#gift_total_other').click(function(){
		$('[for="gift_total_other"]').prop('checked', true)
	});
	$('#gift_total_other').on('change', function(){
		$('[for="gift_total_other"]').attr('value', $(this).val())
	});

	// Hide Payment on Pledge
	// $('[name="gift[gift_type]').click(function(){
	// 	console.log(this.id)
	// 	if (this.id == "gift_type_pledge") {
	// 		$('#braintree-dropin').hide(200);
	// 	} else {
	// 		$('#braintree-dropin').show(200);
	// 	}
	// })
	var gift_types = document.getElementsByName("gift[gift_type]")
	for (var i = 0; i < gift_types.length; i++) {
		gift_types[i].addEventListener("click", function() {
			dropin = document.getElementById("braintree-dropin")
			if (this.id == "gift_type_pledge") {
				dropin.style.display = 'none'
			} else {
				dropin.style.display = 'initial'
			}
		})
	}

	//Validations
	//$('#form').on('submit', function(){
	var form = document.getElementById("form")
	form.addEventListener("submit", function(event) {
		event.preventDefault()
		res = validateForm(this)
		l = res.length
		console.log(res)
		if (l == 0) {
			form.submit()
		} else {
			resetErrors();
			for (var i = 0; i < l; i++) {
				res[i][0].classList.add("input-error");
				document.getElementById(res[i][0].id + "_error").innerHTML = res[i][1];
			}
		}
	})

	function validateForm(form) {
		var first_name = document.getElementById("donor_first_name");
		var last_name = document.getElementById("donor_last_name");
		var email = document.getElementById("donor_email");
		var arr = []
		if (checkBlank(first_name)) {
			arr.push(checkBlank(first_name))
		}
		if (checkBlank(last_name)) {
			arr.push(checkBlank(last_name))
		}
		if (checkEmail(email)) {
			arr.push(checkEmail(email))
		}
		return arr
	}

	function checkBlank(input) {
		if (input.value.length === 0) {
			return [input, "Cannot be Blank"]
		}
	}

	function checkEmail(input) {
		var regex = /\S+@\S+\.\S+/;
		if (!regex.test(input.value)) {
			return [input, "Invalid Email"]
		}
	}

	function resetErrors() {
		var inputs = document.getElementsByClassName('form-input')
		for(var i = 0; i < inputs.length; i++) {
			inputs[i].classList.remove("input-error")
			document.getElementById(inputs[i].id + "_error").innerHTML = ""
		}
	}

})