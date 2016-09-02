var regex = [];
regex[0] = RegExp("(?=.*/)(?=.*(<\\s*script\\b[^>]*>[^<]+<\\s*.+\\s*[s][c][r][i][p][t]\\s*>))","i");
regex[1] = RegExp("n\\s*slash");
regex[2] = RegExp("n/\\s*slash");
regex[3] = RegExp("n\"\\s*quotes");
regex[4] = RegExp("n\\b\\s*space");
regex[5] = RegExp("n\\f\\s*forwardfeed");
regex[6] = RegExp("n\\n\\s*newline");
regex[7] = RegExp("n\\r\\s*carria");
regex[8] = RegExp("n\\t\\s*tab");
regex[9] = RegExp("n\\uFFFF\\s*hex");

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