var expect = require('chai').expect;
var sinon = require('sinon');

GLOBAL.context = {
    getVariable: function(s) {},
    setVariable: function(a, b) {}
  };
 
var js = require('../../apiproxy/resources/jsc/createFinalResponse.js');

var response = {
  "uuid": "6196fdf8-7480-11e6-a61d-0285d9a780d5",
  "type": "storelocators",
  "created": 1473200542330,
  "modified": 1473200542330,
  "Address_1": "6000 Glades Rd",
  "Address_2": "#K110",
  "City": "Boca Raton",
  "HomePage": "http://www.t-mobile.com/store/cell-phone-boca_raton-fl-999.html",
  "Hours": [
    {
      "DayOfWeek": "SUN",
      "OpenTime": "12:00AM",
      "CloseTime": "06:00PM"
    },
    {
      "DayOfWeek": "MON",
      "OpenTime": "10:00AM",
      "CloseTime": "09:00PM"
    },
    {
      "DayOfWeek": "TUE",
      "OpenTime": "10:00AM",
      "CloseTime": "09:00PM"
    },
    {
      "DayOfWeek": "WED",
      "OpenTime": "10:00AM",
      "CloseTime": "09:00PM"
    },
    {
      "DayOfWeek": "THU",
      "OpenTime": "10:00AM",
      "CloseTime": "09:00PM"
    },
    {
      "DayOfWeek": "FRI",
      "OpenTime": "10:00AM",
      "CloseTime": "09:00PM"
    },
    {
      "DayOfWeek": "SAT",
      "OpenTime": "10:00AM",
      "CloseTime": "09:00PM"
    }
  ],
  "location": {
    "latitude": 26.3659037,
    "longitude": -80.1343444
  },
  "MainPhone": "(561) 347-9986",
  "metadata": {
    "path": "/storelocators/6196fdf8-7480-11e6-a61d-0285d9a780d5",
    "size": 1600
  },
  "Name": "T-Mobile Boca Raton",
  "PostalCode": "33431-0000",
  "State": "FL",
  "StoreCode": "FL43"
};
 
describe('feature: rebuilding storeLocator API Response ', function() {
 
  it('AC1: API response rebuilding ', function(done) {
    var finalResp = js.createFinalResponse(response);
    expect(finalResp.StoreCode).to.equal("FL43");
    expect(finalResp.Name).to.equal("T-Mobile Boca Raton");
    done();
  });
 
});

