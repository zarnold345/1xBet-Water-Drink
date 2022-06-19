/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/buyPremium.svg
  SvgGenImage get buyPremium =>
      const SvgGenImage('assets/images/buyPremium.svg');

  /// File path: assets/images/cup.svg
  SvgGenImage get cup => const SvgGenImage('assets/images/cup.svg');

  /// File path: assets/images/female.png
  AssetGenImage get female => const AssetGenImage('assets/images/female.png');

  /// File path: assets/images/logomenu.svg
  SvgGenImage get logomenu => const SvgGenImage('assets/images/logomenu.svg');

  /// File path: assets/images/male.png
  AssetGenImage get male => const AssetGenImage('assets/images/male.png');

  /// File path: assets/images/onboarding.png
  AssetGenImage get onboarding =>
      const AssetGenImage('assets/images/onboarding.png');

  /// File path: assets/images/onboardinglogo.png
  AssetGenImage get onboardinglogo =>
      const AssetGenImage('assets/images/onboardinglogo.png');

  /// File path: assets/images/privacyPolicy.svg
  SvgGenImage get privacyPolicy =>
      const SvgGenImage('assets/images/privacyPolicy.svg');

  /// File path: assets/images/rateApp.svg
  SvgGenImage get rateApp => const SvgGenImage('assets/images/rateApp.svg');

  /// File path: assets/images/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/images/settings.svg');

  /// File path: assets/images/support.svg
  SvgGenImage get support => const SvgGenImage('assets/images/support.svg');

  /// File path: assets/images/termsOfUse.svg
  SvgGenImage get termsOfUse =>
      const SvgGenImage('assets/images/termsOfUse.svg');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;
}
