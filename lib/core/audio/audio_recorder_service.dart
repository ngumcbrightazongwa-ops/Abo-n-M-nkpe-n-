import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  final AudioRecorder _recorder = AudioRecorder();

  Future<bool> get isRecording async => _recorder.isRecording();

  Future<bool> hasPermission() async {
    if (kIsWeb) return true;
    return _recorder.hasPermission();
  }

  Future<void> start() async {
    if (kIsWeb) return;
    final ok = await hasPermission();
    if (!ok) return;
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/nkwen_recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: path);
  }

  Future<String?> stop() async {
    if (kIsWeb) return null;
    return _recorder.stop();
  }

  Future<void> dispose() async {
    await _recorder.dispose();
  }
}
