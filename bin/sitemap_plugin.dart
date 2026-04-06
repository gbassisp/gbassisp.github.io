import 'dart:async';

import 'package:lean_extensions/lean_extensions.dart';
import 'package:static_shock/static_shock.dart';

class SitemapPlugin implements StaticShockPlugin {
  const SitemapPlugin({required this.baseUrl});
  final String baseUrl;
  @override
  String get id => 'simple-sitemap';

  @override
  void configure(
    StaticShockPipeline pipeline,
    StaticShockPipelineContext context,
    StaticShockCache cache,
  ) {
    pipeline.transformPages(
      _SimpleSiteMapTransformer(baseUrl: baseUrl),
    );
  }
}

class _SimpleSiteMapTransformer implements PageTransformer {
  _SimpleSiteMapTransformer({required this.baseUrl});
  final List<String> links = [];
  final String baseUrl;

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
}
