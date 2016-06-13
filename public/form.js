

// Ready DOM
document.addEventListener("DOMContentLoaded", function() {

	// Show designations on click
	document.getElementById("designate-link").addEventListener("click", function() {
		document.getElementById("designate-select").style.display = 'block';
	});

	var select = document.getElementById("designate-select");
	var select_divs = select.getElementsByTagName("div");
	var dropdownOpen = false;

	select.addEventListener("click", function(event) {
		console.log(event.target.innerHTML)
		if (!dropdownOpen) {
			showAll();
			dropdownOpen = true;
			console.log(dropdownOpen)
		} else {
			chooseOption(event.target);
	 		dropdownOpen = false;
		}
	})

	function chooseOption(div) {
		for (i = 0; i < select_divs.length; i++) {
			if (!(div.innerHTML == select_divs[i].innerHTML)) {
				//select_divs[i].style.display = 'none';
				select_divs[i].classList.remove('show-option')
				select_divs[i].classList.add('hide-option')
			}
		}
		document.getElementById('designate').value = div.innerHTML
		console.log(document.getElementById('designate').value)
	}

	function showAll() {
		for (i = 0; i < select_divs.length; i++) {
			//select_divs[i].style.display = 'block';
			select_divs[i].classList.remove('hide-option')
			select_divs[i].classList.add('show-option')
		}
	}

	// Connect Designations to Submission

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
				dropin.style.display = 'initial';
			}
		});
	}

	// Validations
	// if (document.getElementById('donor_info') == undefined) {
		var form = document.getElementById("form")
		form.addEventListener("submit", function(event) {
			event.preventDefault();
			res = validateForm();
			l = res.length;
			if (l == 0) {
				form.submit();
			} else {
				resetErrors();
				for (var i = 0; i < l; i++) {
					res[i][0].classList.add("input-error");
					document.getElementById(res[i][0].id + "_error").innerHTML = res[i][1];
				}
			}
		});
	// }

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
 			createHiddenNonce(payload);
		}
	});

	document.getElementById("paypal-button").addEventListener("click", function(event) {
		event.preventDefault();
		paypalCheckout.paypal.initAuthFlow();
	});

	document.getElementById("paypal-cancel").addEventListener("click", function(event) {
		event.preventDefault();
		paypalCheckout.teardown();
		resetPayment();	
	})

	function createHiddenNonce(payload) {
	    var form = document.getElementById("form");
	    var input = document.createElement("input");
	    input.type = "hidden";
	    input.name = "payment_method_nonce";
	    input.value = payload["nonce"];
	    form.appendChild(input)
	}

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

});