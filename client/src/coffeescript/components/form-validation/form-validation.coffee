api = require "../api/api.coffee"

class FormValidation

	constructor: ->

		@el =
			contactForm:
				button: document.querySelector ".js-form-submit"
				email:
					group: document.querySelector ".js-email"
					input: document.querySelector ".js-email-input"
				form: document.querySelector ".js-form"
				message:
					group: document.querySelector ".js-message"
					input: document.querySelector ".js-message-input"
				name:
					group: document.querySelector ".js-name"
					input: document.querySelector ".js-name-input"
				notifications:
					sending: document.querySelector ".js-sending-form"
					sent: document.querySelector ".js-sent-form"
			loginForm:
				button: document.querySelector ".js-login-button"
				email:
					group: document.querySelector ".js-login-email"
					input: document.querySelector ".js-login-email-input"
				form: document.querySelector ".js-login-form"
				password:
					group: document.querySelector ".js-login-password"
					input: document.querySelector ".js-login-password-input"
				notifications:
					loggingIn: document.querySelector ".js-logging-in"

		@validations =
			contactForm: {}
			loginForm: {}

		if @el.contactForm.form
			@resetForm "contactForm"

		if @el.loginForm.form
			@resetForm "loginForm"

		if @el.contactForm.form and @el.loginForm.form
			@addEventListeners()

	addEventListeners: ->

		# Click events

		@el.contactForm.button.addEventListener "click", (e) =>

			e.preventDefault()
			@submitContactForm()

		@el.loginForm.button.addEventListener "click", (e) =>

			e.preventDefault()
			@login()

		# Focus events

		@el.contactForm.name.input.addEventListener "focus", =>

			@setFocus "contactForm", "name"

		@el.contactForm.email.input.addEventListener "focus", =>

			@setFocus "contactForm", "email"

		@el.contactForm.message.input.addEventListener "focus", =>

			@setFocus "contactForm", "message"

		@el.loginForm.email.input.addEventListener "focus", =>

			@setFocus "loginForm", "email"

		@el.loginForm.password.input.addEventListener "focus", =>

			@setFocus "loginForm", "password"

		# Blur events

		@el.contactForm.name.input.addEventListener "blur", =>

			@getInputState "contactForm", "name"

		@el.contactForm.email.input.addEventListener "blur", =>

			@getInputState "contactForm", "email"

		@el.contactForm.message.input.addEventListener "blur", =>

			@getInputState "contactForm", "message"

		@el.loginForm.email.input.addEventListener "blur", =>

			@getInputState "loginForm", "email"

		@el.loginForm.password.input.addEventListener "blur", =>

			@getInputState "loginForm", "password"

		# Keyup events

		@el.contactForm.name.input.addEventListener "keyup", =>

			@el.contactForm.name.input.value = @sanitiseInput @el.contactForm.name.input.value
			@setInputState "contactForm", "name"

		@el.contactForm.email.input.addEventListener "keyup", =>

			@setInputState "contactForm", "email"

		@el.contactForm.message.input.addEventListener "keyup", =>

			@setInputState "contactForm", "message"

		@el.loginForm.email.input.addEventListener "keyup", =>

			@setInputState "loginForm", "email"

		@el.loginForm.password.input.addEventListener "keyup", =>

			@setInputState "loginForm", "password"

	disableButton: (form) ->

		@el[form].button.classList.add "is-disabled"

	enableButton: (form) ->

		@el[form].button.classList.remove "is-disabled"

	getInputState: (form, input) ->

		@el[form][input].group.classList.remove "is-in-focus"

		if input isnt "message"

			if @validations[form][input]
				@setComplete form, input
			else
				@el[form][input].group.classList.remove "is-complete"
				@showError form, input

		else

			@setComplete form, input

	hideAllNotifications: ->

		for name, node of @el.contactForm.notifications
			node.classList.add "is-hidden"

		for name, node of @el.loginForm.notifications
			node.classList.add "is-hidden"

	login: ->

		if true #fake the login for now

			@el.loginForm.form.classList.remove "is-error"

			@hideAllNotifications()
			@el.loginForm.form.querySelector(".o-form").classList.add "is-sending"
			@showNotifcation "logging in"

			# pretend it's sent
			setTimeout =>

				@hideAllNotifications()
				@el.loginForm.form.querySelector(".o-form").classList.remove "is-sending"

				# just show error for now
				@el.loginForm.form.classList.add "is-error"
				inputGroups = @el.loginForm.form.querySelectorAll(".o-form__input-group")
				for inputGroup in inputGroups
					inputGroup.classList.remove "is-complete"
					inputGroup.classList.add "is-error"

			, 3000

		else
			console.error "invalid input data"

	removeAllErrors: ->

		errors = document.querySelectorAll ".o-form__error-message"

		for error in errors
			error.parentNode.removeChild error

	resetForm: (form) ->

		if form is "contactForm"

			@validations["contactForm"] =
				name: false
				email: false
				message: true

			@el.contactForm.name.input.value = ""
			@el.contactForm.name.group.classList.remove "is-complete"
			@el.contactForm.email.input.value = ""
			@el.contactForm.email.group.classList.remove "is-complete"
			@el.contactForm.message.input.value = ""
			@el.contactForm.message.group.classList.remove "is-complete"

		else if form is "loginForm"

			@validations["loginForm"] =
				email: false
				password: false

		@disableButton form

	sanitiseInput: (input) ->

		input.replace /[\/!@#£\$\%\^&*0-9()\[\]+~?<>.|\"]+/, ""

	setComplete: (form, input) ->

		if @validateInput @el[form][input].input.value
			@el[form][input].group.classList.add "is-complete"

	setFocus: (form, input) ->

		@el[form][input].group.classList.add "is-in-focus"
		@el[form][input].group.classList.remove "is-complete"
		@el[form][input].group.classList.remove "is-error"

	setInputState: (form, input) ->

		if input isnt "message" then @validations[form][input] = @validateInput @el[form][input].input.value
		@validateForm form

	showError: (form, input) ->

		if form isnt "loginForm"

			@el[form][input].group.classList.add "is-error"

			errors = @el[form][input].group.querySelectorAll ".o-form__error-message"

			if errors.length is 0
				error = document.createElement "div"
				error.classList.add "o-form__error-message"
				if form is "contactForm" then error.classList.add "c-contact__form__error"
				error.innerText = @el[form][input].input.dataset.error
				@el[form][input].group.appendChild error

	showNotifcation: (notification) ->

		switch notification
			when "logging in" then @el.loginForm.notifications.loggingIn.classList.remove "is-hidden"
			when "sending" then @el.contactForm.notifications.sending.classList.remove "is-hidden"
			when "sent" then @el.contactForm.notifications.sent.classList.remove "is-hidden"

	submitContactForm: ->

		if @validations.contactForm.name and @validations.contactForm.email and @validations.contactForm.message

			@el.contactForm.form.classList.add "is-sending"

			@showNotifcation "sending"

			# send form

			url = api.getURL() + "/email"

			dataToSend =
				message: @el.contactForm.message.input.value
				senderName: @el.contactForm.name.input.value
				senderEmail: @el.contactForm.email.input.value

			fetch url,
				body: JSON.stringify dataToSend
				headers:
					"Accept": "application/json"
					"Content-Type": "application/json"
				method: "post"
			.then (response) ->
				response.json()
			.then (data) =>

				if data is "sent"

					@hideAllNotifications()
					@el.contactForm.form.classList.remove "is-sending"
					@el.contactForm.form.classList.add "is-sent"
					@showNotifcation "sent"

					setTimeout =>

						@resetForm "contactForm"
						@el.contactForm.form.classList.remove "is-sent"
						@hideAllNotifications()

					, 10000

		else
			console.error "invalid input data"

	validateForm: (form) ->

		if form is "contactForm"

			if @validations.contactForm.name and @validations.contactForm.email and @validations.contactForm.message
				@enableButton form
				@removeAllErrors()
			else
				@disableButton form

		else if form is "loginForm"

			if @validations.loginForm.email and @validations.loginForm.password

				@enableButton form

			else

				@disableButton form

	validateInput: (input) ->

		input isnt ""


module.exports = new FormValidation