import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveAssetImage extends StatelessWidget {
<<<<<<< HEAD
  static Future<Set<String>>? _manifestKeysFuture;
  static final Map<String, Future<String>> _resolvedPathCache = {};
=======
  static Future<Map<String, String>>? _manifestKeysFuture;
>>>>>>> a479fdf658ffc34393a15ad33cc12cbaf243d0e4

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

<<<<<<< HEAD
  static Future<Set<String>> _loadManifestKeys() async {
    try {
      final jsonStr = await rootBundle.loadString('AssetManifest.bin.json');
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      return map.keys.toSet();
    } catch (_) {
      try {
        final jsonStr = await rootBundle.loadString('AssetManifest.json');
        final map = json.decode(jsonStr) as Map<String, dynamic>;
        return map.keys.toSet();
      } catch (_) {
        return <String>{};
      }
    }
=======
  static Future<Map<String, String>> _loadManifestKeys() async {
    final jsonStr = await rootBundle.loadString('AssetManifest.json');
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    return {
      for (final key in map.keys) key.toLowerCase(): key,
    };
>>>>>>> a479fdf658ffc34393a15ad33cc12cbaf243d0e4
  }

  static bool _hasKnownExtension(String path) {
    final p = path.toLowerCase();
    return p.endsWith('.svg') ||
        p.endsWith('.png') ||
        p.endsWith('.jpg') ||
        p.endsWith('.jpeg') ||
        p.endsWith('.webp') ||
        p.endsWith('.gif');
  }

  static String _sanitizeSvg(String svg) {
    var s = svg;
    s = s.replaceFirst(RegExp(r'<!DOCTYPE[^>]*>'), '');
    s = s.replaceAll(RegExp(r'\swidth="[^"]*%"'), '');
    s = s.replaceAll(RegExp(r"\swidth='[^']*%'"), '');
    s = s.replaceAll(RegExp(r'\sheight="[^"]*%"'), '');
    s = s.replaceAll(RegExp(r"\sheight='[^']*%'"), '');
    s = s.replaceAllMapped(
      RegExp(r'(-?\d+(?:\.\d+)?)px'),
      (m) => m.group(1) ?? '',
    );
    return s;
  }

  static Future<String> _resolvePath(String basePath) async {
<<<<<<< HEAD
    if (_hasKnownExtension(basePath)) return basePath;
    return _resolvedPathCache.putIfAbsent(basePath, () async {
      _manifestKeysFuture ??= _loadManifestKeys();
      final keys = await _manifestKeysFuture!;

      const exts = ['png', 'jpg', 'jpeg', 'webp', 'gif', 'svg'];

      if (keys.isNotEmpty) {
        for (final ext in exts) {
          final candidate = '$basePath.$ext';
          if (keys.contains(candidate)) return candidate;
        }
      }

      for (final ext in exts) {
        final candidate = '$basePath.$ext';
        try {
          await rootBundle.load(candidate);
          return candidate;
        } catch (_) {}
      }

      return basePath;
    });
=======
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
>>>>>>> a479fdf658ffc34393a15ad33cc12cbaf243d0e4
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _resolvePath(basePath),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return placeholder ?? _defaultPlaceholder();

        final path = snapshot.data!;
        final isSvg = path.toLowerCase().endsWith('.svg');

        if (isSvg) {
          return FutureBuilder<String>(
            future: rootBundle.loadString(path).then(_sanitizeSvg),
            builder: (context, svgSnapshot) {
              if (!svgSnapshot.hasData) {
                return placeholder ?? _defaultPlaceholder();
              }

              return SvgPicture.string(
                svgSnapshot.data!,
                width: width,
                height: height,
                fit: fit,
                placeholderBuilder:
                    (context) => placeholder ?? _defaultPlaceholder(),
                errorBuilder:
                    (context, error, stackTrace) =>
                        placeholder ?? _defaultPlaceholder(),
              );
            },
          );
        }

        return Image.asset(
          path,
          width: width,
          height: height,
          fit: fit,
          errorBuilder:
              (context, error, stackTrace) =>
                  placeholder ?? _defaultPlaceholder(),
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
