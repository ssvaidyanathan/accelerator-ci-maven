var uriPath = context.getVariable('requestpath.definition');

if (uriPath !== null) {
    uriPath = uriPath.toLowerCase();
    context.setVariable('requestpath.definition', uriPath);
}