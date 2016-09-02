//Whatever proxy receives status code back from WSIL, It sends back to ODP, as per discussion there is no http code conversion required for error scenarios.
//Based on response status code ODP will take care of this.

context.setVariable("payLoad",response.content);
var statusCode = context.targetResponse.status;
context.setVariable("statusCode", statusCode);

var msg = context.targetResponse.status.message;
context.setVariable("httpDescription", msg);