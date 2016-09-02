var abfEntitlements = context.getVariable("accesstoken.abfEntitlements");
var id = context.getVariable('id');
var custInfo = context.getVariable('custInfo');
var entitlementscachemsgContent = context.getVariable('entitlementscachemsg.content');
var userABFListVar = context.getVariable('userABFListVar');

if(userABFListVar.indexOf('apiError')!= -1){
	
	context.setVariable('apiError',userABFListVar);
	
}else {
	var entitlementsJSON = {};
	
	if(abfEntitlements != null && abfEntitlements != "") {
		entitlementsJSON = JSON.parse(abfEntitlements);
	}
	
	entitlementsJSON[id+'_'+custInfo]=entitlementscachemsgContent;
	entitlementsJSON[id+'_'+custInfo+'_ABFList']=userABFListVar;
	
	context.setVariable('abfEntitlements',JSON.stringify(entitlementsJSON));
	context.setVariable('userEntitlements',entitlementscachemsgContent);
}