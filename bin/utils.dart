import 'package:lean_extensions/lean_extensions.dart';
import 'package:static_shock/static_shock.dart';

String baseUrlResolvePath(
  String baseUrl,
  String path, {
  bool dropIndexHtml = false,
}) {
  final base = urlWithTrailingSlash(baseUrl);
  var p = urlWithoutLeadingSlash(path);
  if (dropIndexHtml) {
    p = p.replaceLast(RegExp(r'index.html$'), '');
  }

  assert(Uri.parse(base).isAbsolute, 'base must be an absolute URI: $base');
  assert(!Uri.parse(p).isAbsolute, 'path must be a relative URI: $path');

  return '$base$p';
}

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

extension SimplePickersAndPlugins on StaticShock {
  StaticShock pickDefault() {
    return this
      ..pick(DirectoryPicker.parse('.well-known'))
      ..pick(DirectoryPicker.parse('assets'))
      ..pick(DirectoryPicker.parse('images'))
      ..pick(const FilePicker(FileRelativePath('', 'robots', 'txt')))
      ..pick(const FilePicker(FileRelativePath('', 'humans', 'txt')));
  }
}
