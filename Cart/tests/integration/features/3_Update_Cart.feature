Feature: As a Cart API consumer, I want to update the Cart Information
	
	Scenario: Update the Cart Item
		As a Carts API Consumer
		I would like to update the Cart info for a given CartId
		so that I can display the updated cart in my app

		Given I set the custom headers
		When I set bearer token
		Given I pipe contents of file ./UpdateCart.json to body
		When I update cart 
		Then response code should be 204
