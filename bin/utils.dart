import 'package:static_shock/static_shock.dart';

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
