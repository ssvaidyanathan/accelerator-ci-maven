// CleanupJsonPayload.js
// JSON has ~STR~ embedded to force fields to be treated as strings, and ~ARRAY~ as array placeholders to make sure that
// array fields are converted to JSON as arrays even if array is empty or only contains one value
// 1) replaces empty strings with null
// 2) removes remaining string specifiers
// 3) removes array place holders, including trailing commas
// 4) removes array place holders without trailing commas
// 5) Do 1 & 2 for integers

var jsonResponse = context.getVariable("response.content").replace(/"~STR~"/, "null").replace(/~STR~/g, "").replace(/"~ARRAY~",/g, "").replace(/,"~ARRAY~"/g, "").replace(/"~ARRAY~"/g, "").replace(/"~INT~~INT~"/g, "null").replace(/"~INT~/g, "").replace(/~INT~"/g, "");

var resp = JSON.parse(jsonResponse).response;
if(resp != null) {
  	response.content =JSON.stringify(resp);
} else{
  	response.content = jsonResponse;
}
