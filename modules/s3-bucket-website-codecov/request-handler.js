function handler(event) {
  var request = event.request;
  var uri = request.uri;

  if (uri === "/") {
    return request;
  }

  if (uri === "/index.html") {
    var newUrl = "/";
    var response = {
      statusCode: 302,
      statusDescription: "Found",
      headers: { location: { value: newUrl } },
    };

    return response;
  }

  return request;
}
