/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Ardbeg_Uigeadail.png
  AssetGenImage get ardbegUigeadail =>
      const AssetGenImage('assets/images/Ardbeg_Uigeadail.png');

  /// File path: assets/images/Lagavulin_16.png
  AssetGenImage get lagavulin16 =>
      const AssetGenImage('assets/images/Lagavulin_16.png');

  /// File path: assets/images/Macallan_Sherry_Oak_25.png
  AssetGenImage get macallanSherryOak25 =>
      const AssetGenImage('assets/images/Macallan_Sherry_Oak_25.png');

  /// File path: assets/images/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/background.png');

  /// File path: assets/images/genuin_icon.png
  AssetGenImage get genuinIcon =>
      const AssetGenImage('assets/images/genuin_icon.png');

  /// File path: assets/images/glenfiddich_18.png
  AssetGenImage get glenfiddich18 =>
      const AssetGenImage('assets/images/glenfiddich_18.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/palm.png
  AssetGenImage get palm => const AssetGenImage('assets/images/palm.png');

  /// File path: assets/images/wine_bottle.png
  AssetGenImage get wineBottle =>
      const AssetGenImage('assets/images/wine_bottle.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    ardbegUigeadail,
    lagavulin16,
    macallanSherryOak25,
    background,
    genuinIcon,
    glenfiddich18,
    logo,
    palm,
    wineBottle,
  ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/application_logo.svg
  SvgGenImage get applicationLogo =>
      const SvgGenImage('assets/svg/application_logo.svg');

  /// File path: assets/svg/camera.svg
  SvgGenImage get camera => const SvgGenImage('assets/svg/camera.svg');

  /// File path: assets/svg/delete.svg
  SvgGenImage get delete => const SvgGenImage('assets/svg/delete.svg');

  /// File path: assets/svg/doc.svg
  SvgGenImage get doc => const SvgGenImage('assets/svg/doc.svg');

  /// File path: assets/svg/files.svg
  SvgGenImage get files => const SvgGenImage('assets/svg/files.svg');

  /// File path: assets/svg/gallery.svg
  SvgGenImage get gallery => const SvgGenImage('assets/svg/gallery.svg');

  /// File path: assets/svg/general_instructions.svg
  SvgGenImage get generalInstructions =>
      const SvgGenImage('assets/svg/general_instructions.svg');

  /// File path: assets/svg/history.svg
  SvgGenImage get history => const SvgGenImage('assets/svg/history.svg');

  /// File path: assets/svg/image.svg
  SvgGenImage get image => const SvgGenImage('assets/svg/image.svg');

  /// File path: assets/svg/microfone.svg
  SvgGenImage get microfone => const SvgGenImage('assets/svg/microfone.svg');

  /// File path: assets/svg/momra_image.svg
  SvgGenImage get momraImage => const SvgGenImage('assets/svg/momra_image.svg');

  /// File path: assets/svg/palm.svg
  SvgGenImage get palm => const SvgGenImage('assets/svg/palm.svg');

  /// File path: assets/svg/send.svg
  SvgGenImage get send => const SvgGenImage('assets/svg/send.svg');

  /// File path: assets/svg/special_instructions.svg
  SvgGenImage get specialInstructions =>
      const SvgGenImage('assets/svg/special_instructions.svg');

  /// File path: assets/svg/spinner.svg
  SvgGenImage get spinner => const SvgGenImage('assets/svg/spinner.svg');

  /// File path: assets/svg/stop.svg
  SvgGenImage get stop => const SvgGenImage('assets/svg/stop.svg');

  /// File path: assets/svg/text.svg
  SvgGenImage get text => const SvgGenImage('assets/svg/text.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    applicationLogo,
    camera,
    delete,
    doc,
    files,
    gallery,
    generalInstructions,
    history,
    image,
    microfone,
    momraImage,
    palm,
    send,
    specialInstructions,
    spinner,
    stop,
    text,
  ];
}

class $AssetsWhisperGen {
  const $AssetsWhisperGen();

  /// File path: assets/whisper/ggml-tiny.bin
  String get ggmlTiny => 'assets/whisper/ggml-tiny.bin';

  /// File path: assets/whisper/readme.md
  String get readme => 'assets/whisper/readme.md';

  /// List of all assets
  List<String> get values => [ggmlTiny, readme];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
  static const $AssetsWhisperGen whisper = $AssetsWhisperGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
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
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
