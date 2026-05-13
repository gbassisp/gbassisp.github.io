import 'package:html/parser.dart' as html_parser;
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
        final url = baseUrlResolvePath(
          baseUrl,
          page.destinationPath!.value,
          dropIndexHtml: true,
        );
        final canonicalUri = _canonicalUri(baseUrl, page);

        final isCanonical = canonicalUri == null || canonicalUri == url;

        if (isCanonical) {
          links.add(url);
        }
      }
    }

    _createSiteMap(context);
    _createRobotsTxt(context);
  }

  void _createSiteMap(StaticShockPipelineContext context) {
    const destinationPath = FileRelativePath('', 'sitemap', 'txt');
    final canonicalLinks = links.map((e) {
      if (e.endsWith('index.html')) {
        throw FormatException(
          'Links on sitemap should not end with index.html: $e',
        );
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

String? _canonicalUri(String baseUrl, Page page) {
  final content = page.destinationContent.orEmpty;
  final document = html_parser.parse(content);
  final element = document.querySelector('link[rel="canonical"]');
  final link = element?.attributes['href'];

  if (link == null) {
    return null;
  }

  final uri = Uri.parse(link);
  return baseUrlResolvePath(baseUrl, uri.path, dropIndexHtml: true);
}
