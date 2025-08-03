function handler(event) {
  var request = event.request;
  var uri = request.uri;

  var redirectTo = "${redirect_to}" + uri;
  var response = {
    statusCode: 302,
    statusDescription: "Found",
    headers: { location: { value: redirectTo } },
  };

  return response;
}
