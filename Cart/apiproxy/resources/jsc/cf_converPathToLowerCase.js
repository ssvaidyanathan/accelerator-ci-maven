var uriPath = context.getVariable("requestpath.definition");

if ( typeof uriPath != 'undefined' && uriPath != null) {
	uriPath=uriPath.toLowerCase();
	context.setVariable("requestpath.definition",uriPath);
}
