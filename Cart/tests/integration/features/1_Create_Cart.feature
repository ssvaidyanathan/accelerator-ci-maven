Feature: As a Cart API consumer, I want to create a Cart
	
	#Generate OAuth Token
	Scenario: Generate the OAuth token which is required to call all APIs
		As an app developer
		I would like to generate an Oauth token
		So that I can call the Carts APIs

		Given I set query parameters to 
		| 	parameter   | 	value 		|
		|	grant_type	|	client_credentials	|
		Given I set the custom headers
		Given I set basic authentication as header
		When I GET /v1/oauth2/accesstoken
		Then response code should be 200
		Then I store the value of body path $.access_token as access token

	#Create Cart Scenarios
	Scenario: (Negative) Create the Cart Item without passing Auth token
		As a Carts API consumer
		I would like to call the Carts API without the Auth bearer token
		So that I get an Invalid Access Token error

		Given I set query parameters to 
		| 	parameter   | 	value 		|
		|	include		|	cart		|
		Given I pipe contents of file ./CreateCart.json to body
		Given I set the custom headers
		When I create cart
		Then response code should be 401
		Then response body should be valid json
		Then response body path $.errors.error[0].code should be InvalidAccessToken

	Scenario: (Negative) Create the Cart Item without the custom headers
		As a Carts API consumer
		I would like to call the Carts API without the custom headers
		So that I get a Bad request error

		Given I set query parameters to 
		| 	parameter   | 	value 		|
		|	include		|	cart		|
		Given I pipe contents of file ./CreateCart.json to body
		When I set bearer token
		When I create cart
		Then response code should be 400
		Then response body should be valid json
		Then response body path $.errors.error[0].code should be SECURITY-0052

	Scenario: Create the Cart Item
		As a Carts API consumer
		I would like to call the Carts API
		So that I can create a Cart

		Given I set query parameters to 
		| 	parameter   | 	value 		|
		|	include		|	cart		|
		Given I pipe contents of file ./CreateCart.json to body
		Given I set the custom headers
		When I set bearer token
		When I create cart
		Then response code should be 200
		Then response body should be valid json
		Then I store the value of body path $.cart.@cartId as CartId in global scope
		Then I store the value of body path $.cart.cartItem[0].@cartItemId as CartItemId in global scope

	