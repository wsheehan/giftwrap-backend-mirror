

// Ready DOM
document.addEventListener("DOMContentLoaded", function() {

	// Show designations on click
	document.getElementById("designate-link").addEventListener("click", function() {
		document.getElementById("designate").style.display = 'initial';
	});

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
			dropin = document.getElementById("braintree-dropin");
			if (this.id == "gift_type_pledge") {
				dropin.style.display = 'none';
			} else {
				dropin.style.display = 'initial';
			}
		});
	}

	//Validations
	var form = document.getElementById("form")
	form.addEventListener("submit", function(event) {
		event.preventDefault();
		res = validateForm();
		l = res.length;
		console.log(res)
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

	function validateForm() {
		var first_name = document.getElementById("donor_first_name");
		var last_name = document.getElementById("donor_last_name");
		var email = document.getElementById("donor_email");
		var arr = [];
		if (checkBlank(first_name)) {
			arr.push(checkBlank(first_name));
		}
		if (checkBlank(last_name)) {
			arr.push(checkBlank(last_name));
		}
		if (checkEmail(email)) {
			arr.push(checkEmail(email));
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