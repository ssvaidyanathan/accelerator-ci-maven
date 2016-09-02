// 1. Extract Query Params
var queryParamsFieldsCollection = context.getVariable('request.queryparams.names') + '';

//Remove square brackets
queryParamsFieldsCollection = queryParamsFieldsCollection.substr(1, queryParamsFieldsCollection.length - 2);

//create accesstoken scope flow variable
var accessTokenScope = context.getVariable("scope")
context.setVariable("accessTokenScope",accessTokenScope);
var tokenScope = "anonymous";

//verifying assisted or web customer(logged-in) or anonymous
if(typeof accessTokenScope != 'undefined' && accessTokenScope != null) {
	if(accessTokenScope.toLowerCase().indexOf("assisted") != -1) {
		tokenScope="assisted";
	} else if(accessTokenScope.toLowerCase().indexOf("logged-in") != -1){
		tokenScope="logged-in";
	} else if(accessTokenScope.toLowerCase().indexOf("anonymous") != -1){
		tokenScope="anonymous";
	} else {
		tokenScope="anonymous";
	}
} 
context.setVariable("tokenScope",tokenScope);

//Split string into an array
var queryParamsArray = queryParamsFieldsCollection.split(", ");

// Loop through Array and get value of query param
for (var i = 0; i < queryParamsArray.length; i++) {
	context.setVariable('queryparams.' + queryParamsArray[i].toLowerCase(), context.getVariable('request.queryparam.' + queryParamsArray[i]));
}

// 2. Extract Headers
var headerFieldsCollection = context.getVariable('request.headers.names') + '';

//Remove square brackets
headerFieldsCollection = headerFieldsCollection.substr(1, headerFieldsCollection.length - 2);

//Split string into an array
var headersArray = headerFieldsCollection.split(", ");

// Loop through Array and get value of header
for (var i = 0; i < headersArray.length; i++) {
	context.setVariable('headers.' + headersArray[i].toLowerCase(), context.getVariable('request.header.' + headersArray[i]));
	
	// Below values assigned to have minimal impact to existing code
	context.setVariable(headersArray[i].toLowerCase(), context.getVariable('request.header.' + headersArray[i]));
}

// 3. Assign Static
context.setVariable("capi.request.verb", context.getVariable("request.verb"));


// 4. Assign Values From Header / Token
context.setVariable("serviceTransactionId", context.getVariable("system.timestamp") + "-" + context.getVariable("messageid"));

// Read dc value from apigee flow system variable
var systemRegionName=context.getVariable("system.region.name");
context.setVariable("systemRegionName",systemRegionName);


////////////////////////////////////////////////////////////////////////////////
// get and create app attributes in case client uses basic auth
var authorization = context.getVariable("authorization");
if(authorization.indexOf("Basic") != -1) 
{
	context.setVariable("app.deployment",context.getVariable("verifyapikey.VerifyAPIKey.deployment"));
	context.setVariable("app.isTrusted",context.getVariable("verifyapikey.VerifyAPIKey.isTrusted"));
	context.setVariable("app.target",context.getVariable("verifyapikey.VerifyAPIKey.target"));
	context.setVariable("app.apptype",context.getVariable("verifyapikey.VerifyAPIKey.apptype"));
}

// get app attribute isTrusted & deployment
var deployment = context.getVariable("app.deployment");
var isTrusted = context.getVariable("app.isTrusted");


var virtualhostName = "Non-Secure";
if ((deployment != "cloud") && (isTrusted == "true")){
	virtualhostName = "secure";
}

// if (context.getVariable("virtualhost.name") == "secure"){
//	virtualhostName = "secure";
// }

context.setVariable("capi.virtualhost.name",virtualhostName);
var appTarget = context.getVariable("app.target");
////////////////////////////////////////////////////////////////////////////////

if(appTarget == null || appTarget == '')
{
	context.setVariable("capi.target.route.system","U2");
} else {
	context.setVariable("capi.target.route.system",appTarget);
}

//Read Header values from app associated to access token
var setAppData = null;
var senderId = null;
var channelId = null;
var appId = null;
var disableentitlementsflow = null;
var masterDealerCode = null;
var salesChannelCode = null;
var salesSubChannelCode = null;
var subChannelCategory = null;
var apptype = null;

if(authorization.indexOf("Basic") != -1) 
{
	context.setVariable("app.senderid",context.getVariable("verifyapikey.VerifyAPIKey.senderid"));
	context.setVariable("app.channelid",context.getVariable("verifyapikey.VerifyAPIKey.channelid"));
	context.setVariable("app.applicationid",context.getVariable("verifyapikey.VerifyAPIKey.applicationid"));
	context.setVariable("app.masterDealerCode",context.getVariable("verifyapikey.VerifyAPIKey.masterDealerCode"));
	context.setVariable("app.setChannelConfigFromAppData",context.getVariable("verifyapikey.VerifyAPIKey.setChannelConfigFromAppData"));
	context.setVariable("app.disableentitlementsflow",context.getVariable("verifyapikey.VerifyAPIKey.disableentitlementsflow"));
	context.setVariable("app.disableapientitlement",context.getVariable("verifyapikey.VerifyAPIKey.disableapientitlement"));
	//Quota and SpikeArrest variables
	context.setVariable("apiproduct.apiproduct.quota.interval",context.getVariable("verifyapikey.VerifyAPIKey.apiproduct.apiproduct.quota.interval"));
	context.setVariable("apiproduct.apiproduct.quota.timeunit",context.getVariable("verifyapikey.VerifyAPIKey.apiproduct.apiproduct.quota.timeunit"));
	context.setVariable("apiproduct.apiproduct.quota.allowed",context.getVariable("verifyapikey.VerifyAPIKey.apiproduct.apiproduct.quota.allowed"));

}

//create quota and spike arrest flow variables from app
context.setVariable("quota.interval",context.getVariable("apiproduct.apiproduct.quota.interval"));
context.setVariable("quota.timeunit",context.getVariable("apiproduct.apiproduct.quota.timeunit"));
context.setVariable("quota.allowed",context.getVariable("apiproduct.apiproduct.quota.allowed"));
	
//Fetch follower elements from the APP config
senderId= context.getVariable("app.senderid");
channelId= context.getVariable("app.channelid");
appId = context.getVariable("app.applicationid");

//Fetch following header values from accesstoken first
salesChannelCode = context.getVariable("accesstoken.salesChannelCode");
salesSubChannelCode = context.getVariable("accesstoken.salesSubChannelCode");
subChannelCategory = context.getVariable("accesstoken.subChannelCategory");
apptype = context.getVariable("accesstoken.apptype");

//verify if apptype is set in the token if not fetch it from app customer attribute
if (apptype == null || apptype == "") {
	apptype = context.getVariable("app.apptype");
}
context.setVariable("apptype",apptype);

masterDealerCode = context.getVariable("app.masterDealerCode");
if(masterDealerCode != null && masterDealerCode != ""){
	context.setVariable("masterDealerCode", masterDealerCode);
}
disableentitlementsflow = context.getVariable("app.disableentitlementsflow");
setAppData = context.getVariable("app.setChannelConfigFromAppData"); //this variable is used if header values has to read only from app 

//Fetch senderid, channelid and appid from Token when these are not present in APP config
if(senderId == null || senderId == ""){
	senderId = context.getVariable("accesstoken.senderid"); //senderid created from token if not present in APP
}
if(channelId == null || channelId == ""){
	channelId = context.getVariable("accesstoken.channelid"); //channelid created from token if not present in APP
}
if(appId == null || appId == ""){
	appId = context.getVariable("accesstoken.applicationid"); //applicationid created from token if not present in APP
}

//get senderid, channelid and applicationid from header in case if it is not added to APP config and Token
if(senderId == null || senderId == ""){
	senderId = context.getVariable("senderid"); //senderid created from header
}
if(channelId == null || channelId == ""){
	channelId = context.getVariable("channelid"); //channelid created from header
}
if(appId == null || appId == ""){
	appId = context.getVariable("applicationid"); //applicationid created from header
}

//Fetch senderid, channelid and appid from APP when these are not present in AccessToken and Header
if(senderId == null || senderId == ""){
	senderId = context.getVariable("app.senderid"); //senderid created from app if not present in AT and Header
}
if(channelId == null || channelId == ""){
	channelId = context.getVariable("app.channelid"); //channelid created from app if not present in AT and Header
}
if(appId == null || appId == ""){
	appId = context.getVariable("app.applicationid"); //applicationid created from app if not present in AT and Header
}

if(disableentitlementsflow != null && disableentitlementsflow != ""){  // verify app configured value
        context.setVariable("request.header.disableentitlementsflow", disableentitlementsflow);
        context.setVariable("disable.entitlements.flow", disableentitlementsflow);
} else {
	var disbaleentitlementsflow1 = context.getVariable("disableentitlementsflow");
	if(disbaleentitlementsflow1 != null && disbaleentitlementsflow1 != ""){                // verify header value
		context.setVariable("disable.entitlements.flow", disbaleentitlementsflow1);
	} else { // default to enable entitlements
		context.setVariable("disable.entitlements.flow","false");
		context.setVariable("disableentitlementsflow","false");
		context.setVariable("headers.disableentitlementsflow","false");
	}
}

if (setAppData != null && setAppData =="true")
{   
	senderId = context.getVariable("app.senderid");
  	channelId = context.getVariable("app.channelid");
   	appId = context.getVariable("app.applicationid");
}

context.setVariable("request.header.senderid", senderId);
context.setVariable("senderid", senderId);
context.setVariable("headers.senderid", senderId);
context.setVariable("request.header.channelid", channelId);
context.setVariable("channelid", channelId);
context.setVariable("headers.channelid", channelId);
context.setVariable("request.header.applicationid", appId);
context.setVariable("applicationid", appId);
context.setVariable("headers.applicationid", appId);

//set sales channel segmentation flow variables
if (salesChannelCode != null && salesChannelCode != ""){
	context.setVariable("salesChannelCode", salesChannelCode);
} else {
	context.setVariable("salesChannelCode", "");
}

if (salesSubChannelCode != null && salesSubChannelCode != ""){
	context.setVariable("salesSubChannelCode", salesSubChannelCode);
} else {
	context.setVariable("salesSubChannelCode", "");
}

if (subChannelCategory != null && subChannelCategory != ""){
	context.setVariable("subChannelCategory", subChannelCategory);
} else {
	context.setVariable("subChannelCategory", "");
}


//Extract segmentation data from APP and create flow variables. In case of WEB Logged-In, extract second value from the comma separated list.

var app_channelCode = context.getVariable("app.channelcode");
var app_subChannelCode = context.getVariable("app.subchannelcode");
var app_category = context.getVariable("app.category");

if(typeof app_channelCode == 'undefined' || app_channelCode == null){
   app_channelCode = '';
} else {
 var channelCodeArr = app_channelCode.split(',');
 if (tokenScope == 'logged-in' && channelCodeArr.length > 1){
  app_channelCode = channelCodeArr[1];
 } else {
  app_channelCode = channelCodeArr[0];
 }
}

if(typeof app_subChannelCode == 'undefined' || app_subChannelCode == null){
   app_subChannelCode = '';
} else {
 var subChannelCodeArr = app_subChannelCode.split(',');
 if (tokenScope == 'logged-in' && subChannelCodeArr.length > 1){
  app_subChannelCode = subChannelCodeArr[1];
 } else {
  app_subChannelCode = subChannelCodeArr[0];
 }
}
if(typeof app_category == 'undefined' || app_category == null){
   app_category = '';
} else {
 var subCategoryArr = app_category.split(',');
 if (tokenScope == 'logged-in' && subCategoryArr.length > 1){
  app_category = subCategoryArr[1];
 } else {
  app_category = subCategoryArr[0];
 }
}

context.setVariable("app_channelCode",app_channelCode);
context.setVariable("app_subChannelCode",app_subChannelCode);
context.setVariable("app_category",app_category);


//interactionid, workflowid, activityid - header params will take precedence over token attributes
var interactionId = context.getVariable("headers.interactionid");
var workflowid = context.getVariable("headers.workflowid");
var activityid = context.getVariable("headers.activityid");

if(interactionId == null || interactionId == "") {
	context.setVariable("headers.interactionid", context.getVariable("accesstoken.interactionid"));
	context.setVariable("interactionid", context.getVariable("accesstoken.interactionid"));
	context.setVariable("request.header.interactionid",context.getVariable("accesstoken.interactionid"));
	context.setVariable("request.header.interactionId",context.getVariable("accesstoken.interactionid"));
}
if(workflowid == null || workflowid == "") {
	context.setVariable("headers.workflowid", context.getVariable("accesstoken.workflowid"));
	context.setVariable("workflowid", context.getVariable("accesstoken.workflowid"));
	context.setVariable("request.header.workflowid",context.getVariable("accesstoken.workflowid"));
	context.setVariable("request.header.workflowId",context.getVariable("accesstoken.workflowid"));
}
if(activityid == null || activityid == "") {
	context.setVariable("headers.activityid", context.getVariable("accesstoken.activityid"));
	context.setVariable("activityid", context.getVariable("accesstoken.activityid"));
	context.setVariable("request.header.activityid",context.getVariable("accesstoken.activityid"));
	context.setVariable("request.header.activityId",context.getVariable("accesstoken.activityid"));
}

//applicationuserid, dealercode, storeid, tillid, terminalid, ui-timestamp, sessionid, authcustomerid, authfinancialaccountid, segmentationid  - Token attributes will take precedence over header param

var applicationuserid = context.getVariable("accesstoken.applicationuserid");
var dealercode = context.getVariable("accesstoken.dealercode");
var storeid = context.getVariable("accesstoken.storeid");
var tillid = context.getVariable("accesstoken.tillid");
var terminalid = context.getVariable("accesstoken.terminalid");
var uitimestamp = context.getVariable("accesstoken.ui-timestamp");
var sessionid = context.getVariable("accesstoken.sessionid");
var authcustomerid = context.getVariable("accesstoken.authcustomerid");
var authfinancialaccountid = context.getVariable("accesstoken.authfinancialaccountid");
var segmentationid = context.getVariable("accesstoken.segmentationid");


if(applicationuserid != null && applicationuserid != ""){
	context.setVariable("headers.applicationuserid", applicationuserid);
	context.setVariable("applicationuserid", applicationuserid);
	context.setVariable("request.header.applicationuserid",applicationuserid);
	context.setVariable("request.header.applicationUserId",applicationuserid);
}
if(dealercode != null && dealercode != ""){
	context.setVariable("headers.dealercode", dealercode);
	context.setVariable("dealercode", dealercode);
	context.setVariable("request.header.dealercode",dealercode);
	context.setVariable("request.header.dealerCode",dealercode);
}
if(storeid != null && storeid != ""){
	context.setVariable("headers.storeid", storeid);
	context.setVariable("storeid", storeid);
	context.setVariable("request.header.storeid",storeid);
	context.setVariable("request.header.storeId",storeid);
}
if(tillid != null && tillid != ""){
	context.setVariable("headers.tillid", tillid);
	context.setVariable("tillid", tillid);
	context.setVariable("request.header.tillid",tillid);
	context.setVariable("request.header.tillId",tillid);
}
if(terminalid != null && terminalid != ""){
	context.setVariable("headers.terminalid", terminalid);
	context.setVariable("terminalid", terminalid);
	context.setVariable("request.header.terminalid",terminalid);
	context.setVariable("request.header.terminalId",terminalid);
}
if(uitimestamp != null && uitimestamp != ""){
	context.setVariable("headers.ui-timestamp", uitimestamp);
	context.setVariable("ui-timestamp", uitimestamp);
	context.setVariable("request.header.ui-timestamp",uitimestamp);
}
if(sessionid != null && sessionid != ""){
	context.setVariable("headers.sessionid", sessionid);
	context.setVariable("sessionid", sessionid);
	context.setVariable("request.header.sessionid",sessionid);
	context.setVariable("request.header.sessionId",sessionid);
}
if(authcustomerid != null && authcustomerid != ""){
	context.setVariable("headers.authcustomerid", authcustomerid);
	context.setVariable("authcustomerid", authcustomerid);
	context.setVariable("request.header.authcustomerid",authcustomerid);
	context.setVariable("request.header.authcustomerId",authcustomerid);
}
if(authfinancialaccountid != null && authfinancialaccountid != ""){
	context.setVariable("headers.authfinancialaccountid", authfinancialaccountid);
	context.setVariable("authfinancialaccountid", authfinancialaccountid);
	context.setVariable("request.header.authfinancialaccountid",authfinancialaccountid);
	context.setVariable("request.header.authFinancialAccountId",authfinancialaccountid);
}
if(segmentationid != null && segmentationid != ""){
	context.setVariable("headers.segmentationid", segmentationid);
	context.setVariable("segmentationid", segmentationid);
	context.setVariable("request.header.segmentationid",segmentationid);
	context.setVariable("request.header.segmentationId",segmentationid);
}


// Store data required for logging
context.setVariable("elfLog.interactionId", context.getVariable("interactionid"));
context.setVariable("elfLog.requestVerb", context.getVariable("request.verb"));
context.setVariable("elfLog.proxyRequest", context.getVariable("request.content"));
context.setVariable("elfLog.contentType", context.getVariable("request.header.Content-Type"));
context.setVariable("elfLog.acceptType", context.getVariable("request.header.Accept"));
context.setVariable("facaderequestbasepath", context.getVariable("request.header.facaderequestbasepath"));

var httpMethod = context.getVariable('request.verb');
var reqContent = context.getVariable('request.content');
var contentType = context.getVariable('request.header.Content-Type');
var emptyPayload = 'false';
var isThreatCheckRequired = 'true';

//verify if we are getting empty payload in case of DELETE method 
if (httpMethod == 'DELETE' || httpMethod == 'POST' || httpMethod == 'PUT') {
	if (reqContent == null || reqContent.trim() == ''){
		emptyPayload = 'true';
	}
}

//Assign isThreatCheckRequired to false to skip all threat protection policies
if ( emptyPayload == 'true' || httpMethod == 'GET' || virtualhostName == "secure" ){
	isThreatCheckRequired = 'false';
}

context.setVariable('isThreatCheckRequired', isThreatCheckRequired);

var onlyToken = context.getVariable("access_token");
context.setVariable('onlyToken', onlyToken);

segmentationid = context.getVariable("segmentationid");

var capi_dc_system = "";

if ((segmentationid == "P" || segmentationid == "p" || systemRegionName == "us-west-1" || systemRegionName == "us-west-2" || systemRegionName == "dc-1" ) && segmentationid != "T" && segmentationid != "t"){
	capi_dc_system = "POLARIS";
}
else if (segmentationid == "T" || segmentationid == "t" || systemRegionName == "us-east-1" || systemRegionName == "dc-2"){
	capi_dc_system = "TITAN";
}

context.setVariable('capi.dc.system',capi_dc_system);

 