String urlWithTrailingSlash(String url) {
  if (url.endsWith('/')) {
    return url;
  }
  return '$url/';
}

String urlWithoutLeadingSlash(String url) {
  if (url.startsWith('/')) {
    return urlWithoutLeadingSlash(url.substring(1));
  }
  return url;
}
