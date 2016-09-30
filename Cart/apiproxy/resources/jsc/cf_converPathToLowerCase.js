var uriPath = context.getVariable('requestpath.definition');
context.setVariable('requestpath.definition', getLowerCase(uriPath));

function getLowerCase(uriPath){
	return uriPath.toLowerCase();
}