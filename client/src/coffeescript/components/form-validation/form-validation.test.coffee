describe "Form Validation", ->

	FormValidation = require "./form-validation.coffee"

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

	it "should sanitise input", ->

		expect(FormValidation.sanitiseInput("hello world")).toMatch "hello world"
		expect(FormValidation.sanitiseInput("email@ddress.com")).toMatch "emailddresscom"
		expect(FormValidation.sanitiseInput("http://www.google.com")).toMatch "httpwwwgooglecom"
		expect(FormValidation.sanitiseInput("!@££$%^&*()-=+[]{}\/|/?><\".1234567890~`")).toMatch ""