/* jslint node: true */
"use strict";

var config = require('../../test-config.json');

module.exports = function () {
	
	var basePath = config.cartApi.basepath;
	console.log("BasePath: " + basePath);

	this.Then(/^I should get global variable for (.*)$/, function (variable, callback) {
		var value = this.apickli.getGlobalVariable(variable);
		callback();
	});

	this.When(/^I create cart$/, function (callback) {
        this.apickli.post(basePath, function (error, response) {
            if (error) {
                callback(new Error(error));
            }

            callback();
        });
    });

	this.When(/^I get cart created$/, function (callback) {
		var cartId = this.apickli.getGlobalVariable("CartId");
        this.apickli.get(basePath+"/"+cartId, function (error, response) {
            if (error) {
                callback(new Error(error));
            }
            callback();
        });
    });

    this.When(/^I get cart for (.*)$/, function (cartId, callback) {
        this.apickli.get(basePath+"/"+cartId, function (error, response) {
            if (error) {
                callback(new Error(error));
            }
            callback();
        });
    });


    this.Then(/^value of body path (.*) should match with (.*) in global scope$/, function (path, globalVariableName, callback) {
		var responseValue = this.apickli.evaluatePathInResponseBody(path);
		var value = this.apickli.getGlobalVariable(globalVariableName);
		if(responseValue === null || value === null || responseValue !== value){
        	callback(new Error(globalVariableName + " in the global variable does not match with response"));
		}
		callback();
	});

	this.When(/^I update cart$/, function (callback) {
		var cartId = this.apickli.getGlobalVariable("CartId");
		var cartItemId = this.apickli.getGlobalVariable("CartItemId");
		var data = this.apickli.requestBody;
		data = data.replace("{{CartId}}",cartId);
		data = data.replace("{{CartItemId}}",cartItemId);
		this.apickli.setRequestBody(data);
        this.apickli.post(basePath+"/"+cartId+"/cartitem/"+cartItemId, function (error, response) {
            if (error) {
                callback(new Error(error));
            }
            callback();
        });
    });

};