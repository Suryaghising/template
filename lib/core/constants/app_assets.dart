import 'constant_asset_paths.dart';

class _AssetsImagesGen {
  const _AssetsImagesGen();

  String get logo => '$kImagesPath/logo.png';
}

class _AssetsSvgImagesGen {
  const _AssetsSvgImagesGen();

  String get home => '$kSvgImagesPath/home.svg';

  String get mail => '$kSvgImagesPath/mail.svg';

  String get stories => '$kSvgImagesPath/stories.svg';

  String get more => '$kSvgImagesPath/hamburger.svg';
}

class Assets {
  Assets._();

  static const images = _AssetsImagesGen();
  static const svgImages = _AssetsSvgImagesGen();
}
