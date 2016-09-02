// Remove line breaks


var entitlements = context.getVariable("entitlementscachemsg.content");
var entitlements1 = context.getVariable("userEntitlements");


if (typeof entitlements != 'undefined' && entitlements != null && entitlements != ''){
	var entitlementArr=entitlements.split('?>');
	
	if (entitlementArr.length > 1){
		entitlements=entitlementArr[1];
	} else{
		entitlements=entitlementArr[0];
	}

	context.setVariable("entitlementscachemsg.content",entitlements);
}

<!--
if (typeof entitlements1 != 'undefined' && entitlements1 != null && entitlements != ''){
	var entitlementArr1 = entitlements1.split('?>');
	if (entitlementArr1.length > 1){
		entitlements1=entitlementArr1[1];
	} else{
		entitlements1=entitlementArr1[0];
	}
	context.setVariable("entitlementscachemsg.content",entitlements1);
}
-->

