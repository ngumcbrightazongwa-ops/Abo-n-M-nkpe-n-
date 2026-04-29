import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/audio_waveform.dart';
import '../widgets/adaptive_asset_image.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_primary_button.dart';

class AhaMomentScreen extends StatefulWidget {
  const AhaMomentScreen({super.key});

  @override
  State<AhaMomentScreen> createState() => _AhaMomentScreenState();
}

class _AhaMomentScreenState extends State<AhaMomentScreen>
    with SingleTickerProviderStateMixin {
  late final AudioPlayer _player;
  late final AnimationController _waveController;
  late final StreamSubscription<PlayerState> _playerSub;
  String? _samplePath;
  bool _loadingSample = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _playerSub = _player.playerStateStream.listen(_onPlayerState);
    _prepareSample();
  }

  @override
  void dispose() {
    _playerSub.cancel();
    _waveController.dispose();
    _player.dispose();
    super.dispose();
  }

  void _onPlayerState(PlayerState state) {
    final playing =
        state.playing && state.processingState != ProcessingState.completed;

    if (playing != _isPlaying) {
      setState(() => _isPlaying = playing);
    }

    if (playing) {
      if (!_waveController.isAnimating) {
        _waveController.repeat();
      }
      return;
    }

    if (_waveController.isAnimating) {
      _waveController.stop();
    }
    if (_waveController.value != 0) {
      _waveController.value = 0;
    }
  }

  Future<void> _prepareSample() async {
    if (_loadingSample) return;
    setState(() => _loadingSample = true);
    try {
      final file = File(
        '${Directory.systemTemp.path}${Platform.pathSeparator}nkwen_sample_${DateTime.now().millisecondsSinceEpoch}.wav',
      );
      await file.writeAsBytes(_buildWavSineWave());
      _samplePath = file.path;
      await _player.setFilePath(file.path);
    } catch (_) {
      _samplePath = null;
    } finally {
      if (mounted) setState(() => _loadingSample = false);
    }
  }

  Future<void> _playSample(BuildContext context) async {
    if (_loadingSample) return;
    try {
      if (_player.playing) {
        await _player.pause();
        return;
      }

      if (_samplePath == null) {
        await _prepareSample();
      }
      if (_samplePath == null) {
        throw StateError('Sample path not available');
      }
      await _player.seek(Duration.zero);
      await _player.play();
    } catch (_) {
      if (!context.mounted) return;
      context.showSnack('Audio not available yet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          const OnboardingBackground(child: SizedBox.expand()),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.surface,
                    AppColors.surface,
                    Color(0x00FFFFFF),
                  ],
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.pagePadding),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Material(
                        color: AppColors.surface,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            final router = GoRouter.of(context);
                            if (router.canPop()) {
                              router.pop();
                              return;
                            }
                            context.go('/onboarding/problem');
                          },
                          child: const SizedBox(
                            width: 44,
                            height: 44,
                            child: Icon(Icons.chevron_left),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const _StepIndicator(count: 5, index: 3),
                      const Spacer(),
                      const SizedBox(width: 44, height: 44),
                    ],
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: (constraints.maxHeight * 0.34).clamp(
                                  160.0,
                                  250.0,
                                ),
                                child: ClipRect(
                                  child: Transform.translate(
                                    offset: const Offset(0, -26),
                                    child: const AdaptiveAssetImage(
                                      basePath:
                                          'assets/characters/child_thinking',
                                      fit: BoxFit.contain,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              const _AhaTitle(),
                              const SizedBox(height: 10),
                              Text(
                                'Don’t worry. Let’s fix that together.',
                                style: AppTextStyles.bodyMuted.copyWith(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              AnimatedBuilder(
                                animation: _waveController,
                                builder: (context, _) {
                                  return _AudioCard(
                                    loading: _loadingSample,
                                    isPlaying: _isPlaying,
                                    animationValue: _waveController.value,
                                    onPressed: () => _playSample(context),
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
                              const Icon(
                                Icons.favorite_border,
                                color: AppColors.primaryGreen,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Even if you missed it,\nwe’ll teach you step by step.',
                                style: AppTextStyles.bodyMuted.copyWith(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  OnboardingPrimaryButton(
                    label: 'Continue',
                    onPressed: () => context.push('/onboarding/lesson'),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int count;
  final int index;

  const _StepIndicator({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i == index)
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: 24,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 26,
                  height: 6,
                  decoration: BoxDecoration(
                    color:
                        i < index ? AppColors.primaryGreen : AppColors.border,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          if (i != count - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _AhaTitle extends StatelessWidget {
  const _AhaTitle();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Text(
          'Did you understand that?',
          textAlign: TextAlign.center,
          style: AppTextStyles.headline.copyWith(
            fontSize: 34,
            height: 1.06,
            color: AppColors.primaryGreen,
          ),
        ),
        const Positioned(
          left: -30,
          child: _TitleMarks(
            colors: [Color(0xFFF59E0B), Color(0xFFEF4444), Color(0xFF22C55E)],
            flip: true,
          ),
        ),
        const Positioned(
          right: -30,
          child: _TitleMarks(
            colors: [Color(0xFFF59E0B), Color(0xFFEF4444), Color(0xFF22C55E)],
          ),
        ),
      ],
    );
  }
}

class _TitleMarks extends StatelessWidget {
  final List<Color> colors;
  final bool flip;

  const _TitleMarks({required this.colors, this.flip = false});

  @override
  Widget build(BuildContext context) {
    final child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TitleMark(color: colors[0], rotation: -0.6),
        const SizedBox(height: 8),
        _TitleMark(color: colors[1], rotation: -0.1),
        const SizedBox(height: 8),
        _TitleMark(color: colors[2], rotation: 0.4),
      ],
    );

    if (!flip) return child;
    return Transform.flip(flipX: true, child: child);
  }
}

class _TitleMark extends StatelessWidget {
  final Color color;
  final double rotation;

  const _TitleMark({required this.color, required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 20,
        height: 5,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

class _AudioCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool loading;
  final bool isPlaying;
  final double animationValue;

  const _AudioCard({
    required this.onPressed,
    required this.loading,
    required this.isPlaying,
    required this.animationValue,
  });

  List<double> _animatedBars(List<double> base) {
    final phase = animationValue * 2 * math.pi;
    return List.generate(base.length, (i) {
      final wobble = (math.sin(phase + (i * 0.55)) + 1) / 2;
      final scale = 0.55 + (0.75 * wobble);
      return (base[i] * scale).clamp(0.12, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    const bars = [
      0.25,
      0.5,
      0.35,
      0.7,
      0.45,
      0.3,
      0.55,
      0.25,
      0.6,
      0.4,
      0.75,
      0.5,
      0.25,
      0.45,
      0.65,
      0.35,
      0.55,
      0.25,
      0.6,
      0.4,
      0.7,
      0.3,
      0.55,
      0.25,
    ];
    final beeping = isPlaying && !loading;
    final pulse = (math.sin(animationValue * 2 * math.pi) + 1) / 2;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 42,
                height: 42,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryGreen.withAlpha(18),
                      ),
                    ),
                    if (beeping)
                      Transform.scale(
                        scale: 1.0 + (0.22 * pulse),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryGreen.withAlpha(90),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    Transform.scale(
                      scale: beeping ? (1.0 + (0.08 * pulse)) : 1.0,
                      child: Icon(
                        Icons.volume_up,
                        color: AppColors.primaryGreen.withAlpha(
                          beeping ? (170 + (85 * pulse).round()) : 255,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Listen to this phrase', style: AppTextStyles.title),
                    const SizedBox(height: 2),
                    Text('Nkwen audio', style: AppTextStyles.bodyMuted),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isPlaying && !loading)
                      Transform.scale(
                        scale:
                            1.0 +
                            (0.25 *
                                ((math.sin(animationValue * 2 * math.pi) + 1) /
                                    2)),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryGreen.withAlpha(90),
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: Colors.white,
                        ),
                        child:
                            loading
                                ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                                : Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 26,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: AudioWaveform(
                  bars: isPlaying && !loading ? _animatedBars(bars) : bars,
                  color: AppColors.primaryGreen,
                  height: 26,
                  barWidth: 4,
                  gap: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Uint8List _buildWavSineWave({
  int sampleRate = 44100,
  int durationMs = 900,
  double frequencyHz = 440,
  double amplitude = 0.25,
}) {
  final numSamples = (sampleRate * durationMs / 1000).round();
  final pcm = Int16List(numSamples);
  final twoPi = 2 * math.pi;

  for (var i = 0; i < numSamples; i++) {
    final t = i / sampleRate;
    final v = math.sin(twoPi * frequencyHz * t) * amplitude;
    pcm[i] = (v * 32767).clamp(-32767, 32767).round();
  }

  final pcmBytes = Uint8List.view(pcm.buffer);
  final byteRate = sampleRate * 2;
  final dataLength = pcmBytes.lengthInBytes;
  final fileLength = 44 + dataLength;

  final bytes = BytesBuilder();
  bytes.add(_ascii('RIFF'));
  bytes.add(_le32(fileLength - 8));
  bytes.add(_ascii('WAVE'));
  bytes.add(_ascii('fmt '));
  bytes.add(_le32(16));
  bytes.add(_le16(1));
  bytes.add(_le16(1));
  bytes.add(_le32(sampleRate));
  bytes.add(_le32(byteRate));
  bytes.add(_le16(2));
  bytes.add(_le16(16));
  bytes.add(_ascii('data'));
  bytes.add(_le32(dataLength));
  bytes.add(pcmBytes);
  return bytes.toBytes();
}

Uint8List _ascii(String s) => Uint8List.fromList(s.codeUnits);
Uint8List _le16(int v) => Uint8List.fromList([v & 0xFF, (v >> 8) & 0xFF]);
Uint8List _le32(int v) => Uint8List.fromList([
  v & 0xFF,
  (v >> 8) & 0xFF,
  (v >> 16) & 0xFF,
  (v >> 24) & 0xFF,
]);
