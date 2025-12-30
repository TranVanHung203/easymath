import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  /// Singleton
  VoiceService._internal();
  static final VoiceService instance = VoiceService._internal();

  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;

  /// Khởi tạo TTS (chỉ chạy 1 lần)
  Future<void> init({
    String language = 'vi-VN',
    double rate = 0.5,
    double pitch = 1.0,
    double volume = 3.0,
  }) async {
    if (_isInitialized) return;

    await _tts.setLanguage(language);
    await _tts.setSpeechRate(rate);
    await _tts.setPitch(pitch);
    await _tts.setVolume(volume);
    await _tts.awaitSpeakCompletion(true);

    _isInitialized = true;
  }

  /// NÓI – chỉ cần truyền text
  Future<void> speak(
    String text, {
    String? language,
    double? rate,
    double? pitch,
    double? volume,
  }) async {
    if (!_isInitialized) {
      await init();
    }

    if (language != null) await _tts.setLanguage(language);
    if (rate != null) await _tts.setSpeechRate(rate);
    if (pitch != null) await _tts.setPitch(pitch);
    if (volume != null) await _tts.setVolume(volume);

    await _tts.stop();
    await _tts.speak(text);
  }

  /// Dừng nói
  Future<void> stop() async {
    await _tts.stop();
  }

  /// Lấy danh sách ngôn ngữ
  Future<List<String>> getLanguages() async {
    final langs = await _tts.getLanguages;
    return langs != null ? List<String>.from(langs) : [];
  }

  /// Huỷ
  void dispose() {
    _tts.stop();
  }
}
