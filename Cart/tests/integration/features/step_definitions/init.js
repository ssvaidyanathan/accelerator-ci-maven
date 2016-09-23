/* jshint node:true */
"use strict";

var apickli = require("apickli");
var fs = require("fs");
var jsonfile = require("jsonfile");
var _ = require("lodash");

// set the url and base path for your API endpoint on Apigee edge
var config = require('../../test-config.json');

var env = config.cartApi.propsFile || "DIT01.postman_environment.json";

var props = jsonfile.readFileSync("./tests/integration/features/"+env);

console.log(env);

module.exports = function() {
    //Set timeout from the config
    //(_.find(props.values, { "key": "ResponseTimeSLAms"}).value === null)
      //      ?this.setDefaultTimeout(2000):this.setDefaultTimeout(_.find(props.values, { "key": "ResponseTimeSLAms"}).value);
    
    // cleanup before every scenario
    this.Before(function(scenario, callback) {
        this.apickli = new apickli.Apickli("https",
                                           config.cartApi.domain,
                                           "./tests/integration/features/fixtures/");
        callback();
    });

    this.Given(/^I set the custom headers$/, function (callback) {
        this.apickli.addRequestHeader("Content-Type", "application/json");
        this.apickli.addRequestHeader("Accept", _.find(props.values, { "key": "Accept"}).value);
        this.apickli.addRequestHeader("applicationuserid", _.find(props.values, { "key": "applicationuserid"}).value);
        this.apickli.addRequestHeader("authcustomerid", _.find(props.values, { "key": "CustomerId"}).value);
        this.apickli.addRequestHeader("authfinancialaccountid", _.find(props.values, { "key": "FinancialAccountId"}).value);
        this.apickli.addRequestHeader("testname", _.find(props.values, { "key": "TestName"}).value);
        callback();
    });

    this.Given(/^I set basic authentication as header$/, function (callback) {
        this.apickli.addRequestHeader("Authorization", "Basic "+_.find(props.values, { "key": "BasicAuth_REB_CARE"}).value);
        callback();
    });
};