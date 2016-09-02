
var authcustomerid = context.getVariable("authcustomerid");
var authfinancialaccountid = context.getVariable("authfinancialaccountid");
var authlineofserviceid = context.getVariable("authlineofserviceid");
var applicationuserid = context.getVariable("applicationuserid");
var serviceTransactionId = context.getVariable("messageid");
var senderid = context.getVariable("senderid");
var channelid = context.getVariable("channelid");
var applicationid = context.getVariable("applicationid");
var sessionid = context.getVariable("sessionid");
var workflowid = context.getVariable("workflowid");
var activityid = context.getVariable("activityid");
var storeid = context.getVariable("storeid");
var dealercode = context.getVariable("dealercode");
var scope = context.getVariable("scope");
var interactionid = context.getVariable("interactionid");
var masterDealerCode = context.getVariable("masterDealerCode");
var systemid = context.getVariable("systemid");
var userid = context.getVariable("userid");
var usercompanyid = context.getVariable("usercompanyid");
var customercompanyid = context.getVariable("customercompanyid");
var servicepartnerid = context.getVariable("servicepartnerid");
var transactiontype = context.getVariable("transactiontype");
var providerid = context.getVariable("providerid");
var contextid = context.getVariable("contextid");
var idType = context.getVariable("idType");

var userEntitlementRequest = "";

userEntitlementRequest = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:base="http://services.tmobile.com/base" xmlns:v1="http://services.tmobile.com/SecurityManagement/UserSecurityEnterprise/V1"> 	<soapenv:Header/> <soapenv:Body>';

if (applicationuserid != null &&  applicationuserid.length > 0 && idType == 'applicationUserId') {
	userEntitlementRequest = userEntitlementRequest + '<v1:getUserEntitlementsRequest serviceTransactionId="' + serviceTransactionId +'">';
	userEntitlementRequest = userEntitlementRequest + '<base:header><base:sender><base:senderId>'+senderid + '</base:senderId><base:channelId>'+channelid+'</base:channelId><base:applicationId>'+applicationid+'</base:applicationId><base:applicationUserId>'+applicationuserid+'</base:applicationUserId>';
	if	(sessionid != null && sessionid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:sessionId>'+sessionid+'</base:sessionId>';
	}
	if	(workflowid != null && workflowid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:workflowId>'+workflowid+'</base:workflowId>';
	}
	if	(activityid != null && activityid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:activityId>'+activityid+'</base:activityId>';
	}
	if	(storeid != null && storeid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:storeId>'+storeid+'</base:storeId>';
	}							
	if	(dealercode != null && dealercode != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:dealerCode>'+dealercode+'</base:dealerCode>';
	}
	if	(scope != null && scope != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:scope>'+scope+'</base:scope>';
	}
	if	(interactionid != null && interactionid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:interactionId>'+interactionid+'</base:interactionId>';
	}
	if	(masterDealerCode != null && masterDealerCode != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:masterDealerCode>'+masterDealerCode+'</base:masterDealerCode>';
	}
	userEntitlementRequest = userEntitlementRequest+'</base:sender>';
	
	if (systemid != null || userid != null || usercompanyid != null || customercompanyid != null || servicepartnerid != null || transactiontype != null) {
			userEntitlementRequest = userEntitlementRequest + '<base:target>';
			if ((systemid != null && systemid != '') || (userid != null && userid != '')){
				userEntitlementRequest = userEntitlementRequest + '<base:targetSystemId>';
				if (systemid != null && systemid != ''){
					userEntitlementRequest = userEntitlementRequest + '<base:systemId>'+systemid+'</base:systemId>';
				}
				if (userid != null && userid != ''){
					userEntitlementRequest = userEntitlementRequest + '<base:userId>' + userid + '</base:userId>';
				}
				userEntitlementRequest = userEntitlementRequest + '</base:targetSystemId>';
			}
			
			if (usercompanyid != null && usercompanyid != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:userCompanyId>'+usercompanyid+'</base:userCompanyId>';
			}
			if (customercompanyid != null && customercompanyid != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:customerCompanyId>'+customercompanyid+'</base:customerCompanyId>';
			}
			if (servicepartnerid != null && servicepartnerid != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:servicePartnerId>'+servicepartnerid+'</base:servicePartnerId>';
			}
			if (transactiontype != null && transactiontype != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:transactionType>'+transactiontype+'</base:transactionType>';
			}
			userEntitlementRequest = userEntitlementRequest+'</base:target>';
	}
	if ((providerid != null && providerid != '') || (contextid != null && contextid != '')){
		userEntitlementRequest = userEntitlementRequest + '<base:providerId>';
		if (providerid != null && providerid != '') {
				userEntitlementRequest = userEntitlementRequest + '<base:id>'+providerid+'</base:id>';
		}
		if (contextid != null && contextid != '') {
				userEntitlementRequest = userEntitlementRequest + '<base:contextId>'+contextid+'</base:contextId>';
		}
		userEntitlementRequest = userEntitlementRequest + '</base:providerId>';
	}
	userEntitlementRequest = userEntitlementRequest +'</base:header>';
	userEntitlementRequest = userEntitlementRequest +'<v1:userName>'+applicationuserid+'</v1:userName></v1:getUserEntitlementsRequest>';
}

if (authcustomerid != null && authcustomerid != '' && idType == 'authCustomerId') {
	userEntitlementRequest = userEntitlementRequest +'<v1:getCustomerEntitlementsRequest serviceTransactionId="' + serviceTransactionId +'">';
	
		userEntitlementRequest = userEntitlementRequest + '<base:header><base:sender><base:senderId>'+senderid + '</base:senderId><base:channelId>'+channelid+'</base:channelId><base:applicationId>'+applicationid+'</base:applicationId>';
	
	if	(applicationuserid != null && applicationuserid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:applicationUserId>'+applicationuserid+'</base:applicationUserId>';
	}		
	if	(sessionid != null && sessionid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:sessionId>'+sessionid+'</base:sessionId>';
	}
	if	(workflowid != null && workflowid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:workflowId>'+workflowid+'</base:workflowId>';
	}
	if	(activityid != null && activityid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:activityId>'+activityid+'</base:activityId>';
	}
	if	(storeid != null && storeid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:storeId>'+storeid+'</base:storeId>';
	}							
	if	(dealercode != null && dealercode != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:dealerCode>'+dealercode+'</base:dealerCode>';
	}
	if	(scope != null && scope != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:scope>'+scope+'</base:scope>';
	}
	if	(interactionid != null && interactionid != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:interactionId>'+interactionid+'</base:interactionId>';
	}
	if	(masterDealerCode != null && masterDealerCode != '') {
			userEntitlementRequest = userEntitlementRequest+'<base:masterDealerCode>'+masterDealerCode+'</base:masterDealerCode>';
	}
	userEntitlementRequest = userEntitlementRequest+'</base:sender>';
	
	if (systemid != null || userid != null || usercompanyid != null || customercompanyid != null || servicepartnerid != null || transactiontype != null) {
			userEntitlementRequest = userEntitlementRequest + '<base:target>';
			if ((systemid != null && systemid != '') || (userid != null && userid != '')){
				userEntitlementRequest = userEntitlementRequest + '<base:targetSystemId>';
				if (systemid != null && systemid != ''){
					userEntitlementRequest = userEntitlementRequest + '<base:systemId>'+systemid+'</base:systemId>';
				}
				if (userid != null && userid != ''){
					userEntitlementRequest = userEntitlementRequest + '<base:userId>' + userid + '</base:userId>';
				}
				userEntitlementRequest = userEntitlementRequest + '</base:targetSystemId>';
			}
			
			if (usercompanyid != null && usercompanyid != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:userCompanyId>'+usercompanyid+'</base:userCompanyId>';
			}
			if (customercompanyid != null && customercompanyid != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:customerCompanyId>'+customercompanyid+'</base:customerCompanyId>';
			}
			if (servicepartnerid != null && servicepartnerid != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:servicePartnerId>'+servicepartnerid+'</base:servicePartnerId>';
			}
			if (transactiontype != null && transactiontype != ''){
				userEntitlementRequest = userEntitlementRequest + '<base:transactionType>'+transactiontype+'</base:transactionType>';
			}
			userEntitlementRequest = userEntitlementRequest+'</base:target>';
	}
	if ((providerid != null && providerid != '') || (contextid != null && contextid != '')){
		userEntitlementRequest = userEntitlementRequest + '<base:providerId>';
		if (providerid != null && providerid != '') {
				userEntitlementRequest = userEntitlementRequest + '<base:id>'+providerid+'</base:id>';
		}
		if (contextid != null && contextid != '') {
				userEntitlementRequest = userEntitlementRequest + '<base:contextId>'+contextid+'</base:contextId>';
		}
		userEntitlementRequest = userEntitlementRequest + '</base:providerId>';
	}
	userEntitlementRequest = userEntitlementRequest +'</base:header>';
	userEntitlementRequest = userEntitlementRequest +'<v1:customerId>'+authcustomerid+'</v1:customerId>';
	userEntitlementRequest = userEntitlementRequest +'<v1:financialAccountNumber>'+authfinancialaccountid+'</v1:financialAccountNumber></v1:getCustomerEntitlementsRequest>';
}

userEntitlementRequest = userEntitlementRequest +'</soapenv:Body></soapenv:Envelope>';
context.setVariable("esprequest",userEntitlementRequest);



			
