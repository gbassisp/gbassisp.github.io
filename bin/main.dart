import 'dart:io';

import 'package:static_shock/static_shock.dart';

import 'correct_redirect_plugin.dart';
import 'required_metadata_plugin.dart';
import 'sitemap_plugin.dart';

Future<void> main(List<String> arguments) async {
  const baseUrl = 'https://el-darto.net/';
  const site = RssSiteConfiguration(
    homePageUrl: baseUrl,
    title: 'El Darto',
    description: 'Ay caramba!',
    language: 'en',
  );
  // Configure the static website generator.
  final staticShock = StaticShock()
    // Here, you can directly hook into the StaticShock pipeline. For example,
    // you can copy an "images" directory from the source set to build set:
    ..pick(DirectoryPicker.parse('assets'))
    ..pick(DirectoryPicker.parse('images'))
    // All 3rd party behavior is added through plugins, even the behavior
    // shipped with Static Shock.
    ..plugin(const MarkdownPlugin())
    ..plugin(const JinjaPlugin())
    ..plugin(const PrettyUrlsPlugin())
    ..plugin(const CorrectRedirectsPlugin(baseUrl: baseUrl))
    ..plugin(const SassPlugin())
    ..plugin(
      GitHubContributorsPlugin(
        // To load the contributors for a given GitHub package using
        // credentials, place your GitHub API token in an environment variable
        // with the following name.
        authToken: Platform.environment['github_doc_website_token'],
      ),
    )
    ..plugin(
      DraftingPlugin(
        showDrafts: arguments.contains('preview'),
      ),
    )
    ..plugin(const RequiredMetadataPlugin())
    ..plugin(const SitemapPlugin(baseUrl: baseUrl))
    ..plugin(
      RssPlugin(
        // blog feed
        rssFeedPath: const FileRelativePath('', 'blog_feed', 'xml'),
        pageToRssItemMapper: (config, page) {
          if (page.destinationPath?.value.startsWith('blog') ?? false) {
            return defaultPageToRssItemMapper(config, page);
          }
          return null;
        },
        site: site,
      ),
    )
    ..plugin(
      RssPlugin(
        // packages feed
        rssFeedPath: const FileRelativePath('', 'package_feed', 'xml'),
        pageToRssItemMapper: (config, page) {
          if (page.destinationPath?.value.startsWith('packages') ?? false) {
            return defaultPageToRssItemMapper(config, page);
          }
          return null;
        },
        site: site,
      ),
    )
    ..plugin(
      const RssPlugin(
        // all posts feed
        site: site,
      ),
    );

  // Generate the static website.
  await staticShock.generateSite();
}
