// Mask sensitive data

var targetRequest = context.getVariable("elfLog.targetRequest");
var targetResponse = context.getVariable("elfLog.targetResponse");
var contentType = context.getVariable("elfLog.contentType");
var acceptType = context.getVariable("elfLog.acceptType");
var proxyRequest = context.getVariable("elfLog.proxyRequest");
var proxyResponse = context.getVariable("elfLog.proxyResponse");

targetRequest = maskXMLData(targetRequest,maskConfigData);
targetResponse = maskXMLData(targetResponse,maskConfigData);

if(acceptType != null && acceptType.indexOf("xml")> -1)
{
	proxyResponse = maskXMLData(proxyResponse,maskConfigData);
}
else
{
	proxyResponse = maskJSONData(proxyResponse,maskConfigData);
}
if(proxyRequest != null && proxyRequest != '') {
	if(contentType != null && contentType.indexOf("xml")> -1) {
		proxyRequest = maskXMLData(proxyRequest,maskConfigData);
	} else {		
		proxyRequest =  proxyRequest.replace(/[\r\n]/g, "");
		proxyRequest =  proxyRequest.replace(/ /g, ""); 
		proxyRequest = maskJSONData(proxyRequest,maskConfigData);
	}
}
context.setVariable("elfLog.targetRequest",targetRequest);
context.setVariable("elfLog.targetResponse",targetResponse);
context.setVariable("elfLog.proxyRequest",proxyRequest);
context.setVariable("elfLog.proxyResponse",proxyResponse);

// Remove line breaks


var isError = context.getVariable("is.error");
var logType="SUCCESS";

if (isError == true) { logType="ERROR";}

var elfLog = context.getVariable("organization.name") + "." + context.getVariable("environment.name") + "." + context.getVariable("apiproxy.name");
elfLog = elfLog + "||serviceTransId=" + context.getVariable("serviceTransactionId");
elfLog = elfLog + "||interactionId=" + context.getVariable("elfLog.interactionId");
elfLog = elfLog + "||logType=" + logType + "||httpMethod=" + context.getVariable("elfLog.requestVerb");
elfLog = elfLog + "||partnerId=" + context.getVariable("senderid");
elfLog = elfLog + "||operationName=" + context.getVariable("requestpath.definition") + "-" + context.getVariable("elfLog.requestVerb");
elfLog = elfLog + "||proxyURL=" + context.getVariable("proxy.url");
elfLog = elfLog + "||targetServer=" + context.getVariable("target.scheme") + "://" + context.getVariable("target.host") + ":" + context.getVariable("target.port") + context.getVariable("elfLog.targetURI");
elfLog = elfLog + "||eventDate=" + context.getVariable("system.timestamp");
elfLog = elfLog + "||proxyFlowName=" + context.getVariable("elfLog.proxyFlowName");
elfLog = elfLog + "||targetName=" + context.getVariable("target.name");
elfLog = elfLog + "||targetOperation=" + context.getVariable("elfLog.targetOperation");
elfLog = elfLog + "||targetReqStart=" + context.getVariable("target.sent.start.timestamp");
elfLog = elfLog + "||targetReqEnd=" + context.getVariable("target.sent.end.timestamp");
elfLog = elfLog + "||targetRespStart=" + context.getVariable("target.received.start.timestamp");
elfLog = elfLog + "||targetRespEnd=" + context.getVariable("target.received.end.timestamp");
elfLog = elfLog + "||proxyReqStart=" + context.getVariable("client.received.start.timestamp");
elfLog = elfLog + "||proxyReqEnd=" + context.getVariable("client.received.end.timestamp");
elfLog = elfLog + "||CallerIP=" + context.getVariable("proxy.client.ip");

var enabledOESCallout = context.getVariable("elfLog.OES.ServiceCalloutEnabled");
if (enabledOESCallout) {
	elfLog = elfLog + "||OESTargetURI" + context.getVariable("elfLog.OES.targetURI");
	elfLog = elfLog + "||atttargetRequest=" + context.getVariable("elfLog.OES.targetRequest");
	elfLog = elfLog + "||atttargetResponse=" + context.getVariable("elfLog.OES.targetResponse");
}

elfLog = elfLog + "||proxyRequestPayloadType=" + context.getVariable("elfLog.contentType") + "||attproxyRequest=" + context.getVariable("elfLog.proxyRequest");
elfLog = elfLog + "||proxyResponsePayloadType=" + context.getVariable("elfLog.acceptType") + "||attproxyResponse=" + context.getVariable("elfLog.proxyResponse");
elfLog = elfLog + "||atttargetRequest=" + context.getVariable("elfLog.targetRequest");
elfLog = elfLog + "||atttargetResponse=" + context.getVariable("elfLog.targetResponse");

elfLog = elfLog.replace(/(\r\n|\n|\r)/gm,"");

context.setVariable("elf.logMsg", elfLog);
