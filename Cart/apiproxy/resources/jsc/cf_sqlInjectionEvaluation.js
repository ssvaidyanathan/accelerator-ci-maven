var regex = [];
regex[0] = RegExp("(?=.*')(?=.*;)(?=.*(\\b(alter|create|delete|(drop\\s*table)|(truncate\\s*table)|exec(ute){0,1}|(insert\\s*into)|merge|select|update|union( +all){0,1})\\b))","i");
regex[1] = RegExp("\\b\\d+\\b\\s*;\\s*(\\b(alter|create|delete|(drop\\s*table)|(truncate\\s*table)|exec(ute){0,1}|(insert\\s*into)|merge|select|update|union( +all){0,1})\\b)\\s*\\w+","i");
regex[2] = RegExp("&quot;\\s*\\bor\\b\\s*&quot;\\s*&quot;=&quot;","i");

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