import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveAssetImage extends StatelessWidget {
  static Future<Set<String>>? _manifestKeysFuture;
  static final Map<String, Future<String>> _resolvedPathCache = {};

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
    s = s.replaceFirst(RegExp(r'<\?xml[^>]*\?>'), '');
    s = s.replaceFirst(RegExp(r'<!DOCTYPE[^>]*>'), '');
    s = s.replaceAll(RegExp(r'\swidth="[^"]*%"'), '');
    s = s.replaceAll(RegExp(r"\swidth='[^']*%'"), '');
    s = s.replaceAll(RegExp(r'\sheight="[^"]*%"'), '');
    s = s.replaceAll(RegExp(r"\sheight='[^']*%'"), '');
    s = s.replaceAll(
      RegExp(r'<text\b[\s\S]*?<\/text>', dotAll: true, caseSensitive: false),
      '',
    );
    s = s.replaceAllMapped(
      RegExp(r'(-?\d+(?:\.\d+)?)px'),
      (m) => m.group(1) ?? '',
    );
    return s;
  }

  static Future<String> _resolvePath(String basePath) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _resolvePath(basePath),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return placeholder ?? _defaultPlaceholder();

        final path = snapshot.data!;
        final isSvg = path.toLowerCase().endsWith('.svg');
        final effectiveWidth = width ?? height;
        final effectiveHeight = height ?? width;

        if (isSvg) {
          return FutureBuilder<String>(
            future: rootBundle.loadString(path).then(_sanitizeSvg),
            builder: (context, svgSnapshot) {
              if (!svgSnapshot.hasData) {
                return placeholder ?? _defaultPlaceholder();
              }

              return SvgPicture.string(
                svgSnapshot.data!,
                width: effectiveWidth,
                height: effectiveHeight,
                fit: fit,
                placeholderBuilder:
                    (context) => placeholder ?? _defaultPlaceholder(),
                errorBuilder: (context, error, stackTrace) {
                  assert(() {
                    FlutterError.reportError(
                      FlutterErrorDetails(
                        exception: error,
                        stack: stackTrace,
                        library: 'AdaptiveAssetImage',
                        context: ErrorDescription('while decoding $path'),
                      ),
                    );
                    return true;
                  }());
                  return placeholder ?? _defaultPlaceholder();
                },
              );
            },
          );
        }

        return Image.asset(
          path,
          width: effectiveWidth,
          height: effectiveHeight,
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
