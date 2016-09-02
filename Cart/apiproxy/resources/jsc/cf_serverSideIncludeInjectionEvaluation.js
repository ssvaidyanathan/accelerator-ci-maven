var regex = [];
regex[0] = RegExp("<!--\\s*#\\s*(include|exec|echo|config|printenv|fsize).*-->","i");

var requestPayload = context.getVariable("request.content");
	
if (requestPayload != "" && requestPayload != null) {
	
	for(var i=0;i<regex.length;i++) {
		if (regex[i].test(requestPayload)) {
			//throw new Error("Payload contains suspicious content.");
			context.setVariable("tp.fault.statusCode","400");
			context.setVariable("tp.fault.reasonPhrase","Bad Request");
			context.setVariable("tp.fault.exceptionType","Bad Request");
			context.setVariable("tp.fault.messageId","NA");
			context.setVariable("tp.fault.messageText","Payload has a suspicious content. Request is refused.");
			context.setVariable("tp.fault.messageVariables","[ NA ]");

			context.setVariable("threatProtectionEvaluationStatus","failed");
			break;
		}
	}
}