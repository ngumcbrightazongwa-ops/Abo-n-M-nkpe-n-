class AudioRecorderService {
  bool _isRecording = false;

  Future<bool> get isRecording async => _isRecording;

  Future<bool> hasPermission() async => true;

  Future<void> start() async {
    _isRecording = true;
  }

  Future<String?> stop() async {
    _isRecording = false;
    return null;
  }

  Future<void> dispose() async {
    _isRecording = false;
  }
}
