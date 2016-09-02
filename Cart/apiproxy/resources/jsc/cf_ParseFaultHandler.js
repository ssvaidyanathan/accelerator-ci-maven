//  ##t-mobile.target##

var faultName = context.getVariable("faultName");
var subStatusDesc = context.getVariable("subStatusDesc");
var statusDetail = context.getVariable("statusDetail");
var statusCode = context.getVariable("statusCode");
var subStatusCode = context.getVariable("subStatusCode");

var errorStatusCode = context.getVariable("error.status.code");

var acceptHeader = context.getVariable("request.header.Accept");
var errorResponseType = "json";

// !! assuming that subStatusDesc is null or empty string when we get successful response
if( (subStatusDesc == null) || (subStatusDesc == "") )
{
    if (faultName == "SourceMessageNotAvailable"){
		subStatusDesc = "Extrave Variable Reference Not Found";
		statusDetail = "The variable could not be extracted";
		statusCode = "401";
		subStatusCode = "POL0001";
	}
    else if (faultName == "SetVariableFailed"){
		subStatusDesc = "Variable Reference Not Found";
		statusDetail = "The variable could not be assigned";
		statusCode = "401";
		subStatusCode = "POL0002";
	}
    else if (faultName == "SetVariableFailed"){
		subStatusDesc = "Variable Reference Not Found";
		statusDetail = "The variable could not be assigned";
		statusCode = "401";
		subStatusCode = "POL0003";
	}
    else if (faultName == "FailedToResolveAPIKey"){
		subStatusDesc = "Bad or Missing API Key";
		statusDetail = "Apikey verification failed - Invalid ApiKey";
		statusCode = "401";
		subStatusCode = "POL0004";
	}
    else if (faultName == "InvalidAPICallAsNoApiProductMatchFound"){
		subStatusDesc = "Unauthorized";
		statusDetail = "Privacy verification failed - Invalid App Details";
		statusCode = "401";
		subStatusCode = "POL0005";
	}
	else if (faultName == "invalid_access_token"){
		subStatusDesc = "Unauthorized";
		statusDetail = "Privacy verification failed - Invalid Access Token";
		statusCode = "401";
		subStatusCode = "POL0006";
	}
	else if (faultName == "access_token_expired"){
		subStatusDesc = "Unauthorized";
		statusDetail = "Privacy verification failed - Access Token Expired";
		statusCode = "401";
		subStatusCode = "POL0007";
	}
	else if (faultName == "SpikeArrestViolation"){
		subStatusDesc = "Server Busy";
		statusDetail = "Service Error - System Has Exceeded Maximum Number of Permitted Requests";
		statusCode = "503";
		subStatusCode = "SVC0008";
	}
	else if (faultName == "QuotaViolation"){
		subStatusDesc = "Server Busy";
		statusDetail = "Service Error - The client app has exceeded maximum number of permitted requests";
		statusCode = "503";
		subStatusCode = "SVC0009";
	}
	else if (faultName == "JsonPathParsingFailure"){
			subStatusDesc = "Bad Request";
			statusDetail = "Invalid Input Value - Payload";
			statusCode = "400";
			subStatusCode = "SVC0010";
    }
    else if (faultName == "ExecutionFailed"){
			subStatusDesc = "Service Callout Failed";
			statusDetail = "Service Error - Remote System could not be reached";
			statusCode = "502";
			subStatusCode = "SVC0011";
    }
    else if ((faultName == "") || (faultName == null)){
		subStatusDesc = "Internal Server Error";
		statusDetail = "Service Error - The server encountered an error while attempting to fulfill the request.";
		statusCode = "500";
		subStatusCode = "SVC0012";
	}
	else {
		subStatusDesc = "Internal Server Error - UnAnticipated";
		statusDetail = "Service Error - The server encountered an error while attempting to fulfill the request.";
		statusCode = errorStatusCode;
		subStatusCode = "SVC0111";
	}
}
else  if ( (!(subStatusDesc == null)) || (!(subStatusDesc == "")) )
{
	subStatusDesc = subStatusDesc;
	statusDetail = statusDetail;
	statusCode = statusCode;
    subStatusCode = subStatusCode;
}

if	((acceptHeader == "application/xml") ||(acceptHeader == "text/xml") ){
	 errorResponseType = "xml";
}

context.setVariable("errorResponseType", errorResponseType);
context.setVariable("subStatusDesc",subStatusDesc);
context.setVariable("statusDetail",statusDetail);
context.setVariable("statusCode",statusCode);
context.setVariable("subStatusCode",subStatusCode);
