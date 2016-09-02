var errorCodeMapsVar = "";
if ((context.getVariable("errorCodeMap1")) !== null)  {
   errorCodeMapsVar = errorCodeMapsVar + context.getVariable("errorCodeMap1") ;
}
if ((context.getVariable("errorCodeMap2")) !== null)  {
   errorCodeMapsVar = errorCodeMapsVar + context.getVariable("errorCodeMap2") ;
}
if ((context.getVariable("errorCodeMap3")) !== null)  {
   errorCodeMapsVar = errorCodeMapsVar + context.getVariable("errorCodeMap3") ;
}
if ((context.getVariable("errorCodeMap4")) !== null)  {
   errorCodeMapsVar = errorCodeMapsVar + context.getVariable("errorCodeMap4") ;
}
if ((context.getVariable("errorCodeMap5")) !== null)  {
   errorCodeMapsVar = errorCodeMapsVar + context.getVariable("errorCodeMap5") ;
}
if ((context.getVariable("commonErrorCodeMap")) !== null)  {
   errorCodeMapsVar = errorCodeMapsVar + context.getVariable("commonErrorCodeMap") ;
}

errorCodeMapsVar = "<Maps>" + errorCodeMapsVar + "</Maps>";
context.setVariable("errorCodeMaps",errorCodeMapsVar);
