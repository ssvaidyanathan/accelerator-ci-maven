var targetSystem = context.getVariable("wss.targetSystem");
var content = context.getVariable("request.content");
var service = context.getVariable("capi.target.route.service");

if (service == null) {
	service = "";
}

//Mixed combination
if (service == "ContactWSIL" || service == "CustomerSummaryWSIL" || service == "OrderReferenceDataWSIL" || service == "UsageWSIL" || service == "LineOfServiceUpdateWSIL" || service == "MigrationPaymentEnterprise" || service == "EventWSIL" || service == "AlertEnterprise" || service == "ProductOfferingDetailsWSIL" || service == "InvoiceEnterprise") {
	content = content.replace(/v1:resourceName/g,"base:resourceName").replace(/v1:actionName/g,"base:actionName");
	content = content.replace(/pfx:resourceName/g,"base:resourceName").replace(/pfx:actionName/g,"base:actionName");
	content = content.replace(/pfx2:resourceName/g,"base:resourceName").replace(/pfx2:actionName/g,"base:actionName");
	content = content.replace(/pfx3:resourceName/g,"base:resourceName").replace(/pfx3:actionName/g,"base:actionName");
	content = content.replace(/pfx4:resourceName/g,"base:resourceName").replace(/pfx4:actionName/g,"base:actionName");
	content = content.replace(/pfx5:resourceName/g,"base:resourceName").replace(/pfx5:actionName/g,"base:actionName");
	content = content.replace(/pfx10:resourceName/g,"base:resourceName").replace(/pfx10:actionName/g,"base:actionName");
	content = content.replace(/ent:resourceName/g,"base:resourceName").replace(/ent:actionName/g,"base:actionName");
}//All base
else if (service == "UserOIM" || service == "StoreOperationsEnterprise" || service == "EventEnterprise" || service == "CallLogEnterprise" || service == "SecurityWSIL" || service == "OrderWSIL" || service == "OrderSummaryWSIL" || service == "NumberManagementWSIL" || service == "CartWSIL" || service == "CaseWSIL" || service == "DeviceWSIL" || service == "CustomerDetailsWSIL" || service == "CustomerUpdateWSIL" || service == "FinancialAccountDetailsWSIL" || service == "FinancialAccountWSIL" || service == "LineOfServiceDetailsWSIL" || service == "PaymentDataWSIL" || service == "PaymentWSIL" || service == "PaymentProcessorWSIL" || service == "OrderUpdateWSIL" || service == "CustomerNoteEnterprise" || service == "NetworkEngineeringWSIL" || service == "ProductOfferingSummaryWSIL"  || service == "Ericsson_LineOfServiceDetailsWSIL"){
	content = content.replace(/v1:resourceName/g,"base:resourceName").replace(/v1:actionName/g,"base:actionName").replace(/v1:isAccessAllowed/g,"base:isAccessAllowed").replace(/v1:responseAttribute/g,"base:responseAttribute");
	content = content.replace(/pfx:resourceName/g,"base:resourceName").replace(/pfx:actionName/g,"base:actionName").replace(/pfx:isAccessAllowed/g,"base:isAccessAllowed").replace(/pfx:responseAttribute/g,"base:responseAttribute");
	content = content.replace(/pfx2:resourceName/g,"base:resourceName").replace(/pfx2:actionName/g,"base:actionName").replace(/pfx2:isAccessAllowed/g,"base:isAccessAllowed").replace(/pfx2:responseAttribute/g,"base:responseAttribute");
	content = content.replace(/pfx3:resourceName/g,"base:resourceName").replace(/pfx3:actionName/g,"base:actionName").replace(/pfx3:isAccessAllowed/g,"base:isAccessAllowed").replace(/pfx3:responseAttribute/g,"base:responseAttribute");
	content = content.replace(/pfx4:resourceName/g,"base:resourceName").replace(/pfx4:actionName/g,"base:actionName").replace(/pfx4:isAccessAllowed/g,"base:isAccessAllowed").replace(/pfx4:responseAttribute/g,"base:responseAttribute");
	content = content.replace(/pfx5:resourceName/g,"base:resourceName").replace(/pfx5:actionName/g,"base:actionName").replace(/pfx5:isAccessAllowed/g,"base:isAccessAllowed").replace(/pfx5:responseAttribute/g,"base:responseAttribute");
	content = content.replace(/pfx10:resourceName/g,"base:resourceName").replace(/pfx10:actionName/g,"base:actionName").replace(/pfx10:isAccessAllowed/g,"base:isAccessAllowed").replace(/pfx10:responseAttribute/g,"base:responseAttribute");
}// else All v1 - do nothing

context.setVariable("request.content",content);