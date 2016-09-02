// 
var supervisorList = context.getVariable('supervisorIdListVar');

var supervisorListArr = '';
 if (supervisorList != null && supervisorList != '')
 {
     supervisorListArr=supervisorList.split(',');
 }
 
 var supervisorid1 =null;
 var transctionid1 =null;
 var supervisorid2 =null;
 var transctionid2 =null;
 var supervisorid3 =null;
 var transctionid3 =null;
 var supervisorid4 =null;
 var transctionid4 =null;
 var supervisorid5 =null;
 var transctionid5 =null;
 var supervisorEntitlementsVar1 = null; 
 var supervisorEntitlementsVar2 = null;
 var supervisorEntitlementsVar3 = null;
 var supervisorEntitlementsVar4 = null;
 var supervisorEntitlementsVar5 = null;
 
 var abfEntitlements = context.getVariable("accesstoken.abfEntitlements");

//Parsing the entitlements JSON body
var entitlementsJSON = {};
if(abfEntitlements != null && abfEntitlements != ''){
	entitlementsJSON=JSON.parse(abfEntitlements);
}

 if (supervisorListArr != null && supervisorListArr.length >0){
 	context.setVariable('arrLenght',supervisorListArr.length);
 	if(supervisorListArr.length>1 && supervisorListArr[1] != null && supervisorListArr[1]!=''){
 		context.setVariable("supervisor1 : ",supervisorListArr[1]);
 		var supervisorTxids = supervisorListArr[1].split('~');
 		supervisorid1 = supervisorTxids[0];
 		transctionid1 = supervisorTxids[1];
 		context.setVariable("sEntitlements: ",entitlementsJSON[transctionid1+'_DEFAULT']);
 		var sEntitlements = entitlementsJSON[transctionid1+'_DEFAULT'];
 		 if (sEntitlements != null && sEntitlements != '')
		 {
		 	var supervisorEntArr = sEntitlements.split('?>');
		 	if (supervisorEntArr.lenght > 1){
		 		supervisorEntitlementsVar1 = supervisorEntArr[1];
		 	}else{
                supervisorEntitlementsVar1 = supervisorEntArr[0];
            }
		 }
 	}
 	if(supervisorListArr.length>2 && supervisorListArr[2] != null && supervisorListArr[2]!=''){
 		context.setVariable("supervisor2 : ",supervisorListArr[2]);
 		var supervisorTxids = supervisorListArr[2].split('~');
 		supervisorid2 = supervisorTxids[0];
 		transctionid2 = supervisorTxids[1];
 		var sEntitlements = entitlementsJSON[transctionid2+'_DEFAULT'];
 		 if (sEntitlements != null && sEntitlements != '')
		 {
		 	var supervisorEntArr = sEntitlements.split('?>');
		 	if (supervisorEntArr.lenght > 1){
		 		supervisorEntitlementsVar2 = supervisorEntArr[1];
		 	}else{
                supervisorEntitlementsVar2 = supervisorEntArr[0];
            }
		 }
 	}
 	if(supervisorListArr.length>3 && supervisorListArr[3] != null && supervisorListArr[3]!=''){
 		var supervisorTxids = supervisorListArr[3].split('~');
 		supervisorid3 = supervisorTxids[0];
 		transctionid3 = supervisorTxids[1];
 		var sEntitlements = entitlementsJSON[transctionid3+'_DEFAULT'];
 		 if (sEntitlements != null && sEntitlements != '')
		 {
		 	var supervisorEntArr = sEntitlements.split('?>');
		 	if (supervisorEntArr.lenght > 1){
		 		supervisorEntitlementsVar3 = supervisorEntArr[1];
		 	}else{
                supervisorEntitlementsVar3 = supervisorEntArr[0];
            }
		 }
 	}
 	if(supervisorListArr.length>4 && supervisorListArr[4] != null && supervisorListArr[4]!=''){
 		var supervisorTxids = supervisorListArr[4].split('~');
 		supervisorid4 = supervisorTxids[0];
 		transctionid4 = supervisorTxids[1];
 		var sEntitlements = entitlementsJSON[transctionid4+'_DEFAULT'];
 		 if (sEntitlements != null && sEntitlements != '')
		 {
		 	var supervisorEntArr = sEntitlements.split('?>');
		 	if (supervisorEntArr.lenght > 1){
		 		supervisorEntitlementsVar4 = supervisorEntArr[1];
		 	}else{
                supervisorEntitlementsVar4 = supervisorEntArr[0];
            }
		 }
 	}
	if(supervisorListArr.length>5 && supervisorListArr[5] != null && supervisorListArr[5]!=''){
 		var supervisorTxids = supervisorListArr[5].split('~');
 		supervisorid5 = supervisorTxids[0];
 		transctionid5 = supervisorTxids[1];
 		var sEntitlements = entitlementsJSON[transctionid1+'_DEFAULT'];
 		 if (sEntitlements != null && sEntitlements != '')
		 {
		 	var supervisorEntArr = sEntitlements.split('?>');
		 	if (supervisorEntArr.lenght > 1){
		 		supervisorEntitlementsVar5 = supervisorEntArr[1];
		 	}else{
                supervisorEntitlementsVar5 = supervisorEntArr[0];
            }
		 }
 	}
 }
 
  context.setVariable('supervisorId1',supervisorid1);
  context.setVariable('supervisorId2',supervisorid2);
  context.setVariable('supervisorId3',supervisorid3);
  context.setVariable('supervisorId4',supervisorid4);
  context.setVariable('supervisorId5',supervisorid5);
  context.setVariable('transactionId1',transctionid1);
  context.setVariable('transactionId2',transctionid2);
  context.setVariable('transactionId3',transctionid3);
  context.setVariable('transactionId4',transctionid4);
  context.setVariable('transactionId5',transctionid5);
  context.setVariable('custInfo','DEFAULT');
  context.setVariable('supervisorEntitlementsVar1', supervisorEntitlementsVar1);
  context.setVariable('supervisorEntitlementsVar2', supervisorEntitlementsVar2);
  context.setVariable('supervisorEntitlementsVar3', supervisorEntitlementsVar3);
  context.setVariable('supervisorEntitlementsVar4', supervisorEntitlementsVar4);
  context.setVariable('supervisorEntitlementsVar5', supervisorEntitlementsVar5);
  
 