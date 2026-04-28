import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveAssetImage extends StatelessWidget {
  static Future<Set<String>>? _manifestKeysFuture;

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

  static Future<Set<String>> _loadManifestKeys() async {
    final jsonStr = await rootBundle.loadString('AssetManifest.json');
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    return map.keys.toSet();
  }

  static bool _hasKnownExtension(String path) {
    final p = path.toLowerCase();
    return p.endsWith('.svg') || p.endsWith('.png') || p.endsWith('.jpg') || p.endsWith('.jpeg') || p.endsWith('.webp') || p.endsWith('.gif');
  }

  static Future<String> _resolvePath(String basePath) async {
    if (_hasKnownExtension(basePath)) return basePath;

    _manifestKeysFuture ??= _loadManifestKeys();
    final keys = await _manifestKeysFuture!;

    const exts = ['svg', 'png', 'jpg', 'jpeg', 'webp', 'gif'];
    for (final ext in exts) {
      final candidate = '$basePath.$ext';
      if (keys.contains(candidate)) return candidate;
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

