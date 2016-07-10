// Ready DOM
document.addEventListener("DOMContentLoaded", function() {

	// Host
	var host = document.getElementById('host').value

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
	var xhttp = new XMLHttpRequest();
	xhttp.open("POST", host + "conversions?hit_time=" + current_time + "&identifier=" + identifier + "&school_id=" + school_id, true);
	xhttp.send();
	document.getElementById('conversion_identifier').value = identifier

	// Show designations on click
	document.getElementById("designate-link").addEventListener("click", function() {
		document.getElementById("designate-select").style.display = 'block';
	});

	// Initialize dropdown elements
	var select = document.getElementById("designate-select");
	var select_divs = select.getElementsByTagName("div");
	var dropdownOpen = false;

	select.addEventListener("click", function(event) {
		// If dropdown not open show all options
		if (!dropdownOpen) {
			showAll();
			dropdownOpen = true;
		// If dropdown open choose option
		} else {
			chooseOption(event.target);
	 		dropdownOpen = false;
		}
	})

	function chooseOption(div) {
		// Hide all options not chosen
		for (i = 0; i < select_divs.length; i++) {
			if (!(div.innerHTML == select_divs[i].innerHTML)) {
				select_divs[i].classList.remove('show-option')
				select_divs[i].classList.add('hide-option')
			}
		}
		// Connect Designations to Submission
		document.getElementById('designate').value = div.innerHTML
	}

	function showAll() {
		// Loop through and show all
		for (i = 0; i < select_divs.length; i++) {
			select_divs[i].classList.remove('hide-option')
			select_divs[i].classList.add('show-option')
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

	// Validations
	var form = document.getElementById("form")
	function validator(){
		if (document.getElementById('donor_info') == null) {
			res = validateForm();
			l = res.length;
			if (l == 0) {
				return true
			} else {
				resetErrors();
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
		var first_name = document.getElementById("donor_first_name");
		var last_name = document.getElementById("donor_last_name");
		var email = document.getElementById("donor_email");
		var phone_number = document.getElementById("donor_phone_number")
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

	if (document.getElementById('donor_info') == null) {
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
	 			console.log("Payment Received");
	 			if (validator()) {
		 			form.submit();
		 		} else {
		 			validator();
		 		}
			}
		});
	}

	document.getElementById("paypal-button").addEventListener("click", function(event) {
		event.preventDefault();
		paypalCheckout.paypal.initAuthFlow();
	});

	document.getElementById("paypal-cancel").addEventListener("click", function(event) {
		event.preventDefault();
		paypalCheckout.teardown();
		resetPayment();	
	});

	function resetPayment() {
		document.getElementById("card-payment").style.display = 'initial';
		document.getElementById("paypal-cancel").innerHTML = "";
		document.getElementById("paypal-email").innerHTML = "";
		document.getElementById("paypal-button").style.display = 'initial';
	}

	function paypalSuccess(email) {
		document.getElementById("paypal-button").style.display = 'none'
		document.getElementById("paypal-email").innerHTML = email
		document.getElementById("paypal-cancel").innerHTML = "change payment method"
		document.getElementById("card-payment").style.display = 'none'
	}

	if (document.getElementById('donor_info') != null) {
		document.getElementById('payment-container').style.display = 'none'
	}

});