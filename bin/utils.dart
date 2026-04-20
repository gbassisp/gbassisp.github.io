String urlWithTrailingSlash(String url) {
  final u = url.trim();
  if (u.endsWith('/')) {
    return urlWithTrailingSlash(u.substring(0, u.length - 1));
  }
  return '$u/';
}

String urlWithoutLeadingSlash(String url) {
  final u = url.trim();
  if (u.startsWith('/')) {
    return urlWithoutLeadingSlash(u.substring(1));
  }
  return u;
}
