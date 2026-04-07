import 'package:static_shock/static_shock.dart';

class RequiredMetadataPlugin implements StaticShockPlugin {
  const RequiredMetadataPlugin();

  @override
  String get id => 'required-metadata';

  @override
  void configure(
    StaticShockPipeline pipeline,
    StaticShockPipelineContext context,
    StaticShockCache cache,
  ) {
    pipeline.transformPages(const _RequiredMetadataTransformer());
  }
}

class _RequiredMetadataTransformer implements PageTransformer {
  const _RequiredMetadataTransformer();

  static const _requiredMetadata = [
    'title',
    'publishDate',
  ];

  @override
  void transformPage(StaticShockPipelineContext context, Page page) {
    if (page.sourcePath.value.endsWith('.md')) {
      for (final metadata in _requiredMetadata) {
        if (page.data[metadata] == null) {
          throw Exception(
            "Missing required metadata '$metadata' in: ${page.sourcePath}",
          );
        }
      }
    }
  }
}
