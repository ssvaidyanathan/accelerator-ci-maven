var userABFListVar = context.getVariable("userABFListVar");
var apiABFCacheVar = context.getVariable("apiABFCacheVar");
var masterDealerCode = context.getVariable("masterDealerCode");
       
if ( typeof userABFListVar == 'undefined' || userABFListVar == null) {
	context.setVariable("userABFListVar",'');
	userABFListVar="";
}

if (typeof apiABFCacheVar == 'undefined' || apiABFCacheVar == null) {
	context.setVariable("apiABFCacheVar",'');
	apiABFCacheVar="";
}

if (typeof masterDealerCode == 'undefined' || masterDealerCode == null) {
	context.setVariable("masterDealerCode",'');
	masterDealerCode=""
}

apiABFsVar = apiABFCacheVar.split(':')[0].split(',');
userABFsVar = userABFListVar.split(',');
var permissionVar = 'false';

for(var i=0; i<apiABFsVar.length && permissionVar != 'true'; i++) {
	for(var j=0; j<userABFsVar.length && permissionVar != 'true'; j++){
		if ((apiABFsVar[i]!='' && apiABFsVar[i] == userABFsVar[j]) || apiABFsVar[i] == "ANONYMOUS" || (apiABFsVar[i]!='' && apiABFsVar[i] == masterDealerCode))  {
			permissionVar = 'true';
		}//if
	}//for
}//for

context.setVariable("permissionVar",permissionVar);