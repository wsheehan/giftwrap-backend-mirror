// Ready DOM
document.addEventListener("DOMContentLoaded", function() {

	// Variables
	var host = document.getElementById('host').value
	var first_name = document.getElementById("donor_first_name");
	var last_name = document.getElementById("donor_last_name");
	var email = document.getElementById("donor_email");
	var phone_number = document.getElementById("donor_phone_number")

	// Height Message
	function sendHeight() {
	    if (parent.postMessage) {
	        var height= document.getElementById('form').offsetHeight;
	        parent.postMessage(height, 'https://localhost:8000');
	    }
	}
	// Create browser compatible event handler.
	var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
	var eventer = window[eventMethod];
	var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";

	// Listen for a message from the iframe.
	eventer(messageEvent, function(event) {
	    sendHeight();
	}, 
	false);

	// Initiate page hit
	var school_id = document.getElementById("school_id").value
	var current_time = Date()
	var identifier = Math.random().toString(36).slice(2)
	var newConversion = new XMLHttpRequest();
	newConversion.open("POST", host + "conversions?hit_time=" + current_time + "&identifier=" + identifier + "&school_id=" + school_id, true);
	newConversion.send();
	document.getElementById('conversion_identifier').value = identifier

	// Find Email on blur
	if (email) {
		email.addEventListener('blur', function() {
			var donor = null;
			var checkEmail = new XMLHttpRequest();
			checkEmail.onreadystatechange = function() {
				if (checkEmail.readyState == 4 && checkEmail.status == 200) {
					donor = checkEmail.responseText;
					showDonor(JSON.parse(donor));
				}
			};
			checkEmail.open("POST", host + school_id + "/find_by_email?donor_email=" + encodeURIComponent(email.value), true);
			checkEmail.send();
		})
	}

	// Handle if Email Found
	function showDonor(donor) {
		if (donor) {
			document.getElementById('inputs-wrapper').innerHTML = '<div id="donor_info"> \
			<p>Welcome Back ' + donor.first_name + ' ' + donor.last_name + '!</p></div>  \
			<input type="hidden" name="donor[email]" value=' + donor.email + '>        \
			<input type="hidden" name="donor[first_name]" value='  + donor.first_name + '> \
			<input type="hidden" name="donor[last_name]" value='  + donor.last_name + '>';
			if (donor.braintree_customer_id) {
				// Do something with payment info
			}
		}
	}

	// Connect 'Other' Text box to Checkbox
	var gift_total_other = document.getElementById("gift_total_other")
	gift_total_other.addEventListener('change', function() {
		document.getElementById("gift_other_box").value = this.value;
	});
	gift_total_other.addEventListener('click', function() {
		document.getElementById("gift_other_box").checked = true;
	});

	// Show Pledge options on click
	document.getElementById("gift-type-link").addEventListener("click", function() {
		document.getElementById("gift-type").style.display = 'block';
	})

	// Hide Payment on Pledge
	var gift_types = document.getElementsByName("gift[gift_type]")
	for (var i = 0; i < gift_types.length; i++) {
		gift_types[i].addEventListener("click", function() {
			dropin = document.getElementById("payment-container");
			if (this.id == "gift_type_pledge") {
				dropin.style.display = 'none';
			} else {
				dropin.style.display = 'block';
			}
		});
	}

	// Show designations on click
	document.getElementById("designate-link").addEventListener("click", function() {
		document.getElementById("designate-select").style.display = 'inline-block';
	});

	// 'Other Designation'
	var select_other = false;
	document.getElementById('designate-select').addEventListener('change', function(e){
		if (e.target.value === 'Other') {
			select_other = true;
			document.getElementById('designation_other').style.display = 'inline-block';
		} else {
			if (select_other) {
				document.getElementById('designation_other').style.display = 'none';
			}
		}
	});

	document.getElementById('designation_other').addEventListener('change', function() {
		document.getElementById('other_select').value = this.value
	});

	// Validations
	var form = document.getElementById("form")
	function validator(){
		resetErrors();
		if (document.getElementById('donor_info') == null) {
			res = validateForm();
			l = res.length;
			if (l == 0) {
				return true
			} else {
				for (var i = 0; i < l; i++) {
					res[i][0].classList.add("input-error");
					document.getElementById(res[i][0].id + "_error").innerHTML = res[i][1];
				}
				return false
			}
		} else {
			// Existing donor Error Suite
			return true
		}
	}

	function validateForm() {
		var arr = [];

		var first_blank = checkBlank(first_name)
		if (first_blank) { arr.push(first_blank) }

		var last_blank = checkBlank(last_name)
		if (last_blank) { arr.push(last_blank) }

		var check_email = checkEmail(email)
		if (check_email) { arr.push(check_email) }

		var phone_blank = checkBlank(phone_number)
		if (phone_blank) { arr.push(phone_blank) }

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
			inputs[i].classList.remove("input-error");
			document.getElementById(inputs[i].id + "_error").innerHTML = "";
		}
	}

	// Braintree
	var isPaymentMethod = false;
	if (document.getElementById('saved-payment') === null) {
		braintreeInit();
	}

	// If no payment method still do errors
	document.getElementById("submit-button").addEventListener("click", function() {
		if (!isPaymentMethod) {
			validator();
			//paymentEmpty();
		}
	})

	function braintreeInit() {
		var paypalCheckout;
		var token = document.getElementById("client_token").value
		braintree.setup(token, "custom", {
			id: "form",
			paypal: {
				headless: true,
				onSuccess: function(nonce, email) {
					paypalSuccess(email);
				}
			},
			hostedFields: {
				styles: {
					'input': {
						'font-size': '16px'
					},
					'.valid': {
						'color': 'green'
					},
					'.invalid': {
						'color': 'red'
					}
				},
				number: {
					selector: "#card-number",
					placeholder: "4111 1111 1111 1111"
				},
				expirationDate: {
					selector: "#exp-date",
					placeholder: "MM/YY"
				}
			},
			onReady: function(integration) {
				paypalCheckout = integration;
			},
			onPaymentMethodReceived: function (payload) {
	 			document.getElementById("nonce").value = payload['nonce']
	 			isPaymentMethod = true;
	 			if (validator()) {
		 			form.submit();
		 		} else {
		 			validator();
		 		}
			}
		});

		function paymentEmpty() {
			document.getElementById("payment-error").style.display = 'block'
		}

		document.getElementById("paypal-button").addEventListener("click", function(event) {
			event.preventDefault();
			paypalCheckout.paypal.initAuthFlow();
		});
	}


	function resetPayment() {
		document.getElementById("card-payment").style.display = 'block';
		document.getElementById("paypal-email").innerHTML = "";
		document.getElementById("paypal-button").style.display = 'block';
		document.getElementById("paypal-info").style.display = 'none'
	}

	function paypalSuccess(email) {
		document.getElementById("paypal-button").style.display = 'none'
		document.getElementById("paypal-email").innerHTML = email
		document.getElementById("card-payment").style.display = 'none'
		document.getElementById("paypal-info").style.display = 'block'
	}

});