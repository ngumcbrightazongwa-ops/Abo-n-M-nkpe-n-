import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveAssetImage extends StatelessWidget {
  static Future<Map<String, String>>? _manifestKeysFuture;

  final String basePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;

  const AdaptiveAssetImage({
    super.key,
    required this.basePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholder,
  });

  static Future<Map<String, String>> _loadManifestKeys() async {
    final jsonStr = await rootBundle.loadString('AssetManifest.json');
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    return {
      for (final key in map.keys) key.toLowerCase(): key,
    };
  }

  static bool _hasKnownExtension(String path) {
    final p = path.toLowerCase();
    return p.endsWith('.svg') || p.endsWith('.png') || p.endsWith('.jpg') || p.endsWith('.jpeg') || p.endsWith('.webp') || p.endsWith('.gif');
  }

  static Future<String> _resolvePath(String basePath) async {
    _manifestKeysFuture ??= _loadManifestKeys();
    final keys = await _manifestKeysFuture!;

    if (_hasKnownExtension(basePath)) {
      return keys[basePath.toLowerCase()] ?? basePath;
    }

    const exts = ['svg', 'png', 'jpg', 'jpeg', 'webp', 'gif'];
    for (final ext in exts) {
      final candidate = '$basePath.$ext';
      final resolved = keys[candidate.toLowerCase()];
      if (resolved != null) return resolved;
    }
    return basePath;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _resolvePath(basePath),
      builder: (context, snapshot) {
        final path = snapshot.data ?? basePath;
        final isSvg = path.toLowerCase().endsWith('.svg');

        if (isSvg) {
          return SvgPicture.asset(
            path,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: (context) => placeholder ?? _defaultPlaceholder(),
          );
        }

        return Image.asset(
          path,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => placeholder ?? _defaultPlaceholder(),
        );
      },
    );
  }

  Widget _defaultPlaceholder() {
    final h = height ?? 48;
    final w = width ?? h;
    return SizedBox(
      width: w,
      height: h,
      child: const Center(child: Icon(Icons.image_outlined)),
    );
  }
}
