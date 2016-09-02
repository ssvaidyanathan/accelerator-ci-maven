var vProdSaaSOrgEnvs	 = 	context.getVariable("ProdSaaSOrgEnvs");   
var vProdOnPremOrgEnvs   = 	context.getVariable("ProdOnPremOrgEnvs");  
var vCurrentOrg 		 = 	context.getVariable("organization.name");
var vCurrentEnv 		 = 	context.getVariable("environment.name");
var vNonProdOnPremOrgEnvs   = 	context.getVariable("NonProdOnPremOrgEnvs");

if ((vProdSaaSOrgEnvs  !== null) && (vProdSaaSOrgEnvs.indexOf(vCurrentOrg)  > -1) && (vProdSaaSOrgEnvs.indexOf(vCurrentEnv)  > -1)) {
	context.setVariable("ELFEndpointType",'SaaSProd');
}

if ((vProdOnPremOrgEnvs  !== null) && (vProdOnPremOrgEnvs.indexOf(vCurrentOrg)  > -1) && (vProdOnPremOrgEnvs.indexOf(vCurrentEnv)  > -1)) {
	context.setVariable("ELFEndpointType",'OnPremProd');
}

if ((vNonProdOnPremOrgEnvs  !== null) && (vNonProdOnPremOrgEnvs.indexOf(vCurrentOrg)  > -1) && (vNonProdOnPremOrgEnvs.indexOf(vCurrentEnv)  > -1)) {
	context.setVariable("ELFEndpointType",'OnPremNonProd');
}
