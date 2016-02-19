api = require "../api/api.coffee"

###*
 * This class handles the validation logic
 * and styling for the contact form and the
 * login form.
###
class FormValidation

	constructor: ->

		# Gather all relevant DOM nodes.
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

		# This object will contain validation
		# state for all inputs.
		@validations =
			contactForm: {}
			loginForm: {}

		if @el.contactForm.form
			@resetForm "contactForm"

		if @el.loginForm.form
			@resetForm "loginForm"

		# Only add event listeners if required.
		if @el.contactForm.form and @el.loginForm.form
			@addEventListeners()

	###*
	 * Add event listeners to buttons and inputs.
	###
	addEventListeners: ->

		# Button click events

		@el.contactForm.button.addEventListener "click", (e) =>

			e.preventDefault()
			@submitContactForm()

		@el.loginForm.button.addEventListener "click", (e) =>

			e.preventDefault()
			@login()

		# Focus events - when inputs are focused
		# then error and completion states should
		# be removed.

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

		# Blur events - Forms should be validated
		# when each input loses focus.

		@el.contactForm.name.input.addEventListener "blur", =>

			@setInputState "contactForm", "name"

		@el.contactForm.email.input.addEventListener "blur", =>

			@setInputState "contactForm", "email"

		@el.contactForm.message.input.addEventListener "blur", =>

			@setInputState "contactForm", "message"

		@el.loginForm.email.input.addEventListener "blur", =>

			@setInputState "loginForm", "email"

		@el.loginForm.password.input.addEventListener "blur", =>

			@setInputState "loginForm", "password"

		# Keyup events - Inputs should be validated
		# every time the user types something.

		@el.contactForm.name.input.addEventListener "keyup", =>

			@el.contactForm.name.input.value = @sanitiseInput @el.contactForm.name.input.value
			@setInputValidationState "contactForm", "name"

		@el.contactForm.email.input.addEventListener "keyup", =>

			@setInputValidationState "contactForm", "email"

		@el.contactForm.message.input.addEventListener "keyup", =>

			@setInputValidationState "contactForm", "message"

		@el.loginForm.email.input.addEventListener "keyup", =>

			@setInputValidationState "loginForm", "email"

		@el.loginForm.password.input.addEventListener "keyup", =>

			@setInputValidationState "loginForm", "password"

	###*
	 * Set the disabled state on a button.
	 * @param  {String} form A reference to the form in which the button resides
	 * @return {Object}      The disabled button element
	###
	disableButton: (form) ->

		@el[form].button.classList.add "is-disabled"

	###*
	 * Remove the disabled state on a button
	 * @param  {String} form A reference to the form in which the button resides
	 * @return {Object}      The enabled button element
	###
	enableButton: (form) ->

		@el[form].button.classList.remove "is-disabled"

	###*
	 * Check if a form is valid by checking the
	 * validation states of each input element.
	 * @param  {String} form A reference to the form
	 * @return {Boolean}     The form's validation state
	###
	formIsValid: (form) ->

		valid = true
		for input, validation of @validations[form]
			if not validation then valid = false
		valid

	###*
	 * Generate an error message DOM node. The
	 * message text is taken from the 'error'
	 * data-attribute on the input element.
	 * @param  {String} form  A reference to the form on which the error message is to be displayed
	 * @param  {String} input A reference to the input for which the error message is to be displayed
	 * @return {Object}       The error message DOM node
	###
	getError: (form, input) ->

		error = document.createElement "div"
		error.classList.add "o-form__error-message"
		error.innerText = @el[form][input].input.dataset.error
		error

	###*
	 * Hide all form notifications on the page.
	 * @return {Object} The DOM node for the last notification that gets hidden.
	###
	hideAllNotifications: ->

		for form, inputs of @el

			for input, elements of inputs

				if input is "notifications"

					for name, node of elements

						node.classList.add "is-hidden"

	###*
	 * Process the login form.
	###
	login: ->

		if @formIsValid "loginForm"

			@hideAllNotifications()
			@setFormIsSending "loginForm", "logging in"

			# pretend it's sent
			setTimeout =>

				@hideAllNotifications()
				@el.loginForm.form.querySelector(".o-form").classList.remove "is-sending"

				# just show error state for now
				# TODO: the form data should be submitted to the server.
				@el.loginForm.form.classList.add "is-error"
				inputGroups = @el.loginForm.form.querySelectorAll(".o-form__input-group")
				for inputGroup in inputGroups
					inputGroup.classList.remove "is-complete"
					inputGroup.classList.add "is-error"

			, 3000

		else
			console.error "invalid input data"

	###*
	 * Remove all error messages from the DOM.
	 * @return {Object} The DOM node for the last input group from which an error message is removed
	###
	removeAllErrors: ->

		errors = document.querySelectorAll ".o-form__error-message"

		for error in errors
			error.parentNode.removeChild error

	###*
	 * Delete the input value and reset the state
	 * of the input group.
	 * @param {String} form  A reference to the form in which the input resides
	 * @param {String} input A reference to the input
	###
	resetInput: (form, input) ->

		@el[form][input].input.value = ""
		@el[form][input].group.classList.remove "is-complete"
		@el[form][input].group.classList.remove "is-error"
		@el[form][input].group.classList.remove "is-in-focus"

	###*
	 * Reset the form, removing all states from input
	 * groups, all input validation states and input
	 * values.
	 * @param {String} form  A reference to the form
	###
	resetForm: (form) ->

		@el[form].form.classList.remove "is-error"
		@el[form].form.classList.remove "is-sent"
		@el[form].form.classList.remove "is-sending"

		if form is "loginForm"
			@el[form].form.querySelector(".o-form").classList.remove "is-sending"

		for input, element of @el[form]

			if input isnt  "button" and
			input isnt "form" and
			input isnt "notifications"

				@validations[form][input] = false
				@resetInput form, input

		@disableButton form

	###*
	 * Remove special characters from a form input
	 * value.
	 * @param  {String} input The input value
	 * @return {String}       The sanitised input value
	###
	sanitiseInput: (input) ->

		input.replace /[\/!@#£\$\%\^&*0-9()\[\]+~?<>:\.|\"]+/g, ""

	###*
	 * Set the complete state on a form group.
	 * @param {String} form  A reference to the form
	 * @param {String} input A reference to the input
	###
	setComplete: (form, input) ->

		@el[form][input].group.classList.add "is-complete"
		@el[form][input].group.classList.remove "is-error"
		@el[form][input].group.classList.remove "is-in-focus"

	###*
	 * Set the error state on a form group.
	 * @param {String} form  A reference to the form
	 * @param {String} input A reference to the input
	###
	setError: (form, input) ->

		@el[form][input].group.classList.add "is-error"
		@el[form][input].group.classList.remove "is-complete"
		@el[form][input].group.classList.remove "is-in-focus"

	###*
	 * Set the focus state on a form group.
	 * @param {String} form  A reference to the form
	 * @param {String} input A reference to the input
	###
	setFocus: (form, input) ->

		@el[form][input].group.classList.add "is-in-focus"
		@el[form][input].group.classList.remove "is-complete"
		@el[form][input].group.classList.remove "is-error"

	###*
	 * Set the sending state on a form and show the
	 * appropriate notification.
	 * @param {String} form  A reference to the form
	 * @param {String} input A reference to the notification to display
	###
	setFormIsSending: (form, notification) ->

		@el[form].form.classList.remove "is-error"
		@el[form].form.classList.remove "is-sent"
		@el[form].form.classList.add "is-sending"

		# This is because we set the .js-form class on the dialog
		# rather than the form for the Login form, because we want
		# to set the error state on the dialog to make it shake :)
		if form is "loginForm"
			@el[form].form.querySelector(".o-form").classList.add "is-sending"

		@showNotifcation notification

	###*
	 * Set the sent state on a form group and show the
	 * appropriate notification.
	 * @param {String} form  A reference to the form
	###
	setFormIsSent: (form) ->

		@hideAllNotifications()
		@el[form].form.classList.remove "is-error"
		@el[form].form.classList.remove "is-sending"
		@el[form].form.classList.add "is-sent"
		@showNotifcation "sent"

		# After 10 seconds, remove the notification
		# and reset the form.
		setTimeout =>

			@resetForm form
			@hideAllNotifications()

		, 10000

	###*
	 * Apply stateful classeto the input group
	 * based on the input's validation state.
	 * @param  {String} form  A reference to the form
	 * @param  {String} input A reference to the input
	 * @return {Object}       The updated input group DOM node
	###
	setInputState: (form, input) ->

		@el[form][input].group.classList.remove "is-in-focus"

		if input isnt "message"

			if @validations[form][input]
				@setComplete form, input
			else
				@el[form][input].group.classList.remove "is-complete"
				@showError form, input

		else

			@setComplete form, input

	###*
	 * Determine whether the input is valid and
	 * update the validation state object accordingly.
	 * This function essentially lists the validation
	 * rules for each type of input.
	 * @param {String} form  A reference to the form
	 * @param {String} input A reference to the input
	###
	setInputValidationState: (form, input) ->

		# Email is required and should be a valid
		# Email address
		if input is "email"
			isntBlank = @validateIsntBlank @el[form][input].input.value
			isValidEmail = @validateEmail @el[form][input].input.value
			@validations[form][input] = isntBlank and isValidEmail

		# Message is optional - validation always set
		# to true
		if input is "message"
			@validations[form][input] = true

		# Name is required
		if input is "name"
			@validations[form][input] = @validateIsntBlank @el[form][input].input.value

		# Password is required
		if input is "password"
			@validations[form][input] = @validateIsntBlank @el[form][input].input.value

		# Once we've updated the validation state
		# of this input, check if the form has become
		# valid
		@validateForm form

	###*
	 * Display an error message above an input field
	 * and set the error state on the input group.
	 * @param  {String} form  A reference to the form
	 * @param  {String} input A reference to the input
	 * @return {Object}       The DOM node for the input group to which the error message was appended
	###
	showError: (form, input) ->

		@setError form, input

		if form isnt "loginForm"

			errors = @el[form][input].group.querySelectorAll ".o-form__error-message"

			if errors.length is 0
				@el[form][input].group.appendChild @getError form, input

	###*
	 * Display a notification.
	 * @param  {String} notification A reference to the notification
	 * @return {Object}              The DOM node for the notification
	###
	showNotifcation: (notification) ->

		switch notification
			when "logging in" then @el.loginForm.notifications.loggingIn.classList.remove "is-hidden"
			when "sending" then @el.contactForm.notifications.sending.classList.remove "is-hidden"
			when "sent" then @el.contactForm.notifications.sent.classList.remove "is-hidden"

	###*
	 * Process the contact form.
	###
	submitContactForm: ->

		if @formIsValid "contactForm"

			@setFormIsSending "contactForm", "sending"

			url = api.getURL "email"

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

					@setFormIsSent "contactForm"

		else
			console.error "invalid input data"

	###*
	 * Check an email address is valid.
	 * @param  {String} input The input value
	 * @return {Boolean}      The validation state of the input
	###
	validateEmail: (input) ->

		regex = /[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
		regex.test input

	###*
	 * Update a form based on its validation state.
	 * @param  {String} form  A reference to the form
	###
	validateForm: (form) ->

		if @formIsValid form
			@enableButton form
			@removeAllErrors()
		else
			@disableButton form

	###*
	 * Check that input isn't empty.
	 * @param  {String} input The input value
	 * @return {Boolean}      The validation state of the input value
	###
	validateIsntBlank: (input) ->

		input isnt ""


module.exports = new FormValidation