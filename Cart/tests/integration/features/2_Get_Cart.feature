Feature: As a Cart API consumer, I want to Get the Cart Information

	Scenario: (Negative) Get the Cart Item without passing a Cart Id
		As a Carts API Consumer
		I would like to call the get Cart info without passing a valid id
		So that I can display the error in my app

		Given I set the custom headers
		When I set bearer token
		When I get cart for /
		Then response code should be 400
		Then response body should be valid json
		Then response body path $.errors.error[0].code should be GENERAL-0001

	Scenario: (Negative) Get the Cart Item passing an invalid Cart Id
		As a Carts API Consumer
		I would like to call the get Cart info with an invalid id
		So that I can display the error in my app

		Given I set the custom headers
		When I set bearer token
		When I get cart for abc123
		Then response code should be 503
		Then response body should be valid json
		Then response body path $.errors.error[0].code should be SYSTEM-1001

	Scenario: Get the Cart Item
		As a Carts API Consumer
		I would like to get the Cart info
		so that I can display in my app

		Given I set the custom headers
		When I set bearer token
		When I get cart created
		Then response code should be 200
		Then response body should be valid json
		Then value of body path $.cart.@cartId should match with CartId in global scope
		Then value of body path $.cart.cartItem[0].@cartItemId should match with CartItemId in global scope