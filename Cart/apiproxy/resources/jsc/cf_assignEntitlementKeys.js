var authCodeAsCacheKey = context.getVariable('headers.authorization');
var masterDealerCode = context.getVariable('masterdealercode');
var authCustomerId = context.getVariable("authcustomerid");
var authFinancialAccountId = context.getVariable("authfinancialaccountid");
var authLineOfServiceId = context.getVariable("authlineofserviceid");
var applicationUserId = context.getVariable("applicationuserid");
var username = context.getVariable("username");
var password = context.getVariable("password");
var mngrTxId = context.getVariable("mngrTxId");
var apptype = context.getVariable("apptype");
var authorization = context.getVariable("authorization");
var abfEntitlements = context.getVariable("accesstoken.abfEntitlements");
var isAnonymousOrAppBased = context.getVariable("isAnonymousOrAppBased");
var tokenScope = context.getVariable("tokenScope");
var apiAbfs = context.getVariable("apiABFCacheVar");
var apiOnlyAnonymous = "false";
var anonymousCustomerPermissionDenied = "false";
var mandatoryHeadersMissingError = "false";
var apiError = '';

if (typeof apiAbfs == 'undefined' || apiAbfs == null){
	apiAbfs='';
}


//Verifying API has mapped to only ANONYMOUS. If so then skip Entitlements flow.

apiAbfs = apiAbfs.trim();
if(apiAbfs.toUpperCase()=="ANONYMOUS:" ){
	apiOnlyAnonymous = "true";
}


//If anonymous user trying to access NoN ANONYMOUS API then permission should be denied
if(tokenScope=="anonymous"){
	if(apiAbfs.indexOf("ANONYMOUS")==-1){
		anonymousCustomerPermissionDenied="true";
		apiError="<apiError>	<statusCode>403</statusCode>	<reasonPhrase>Forbidden</reasonPhrase>	<errors><error> <code>SECURITY-0002</code>	<userMessage>Insufficient permission to access the requested resource</userMessage>	</error> </errors>	</apiError>	";
	}
}


if (apptype != null && apptype != "") {
	apptype = apptype.toLowerCase();
}

var idType ='';
var isAnonymousOrRetail = 'false';
var isAnonymousOrAppBased = 'false';

var authCode = "DEFAULT";
var id = "DEFAULT";
var custInfo = "DEFAULT";


//authCode
if (authCodeAsCacheKey && authCodeAsCacheKey.length > 0) {
     var authCodeArr = authCodeAsCacheKey.split(' ');
     if (authCodeArr.length > 1){
       authCode = authCodeArr[1].trim();
     }
     else
       authCode = authCodeArr[0].trim();
} 

      

//identifying keys and validating mandatory headers based on scope
if (username && username.length > 0 && password && password.length > 0) {
	id = mngrTxId;
    custInfo = "DEFAULT";
    idType = "managerTxId";
} else if (tokenScope == "assisted") {
       id = applicationUserId;   
       idType="applicationUserId";
       if (apiOnlyAnonymous == 'false' && (id == null || id.trim() == '')){
    	   mandatoryHeadersMissingError="true";
    	   apiError = "<apiError>	<statusCode>400</statusCode>	<reasonPhrase>Bad Request</reasonPhrase>	<errors><error> <code>SECURITY-0052</code>	<userMessage>Either of rep UserId/authCustomerId/authFinancialAccountId need to be passed in the request</userMessage>	</error> </errors>	</apiError>	";
       }
} else if (tokenScope == "logged-in") { // authcustomerid and authfinancialaccountid  - web customer logged in scenario
       id = authCustomerId;
       idType = "authCustomerId";
       
     //custInfo
       if (authFinancialAccountId && authFinancialAccountId.length > 0) {
              custInfo = authFinancialAccountId;
       }      
       else if (authLineOfServiceId && authLineOfServiceId.length > 0) {
              custInfo = authLineOfServiceId;
       }
       
       if (apiOnlyAnonymous == 'false' && (id==null || id.trim() == '') && (custInfo == "DEFAULT")){
    	   mandatoryHeadersMissingError="true";
    	   apiError = "<apiError>	<statusCode>400</statusCode>	<reasonPhrase>Bad Request</reasonPhrase>	<errors><error> <code>SECURITY-0052</code>	<userMessage>Either of rep UserId/authCustomerId/authFinancialAccountId need to be passed in the request</userMessage>	</error> </errors>	</apiError>	";
       }
} else {
	id = "ANONYMOUS";
	authCode = "DEFAULT";
    custInfo = "DEFAULT";
    idType = "anonymous";
}

//"Either of rep UserId/authCustomerId/authFinancialAccountId need to be passed in the request" - SECURITY-0048

if (apptype == "appbased" || tokenScope == "anonymous" || authorization.indexOf("Basic") != -1) {
	isAnonymousOrAppBased = 'true';
} else {
	isAnonymousOrAppBased = 'false';
}

var isAppbasedOrBasicAuth = 'false';
if (apptype == "appbased" || authorization.indexOf("Basic") != -1){
	isAppbasedOrBasicAuth = 'true';
}
context.setVariable('isAppbasedOrBasicAuth',isAppbasedOrBasicAuth);

context.setVariable('authCode',authCode);
context.setVariable('id',id);
context.setVariable('custInfo',custInfo);
context.setVariable('idType',idType);
context.setVariable('isAnonymousOrAppBased',isAnonymousOrAppBased);

//Parsing the entitlements JSON body
var entitlementsJSON = {};
if(abfEntitlements != null && abfEntitlements != ''){
	entitlementsJSON=JSON.parse(abfEntitlements);
}
//search for the user or customer specific entitlements in the JSON
var userEntitlements = entitlementsJSON[id+'_'+custInfo];
var userABFList = entitlementsJSON[id+'_'+custInfo+'_ABFList'];
if(typeof userEntitlements == 'undefined' || userEntitlements == null){
	userEntitlements = '';
}

if(typeof userABFList == 'undefined' || userABFList == null){
	userABFList = '';
}

context.setVariable('userEntitlements',userEntitlements);
context.setVariable('userABFListVar',userABFList);

//disable entitlement flow at api level

var proxyName = context.getVariable("apiproxy.name");
var apiName = context.getVariable("current.flow.name");
var disableentitlementsflow = context.getVariable("disable.entitlements.flow");
var api_proxy_names = context.getVariable("app.disableapientitlement");
if (typeof api_proxy_names != 'undefined' && api_proxy_names != null && api_proxy_names != "") {   
    var api_proxy_names_arr = api_proxy_names.split(',');	        
    for(var i =0; i<api_proxy_names_arr.length; i++){
    	if(proxyName == api_proxy_names_arr[i] || apiName == api_proxy_names_arr[i]){
    		disableentitlementsflow = "true";
    	}
    }
}     
context.setVariable("disable.entitlements.flow", disableentitlementsflow);

//Convert flow uri path to lower case
var uriPath = context.getVariable("requestpath.definition");

if ( typeof uriPath != 'undefined' && uriPath != null) {
	uriPath=uriPath.toLowerCase();
	context.setVariable("requestpath.definition",uriPath);
}


//simplify complex step conditions to single condition

var isEntitlementCallRequired = "false";
var isEntitlementCheckRequired = "false";

if ((disableentitlementsflow == 'false') && (userEntitlements == null || userEntitlements == "" ) && (isAnonymousOrAppBased == 'false') && (apiOnlyAnonymous == "false")){
	isEntitlementCallRequired = "true";
}


if ( (disableentitlementsflow == 'false') && (isAnonymousOrAppBased == 'false') && (apiOnlyAnonymous == "false") ){
	isEntitlementCheckRequired = "true";
}


context.setVariable("isEntitlementCallRequired",isEntitlementCallRequired);
context.setVariable("isEntitlementCheckRequired",isEntitlementCheckRequired);
context.setVariable("anonymousCustomerPermissionDenied",anonymousCustomerPermissionDenied);
context.setVariable("mandatoryHeadersMissingError",mandatoryHeadersMissingError);
context.setVariable("apiError", apiError);



