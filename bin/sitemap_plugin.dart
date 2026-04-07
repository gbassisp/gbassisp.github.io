import 'dart:async';

import 'package:lean_extensions/lean_extensions.dart';
import 'package:static_shock/static_shock.dart';

class SitemapPlugin implements StaticShockPlugin {
  const SitemapPlugin({required this.baseUrl});
  // TODO(gbassisp): remove this when static_shock adds a way to get the base
  // url because this api is broken: https://staticshock.io/guides/base-url/
  final String baseUrl;
  @override
  String get id => 'simple-sitemap';

  @override
  void configure(
    StaticShockPipeline pipeline,
    StaticShockPipelineContext context,
    StaticShockCache cache,
  ) {
    final base = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';

    pipeline.transformPages(
      _SimpleSiteMapTransformer(baseUrl: base),
    );
  }
}

class _SimpleSiteMapTransformer implements PageTransformer {
  _SimpleSiteMapTransformer({required this.baseUrl});
  final List<String> links = [];
  final String baseUrl;
  String get robotsContent => '''
User-agent: *
Allow: /

Sitemap: ${baseUrl}sitemap.txt
''';

  @override
  FutureOr<void> transformPage(StaticShockPipelineContext context, Page page) {
    final isHtml = page.destinationPath?.value.endsWith('.html') ?? false;
    final Object? isIncluded = page.data['sitemap'] ?? true;
    if (isHtml && isIncluded.isTruthy) {
      links
        ..add(page.destinationPath!.value)
        ..sort();
    }

    _createSiteMap(context, page);
    _createRobotsTxt(context, page);
  }

  void _createSiteMap(StaticShockPipelineContext context, Page page) {
    const destinationPath = FileRelativePath('', 'sitemap', 'txt');

    final content =
        AssetContent.text(links.map((link) => '$baseUrl$link').join('\n'));
    context.addAsset(
      Asset(
        destinationPath: destinationPath,
        destinationContent: content,
      ),
    );
  }

  void _createRobotsTxt(StaticShockPipelineContext context, Page page) {
    const destinationPath = FileRelativePath('', 'robots', 'txt');

    final content = AssetContent.text(robotsContent);
    context.addAsset(
      Asset(
        destinationPath: destinationPath,
        destinationContent: content,
      ),
    );
  }
}
