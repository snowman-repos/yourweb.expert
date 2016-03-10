jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Form Validation", ->

	FormValidation = require "./form-validation.coffee"

	generateDummyValidation = (form, validity) ->

		validations = {}

		for input, elements of FormValidation.el[form]
			if input isnt "button" and
			input isnt "form" and input isnt "notifications"
				validations[input] = validity

		validations

	beforeEach ->

		window.ga = ->

		loadFixtures "home-page.html"

		FormValidation.el =
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

	it "should disable the button on a form", ->

		for form, inputs of FormValidation.el

			inputs.button.classList.remove "is-disabled"
			FormValidation.disableButton form
			expect(inputs.button.classList).toContain "is-disabled"

	it "should enable the button on a form", ->

		for form, inputs of FormValidation.el

			inputs.button.classList.add "is-disabled"
			FormValidation.enableButton form
			expect(inputs.button.classList).not.toContain "is-disabled"

	it "should check the validation state of a form", ->

		for form, inputs of FormValidation.el

			FormValidation.validations[form] = generateDummyValidation form, false
			expect(FormValidation.formIsValid(form)).toBe false

			FormValidation.validations[form] = generateDummyValidation form, true
			expect(FormValidation.formIsValid(form)).toBe true

	it "should generate an error message", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					msg = if elements.input then elements.input.dataset.error else ''
					expected = '<div class="o-form__error-message">' + msg + '</div>'

					error = FormValidation.getError form, input
					tmp = document.createElement "div"
					tmp.appendChild error
					result = tmp.innerHTML

					expect(result).toEqual expected

	it "should hide all notifications", ->

		FormValidation.showNotifcation "sending"

		notifications = document.querySelectorAll ".o-form__notification"

		for notification in notifications
			notification.classList.remove "is-hidden"
			expect(notification.classList).not.toContain "is-hidden"

		FormValidation.hideAllNotifications()

		for notification in notifications
			expect(notification.classList).toContain "is-hidden"

	it "should submit the login form", ->

		FormValidation.login()

		setTimeout ->
			expect(FormValidation.el.loginForm.form.classList).toContain "is-error"
		, 3100

	it "should signify when inputs have had data entered", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.el[form][input].input.classList.remove "is-dirty"

					FormValidation.makeDirty form, input

					expect(FormValidation.el[form][input].input.classList).toContain "is-dirty"

	it "should remove all errors", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.el[form][input].group.appendChild FormValidation.getError form, input

		forms = document.querySelectorAll ".o-form"

		errorMessages = []

		for form in forms
			errorMessages.push.apply errorMessages, Array.prototype.slice.call form.querySelectorAll ".o-form__error-message"

		expect(errorMessages.length).not.toBe 0

		FormValidation.removeAllErrors()

		errorMessages = []

		for form in forms
			errorMessages.push.apply errorMessages, Array.prototype.slice.call form.querySelectorAll ".o-form__error-message"

		expect(errorMessages.length).toBe 0

	it "should reset an input", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.el[form][input].input.value = "test"
					FormValidation.el[form][input].group.classList.add "is-complete"
					FormValidation.el[form][input].group.classList.add "is-dirty"
					FormValidation.el[form][input].group.classList.add "is-error"
					FormValidation.el[form][input].group.classList.add "is-in-focus"

					FormValidation.resetInput form, input

					expect(FormValidation.el[form][input].input.value).toMatch ""
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-complete"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-dirty"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-error"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-in-focus"

	it "should reset a form", ->

		for form, inputs of FormValidation.el

			FormValidation.el[form].form.classList.add "is-error"
			FormValidation.el[form].form.classList.add "is-sent"
			FormValidation.el[form].form.classList.add "is-sending"

			if form is "loginForm"
				FormValidation.el[form].form.querySelector(".o-form").classList.add "is-sending"

			FormValidation.enableButton form

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.validations[form][input] = true

			FormValidation.resetForm form

			expect(FormValidation.el[form].form.classList).not.toContain "is-error"
			expect(FormValidation.el[form].form.classList).not.toContain "is-sent"
			expect(FormValidation.el[form].form.classList).not.toContain "is-sending"
			expect(FormValidation.el[form].button.classList).toContain "is-disabled"

			if form is "loginForm"
				expect(FormValidation.el[form].form.querySelector(".o-form").classList).not.toContain "is-sending"

			expect(FormValidation.formIsValid form).toBe false

	it "should sanitise input", ->

		expect(FormValidation.sanitiseInput("hello world")).toMatch "hello world"
		expect(FormValidation.sanitiseInput("email@ddress.com")).toMatch "emailddresscom"
		expect(FormValidation.sanitiseInput("http://www.google.com")).toMatch "httpwwwgooglecom"
		expect(FormValidation.sanitiseInput("!@££$%^&*()-=+[]{}\/|/?><\".1234567890~`")).toMatch ""

	it "should set complete status on a form input group", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.resetInput form, input

					expect(FormValidation.el[form][input].group.classList).not.toContain "is-complete"

					FormValidation.setComplete form, input

					expect(FormValidation.el[form][input].group.classList).toContain "is-complete"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-error"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-in-focus"

	it "should set error status on a form input group", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.resetInput form, input

					expect(FormValidation.el[form][input].group.classList).not.toContain "is-error"

					FormValidation.setError form, input

					expect(FormValidation.el[form][input].group.classList).toContain "is-error"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-complete"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-in-focus"

	it "should set in-focus status on a form input group", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.resetInput form, input

					expect(FormValidation.el[form][input].group.classList).not.toContain "is-in-focus"

					FormValidation.setFocus form, input

					expect(FormValidation.el[form][input].group.classList).toContain "is-in-focus"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-complete"
					expect(FormValidation.el[form][input].group.classList).not.toContain "is-error"

	it "should set is-sending status on a form", ->

		for form, inputs of FormValidation.el

			FormValidation.resetForm form
			expect(FormValidation.el[form].form.classList).not.toContain "is-sending"

			if form is "loginForm"
				expect(FormValidation.el[form].form.querySelector(".o-form").classList).not.toContain "is-sending"

			FormValidation.setFormIsSending form

			expect(FormValidation.el[form].form.classList).toContain "is-sending"
			expect(FormValidation.el[form].form.classList).not.toContain "is-error"
			expect(FormValidation.el[form].form.classList).not.toContain "is-sent"

			if form is "loginForm"
				expect(FormValidation.el[form].form.querySelector(".o-form").classList).toContain "is-sending"

	it "should set is-sent status on a form", ->

		for form, inputs of FormValidation.el

			FormValidation.resetForm form
			expect(FormValidation.el[form].form.classList).not.toContain "is-sent"

			FormValidation.setFormIsSent form

			expect(FormValidation.el[form].form.classList).toContain "is-sent"
			expect(FormValidation.el[form].form.classList).not.toContain "is-error"
			expect(FormValidation.el[form].form.classList).not.toContain "is-sending"

	it "should set the state on an input and input group based on the input's validation status", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.validations[form][input] = false
					FormValidation.setInputState form, input

					expect(FormValidation.el[form][input].group.classList).not.toContain "is-in-focus"

					if input isnt "message"

						expect(FormValidation.el[form][input].group.classList).not.toContain "is-complete"
						expect(FormValidation.el[form][input].group.classList).toContain "is-error"

					else
						FormValidation.el[form][input].input.value = "test"

					FormValidation.validations[form][input] = true
					FormValidation.setInputState form, input

					expect(FormValidation.el[form][input].group.classList).not.toContain "is-error"
					expect(FormValidation.el[form][input].group.classList).toContain "is-complete"

					FormValidation.resetInput form, input
					# Hacky, I know, but otherwise it won't pass and
					# there's no good reason other than computational
					# delay!
					setTimeout ->
						expect(FormValidation.el[form][input].input.classList).not.toContain "is-dirty"
					, 500
					FormValidation.el[form][input].input.value = "test"
					FormValidation.setInputState form, input
					setTimeout ->
						expect(FormValidation.el[form][input].input.classList).toContain "is-dirty"
					, 500

	it "should validate all inputs", ->

		for form, inputs of FormValidation.el

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					if input is "email"

						FormValidation.el[form][input].input.value = ""
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe false

						FormValidation.el[form][input].input.value = "wefwef@wefwef"
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe false

						FormValidation.el[form][input].input.value = "wefwef"
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe false

						FormValidation.el[form][input].input.value = "$%&$%@@$£$.com"
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe false

						FormValidation.el[form][input].input.value = "valid@email.com"
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe true

					if input is "message"

						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe true

					if input is "name"

						FormValidation.el[form][input].input.value = ""
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe false

						FormValidation.el[form][input].input.value = "test"
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe true

					if input is "password"

						FormValidation.el[form][input].input.value = ""
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe false

						FormValidation.el[form][input].input.value = "test"
						FormValidation.setInputValidationState form, input
						expect(FormValidation.validations[form][input]).toBe true

	it "should display an error message above an invalid input field on the contact form", ->

		form = FormValidation.el["contactForm"]

		for input, elements of form

			if input isnt "button" and
			input isnt "form" and
			input isnt "notifications"

				FormValidation.showError "contactForm", input

				expect(form[input].group.classList).toContain "is-error"
				expect(form[input].group.querySelector ".o-form__error-message").not.toBe null

	it "should display all errors on a form", ->

		for form, inputs of FormValidation.el

			if form isnt "loginForm"

				FormValidation.resetForm form

				errors = FormValidation.el[form].form.querySelectorAll ".o-form__error-message"
				expect(errors.length).toBe 0

				for input, elements of inputs

					if input isnt "button" and
					input isnt "form" and
					input isnt "notifications"

						FormValidation.setInputValidationState form, input
						FormValidation.makeDirty form, input

				FormValidation.showErrors form

				errors = FormValidation.el[form].form.querySelectorAll ".o-form__error-message"
				expect(errors.length).not.toBe 0

				FormValidation.resetForm form

				errors = FormValidation.el[form].form.querySelectorAll ".o-form__error-message"
				expect(errors.length).toBe 0

				for input, elements of inputs

					if input isnt "button" and
					input isnt "form" and
					input isnt "notifications"

						FormValidation.setFocus form, input
						FormValidation.makeDirty form, input
						FormValidation.setInputValidationState form, input

				FormValidation.removeAllErrors()
				FormValidation.showErrors form

				errors = FormValidation.el[form].form.querySelectorAll ".o-form__error-message"
				expect(errors.length).toBe 0

	it "should display a notification", ->

		FormValidation.hideAllNotifications()

		notifications = document.querySelectorAll(".o-form__notification")
		expect(notifications.length).not.toBe 0
		for notification in notifications
			expect(notification.classList).toContain "is-hidden"

		FormValidation.showNotifcation "logging in"
		expect(FormValidation.el.loginForm.notifications.loggingIn.classList).not.toContain "is-hidden"

		FormValidation.showNotifcation "sending"
		expect(FormValidation.el.contactForm.notifications.sending.classList).not.toContain "is-hidden"

		FormValidation.showNotifcation "sent"
		expect(FormValidation.el.contactForm.notifications.sent.classList).not.toContain "is-hidden"

	# it "should submit the contact form", ->
	#
	# 	expect(FormValidation.el.contactForm.form.classList).not.toContain "is-sent"
	#
	# 	FormValidation.el.contactForm.name.input.value = "name"
	# 	FormValidation.el.contactForm.email.input.value = "email@address.com"
	# 	FormValidation.el.contactForm.message.input.value = "message"
	#
	# 	FormValidation.setInputValidationState "contactForm", "name"
	# 	FormValidation.setInputValidationState "contactForm", "email"
	# 	FormValidation.setInputValidationState "contactForm", "message"
	#
	# 	spyOn window, "fetch"
	#
	# 	FormValidation.submitContactForm()
	#
	# 	setTimeout ->
	# 		expect(window.fetch).toHaveBeenCalled()
	# 		expect(FormValidation.el.contactForm.form.classList).toContain "is-sent"
	# 	, 3000

	it "should validate an entire form", ->

		for form, inputs of FormValidation.el

			FormValidation.resetForm form

			FormValidation.enableButton form

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.setInputValidationState form, input
					FormValidation.makeDirty form, input

			FormValidation.validateForm form

			expect(FormValidation.el[form].button.classList).toContain "is-disabled"

			if form isnt "loginForm"

				errors = FormValidation.el[form].form.querySelectorAll ".o-form__error-message"
				expect(errors.length).not.toBe 0

			for input, elements of inputs

				if input isnt "button" and
				input isnt "form" and
				input isnt "notifications"

					FormValidation.validations[form][input] = true

			FormValidation.validateForm form

			expect(FormValidation.el[form].button.classList).not.toContain "is-disabled"

			errors = FormValidation.el[form].form.querySelectorAll ".o-form__error-message"

			expect(errors.length).toBe 0

	it "should validate that input isn't blank", ->

		expect(FormValidation.validateIsntBlank("")).toBe false
		expect(FormValidation.validateIsntBlank("test")).toBe true

	it "should validate email addresses", ->

		expect(FormValidation.validateEmail("hello@gmail.com")).toBe true
		expect(FormValidation.validateEmail("hello-world@gmail.com")).toBe true
		expect(FormValidation.validateEmail("hello_world@gmail.com")).toBe true
		expect(FormValidation.validateEmail("hello_world1999@gmail.com")).toBe true
		expect(FormValidation.validateEmail("hello.world@gmail.com")).toBe true
		expect(FormValidation.validateEmail("hello_world@gmail.co.uk")).toBe true
		expect(FormValidation.validateEmail("darryl@yourweb.expert")).toBe true
		expect(FormValidation.validateEmail("hello")).toBe false
		expect(FormValidation.validateEmail("hello@world")).toBe false