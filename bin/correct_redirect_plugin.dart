import 'dart:async';

import 'package:lean_extensions/lean_extensions.dart';
import 'package:static_shock/static_shock.dart';

import 'utils.dart';

/// Fixes the buggy [RedirectsPlugin] from static_shock.
class CorrectRedirectsPlugin extends RedirectsPlugin {
  const CorrectRedirectsPlugin({required this.baseUrl});
  final String baseUrl;

  @override
  FutureOr<void> configure(
    StaticShockPipeline pipeline,
    StaticShockPipelineContext context,
    StaticShockCache pluginCache,
  ) {
    pipeline.finish(
      CorrectRedirectsFinisher(baseUrl: urlWithTrailingSlash(baseUrl)),
    );
  }
}

/// Fixes the buggy [RedirectsFinisher] from static_shock.
class CorrectRedirectsFinisher extends RedirectsFinisher {
  CorrectRedirectsFinisher({required this.baseUrl});
  final String baseUrl;

  @override
  void execute(StaticShockPipelineContext context) {
    // let the original create all buggy redirect pages, then we fix them
    super.execute(context);
    final pagesWithRedirects = context.pagesIndex.pages.where(
      (page) => page.destinationContent.orEmpty.contains(
        '<!-- Page redirect tags -->',
      ),
    );

    for (final page in pagesWithRedirects) {
      final content = page.destinationContent.orEmpty;

// read all <meta http-equiv="refresh" content="0; url={regex here}" />
// and replace with <meta http-equiv="refresh" content="0; url={baseUrl}{regex match here}" />
      final redirectMetaRegExp = RegExp(
        '<meta http-equiv="refresh" content="0; url=(.*?)" />',
        caseSensitive: false,
      );

// same for     <link rel="canonical" href="//packages/any_date/" />
      final canonicalMetaRegExp = RegExp(
        '<link rel="canonical" href="(.*?)" />',
        caseSensitive: false,
      );

      final newContent = content //
          .replaceAllMapped(redirectMetaRegExp, (match) {
        final url = urlWithoutLeadingSlash(match.group(1)!);
        return '<meta http-equiv="refresh" content="0; url=$baseUrl$url" />';
      }) //
          .replaceAllMapped(canonicalMetaRegExp, (match) {
        final url = urlWithoutLeadingSlash(match.group(1)!);
        return '<link rel="canonical" href="$baseUrl$url" />';
      });

      page.destinationContent = newContent;
    }
  }
}
