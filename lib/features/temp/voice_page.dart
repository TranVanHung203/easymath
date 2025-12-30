import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceHelper {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> init({
    String language = 'vi-VN',
    double rate = 0.5,
    double pitch = 1.0,
    double volume = 1.0,
  }) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.setVolume(volume);
  }

  Future<void> speak(String text) async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }

  Future<void> stop() => flutterTts.stop();

  Future<void> setLanguage(String lang) => flutterTts.setLanguage(lang);
  Future<void> setSpeechRate(double r) => flutterTts.setSpeechRate(r);
  Future<void> setPitch(double p) => flutterTts.setPitch(p);
  Future<void> setVolume(double v) => flutterTts.setVolume(v);

  void dispose() => flutterTts.stop();
}

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final VoiceHelper _voice = VoiceHelper();
  final TextEditingController _textController = TextEditingController(
    text: 'Xin chào, đây là bài học phép cộng',
  );

  double _volume = 1.0;
  double _rate = 0.5;
  double _pitch = 1.0;
  String _language = 'vi-VN';
  List<String> _languages = [];
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      await _voice.init(
        language: _language,
        rate: _rate,
        pitch: _pitch,
        volume: _volume,
      );
      final langs = await _voice.flutterTts.getLanguages;
      if (langs != null) {
        setState(() {
          _languages = List<String>.from(langs);
          if (!_languages.contains(_language) && _languages.isNotEmpty) {
            _language = _languages.first;
            _voice.setLanguage(_language);
          }
        });
      }

      _voice.flutterTts.setStartHandler(() {
        setState(() => _isSpeaking = true);
      });

      _voice.flutterTts.setCompletionHandler(() {
        setState(() => _isSpeaking = false);
      });

      _voice.flutterTts.setErrorHandler((msg) {
        setState(() => _isSpeaking = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('TTS error: $msg')));
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('TTS init failed: $e')));
    }
  }

  @override
  void dispose() {
    _voice.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _speak() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    await _voice.setLanguage(_language);
    await _voice.setSpeechRate(_rate);
    await _voice.setPitch(_pitch);
    await _voice.setVolume(_volume);
    await _voice.speak(text);
  }

  Future<void> _stop() => _voice.stop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice / TTS')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Văn bản để đọc:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              minLines: 2,
              maxLines: 5,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _speak,
                  icon: const Icon(Icons.volume_up),
                  label: const Text('🔊 Nghe hướng dẫn'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _stop,
                  icon: const Icon(Icons.stop),
                  label: const Text('Dừng'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Ngôn ngữ: ${_language}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (_languages.isNotEmpty)
              DropdownButton<String>(
                value: _language,
                items: _languages
                    .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                    .toList(),
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _language = v);
                  _voice.setLanguage(v);
                },
              ),
            const SizedBox(height: 8),
            _buildSlider(
              'Âm lượng',
              _volume,
              (v) => setState(() => _volume = v),
              min: 0.0,
              max: 1.0,
            ),
            _buildSlider(
              'Tốc độ',
              _rate,
              (v) => setState(() => _rate = v),
              min: 0.0,
              max: 1.0,
            ),
            _buildSlider(
              'Cao độ',
              _pitch,
              (v) => setState(() => _pitch = v),
              min: 0.5,
              max: 2.0,
            ),
            const SizedBox(height: 8),
            Text('Trạng thái: ${_isSpeaking ? 'Đang nói' : 'Rảnh'}'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _textController.text = 'Con hãy đếm số khối bên trái';
                  },
                  child: const Text('Đếm khối'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _textController.text = 'Bắt đầu làm bài tập 1 nhé';
                  },
                  child: const Text('Bắt đầu bài'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(
    String title,
    double value,
    ValueChanged<double> onChanged, {
    double min = 0.0,
    double max = 1.0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title: ${value.toStringAsFixed(2)}'),
        Slider(value: value, onChanged: onChanged, min: min, max: max),
      ],
    );
  }
}
