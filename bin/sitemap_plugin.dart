import 'package:lean_extensions/lean_extensions.dart';
import 'package:static_shock/static_shock.dart';

import 'utils.dart';

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
    final base = urlWithTrailingSlash(baseUrl);

    pipeline.finish(
      _SimpleSiteMapFinisher(baseUrl: base),
    );
  }
}

class _SimpleSiteMapFinisher implements Finisher {
  _SimpleSiteMapFinisher({required this.baseUrl});
  final Set<String> links = {};
  final String baseUrl;
  String get robotsContent => '''
User-agent: *
Allow: /

Sitemap: ${baseUrl}sitemap.txt
''';

  @override
  void execute(StaticShockPipelineContext context) {
    final pages = context.pagesIndex.pages.toArray();

    for (final page in pages) {
      final isHtml = page.destinationPath?.value.endsWith('.html') ?? false;
      final Object? isIncluded = page.data['sitemap'] ?? true;
      if (isHtml && isIncluded.isTruthy) {
        links.add(baseUrl + page.destinationPath!.value);
      }
    }

    _createSiteMap(context);
    _createRobotsTxt(context);
  }

  void _createSiteMap(StaticShockPipelineContext context) {
    const destinationPath = FileRelativePath('', 'sitemap', 'txt');
    final canonicalLinks = links.map((e) {
      if (e.endsWith('index.html')) {
        return e.replaceLast('index.html', '');
      }
      return e;
    }).toArray()
      ..sort();

    final content = AssetContent.text(canonicalLinks.join('\n'));
    context.addAsset(
      Asset(
        destinationPath: destinationPath,
        destinationContent: content,
      ),
    );
  }

  void _createRobotsTxt(StaticShockPipelineContext context) {
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
