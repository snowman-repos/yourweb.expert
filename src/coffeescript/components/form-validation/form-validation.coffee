class FormValidation

	constructor: ->

		@el =
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

		@validations =
			name: false
			email: false
			message: true

		@addEventListeners()

	addEventListeners: ->

		# Focus events

		@el.name.input.addEventListener "focus", =>

			@setFocus "name"

		@el.email.input.addEventListener "focus", =>

			@setFocus "email"

		@el.message.input.addEventListener "focus", =>

			@setFocus "message"

		# Blur events

		@el.name.input.addEventListener "blur", =>

			@getInputState "name"

		@el.email.input.addEventListener "blur", =>

			@getInputState "email"

		@el.message.input.addEventListener "blur", =>

			@getInputState "message"

		# Keyup events

		@el.name.input.addEventListener "keyup", =>

			@el.name.input.value = @sanitiseInput @el.name.input.value
			@setInputState "name"

		@el.email.input.addEventListener "keyup", =>

			@setInputState "email"

		@el.message.input.addEventListener "keyup", =>

			@setInputState "message"

	disableButton: ->

		@el.button.classList.add "is-disabled"

	enableButton: ->

		@el.button.classList.remove "is-disabled"

	getInputState: (input) ->

		@el[input].group.classList.remove "is-in-focus"

		if input isnt "message"

			if @validations[input]
				@setComplete input
			else
				@el[input].group.classList.remove "is-complete"
				@showError input

		else

			@setComplete input

	hideAllNotifications: ->

		for name, node of @el.notifications
			node.classList.add "is-hidden"

	removeAllErrors: ->

		errors = document.querySelectorAll ".o-form__error"

		for error in errors
			error.parentNode.removeChild error

	sanitiseInput: (input) ->

		input.replace /[\/!@#£\$\%\^&*0-9()\[\]+~?<>.|\"]+/, ""

	setComplete: (input) ->

		if @validateInput @el[input].input.value
			@el[input].group.classList.add "is-complete"

	setFocus: (input) ->

		@el[input].group.classList.add "is-in-focus"
		@el[input].group.classList.remove "is-complete"
		@el[input].group.classList.remove "is-error"

	setInputState: (input) ->

		if input isnt "message" then @validations[input] = @validateInput @el[input].input.value
		@validateForm()

	showError: (input) ->

		@el[input].group.classList.add "is-error"

		errors = @el[input].group.querySelectorAll ".o-form__error"

		if errors.length is 0
			error = document.createElement "div"
			error.classList.add "o-form__error"
			error.classList.add "c-contact__form__error"
			error.innerText = @el[input].input.dataset.error
			@el[input].group.appendChild error

	showNotifcation: (notification) ->

		@hideAllNotifications()

		if @el.form.classList.contains "is-sending" or @el.form.classList.contains "is-sent"

			switch notification
				when "sending" then @el.notifications.sending.classList.remove "is-hidden"
				when "sent" then @el.notifications.sent.classList.remove "is-hidden"

	validateForm: ->

		if @validations.name and @validations.email and @validations.message
			@enableButton()
			@removeAllErrors()
		else
			@disableButton()

	validateInput: (input) ->

		input isnt ""


module.exports = new FormValidation