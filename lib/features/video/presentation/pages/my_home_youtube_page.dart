import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chiclet/chiclet.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:math/features/activities/view_models/is_check_cubit.dart';
import 'package:math/features/home/view_models/roadmap_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomeYoutubePage extends StatefulWidget {
  final String videoUrlOrId;
  final String progressId;
  final String videoId;
  const MyHomeYoutubePage({
    super.key,
    required this.videoUrlOrId,
    required this.progressId,
    required this.videoId,
  });

  @override
  State<MyHomeYoutubePage> createState() => _MyHomeYoutubePageState();
}

class _MyHomeYoutubePageState extends State<MyHomeYoutubePage> {
  late YoutubePlayerController _controller;
  late final IsCheckCubit _isCheckCubit;
  late final RoadmapCubit _roadmapCubit;
  bool _isPlayerReady = false;

  // ✅ cờ để tránh gọi lặp nhiều lần khi còn <=5s
  bool _firedNearEnd = false;
  OverlayEntry? _nextOverlayEntry;

  String _extractVideoId(String input) {
    final idFromUrl = YoutubePlayer.convertUrlToId(input);
    final id = (idFromUrl ?? input).trim();
    return id.isEmpty ? 'ByjIl7IVZFo' : id;
  }

  @override
  void initState() {
    super.initState();
    _isCheckCubit = context.read<IsCheckCubit>();
    _roadmapCubit = context.read<RoadmapCubit>();

    final videoId = _extractVideoId(widget.videoUrlOrId);

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );

    // ✅ Lắng nghe thay đổi của player
    _controller.addListener(_nearEndListener);
  }

  void _nearEndListener() {
    if (!_isPlayerReady) return;

    final value = _controller.value;

    // có lúc duration chưa có ngay
    final duration = value.metaData.duration;
    if (duration == Duration.zero) return;

    final position = value.position;

    // tránh số âm khi position > duration (thỉnh thoảng xảy ra)
    final remaining = Duration(
      seconds: max(0, duration.inSeconds - position.inSeconds),
    );

    if (!_firedNearEnd && remaining <= const Duration(seconds: 5)) {
      _firedNearEnd = true;

      // 👉 Làm cái gì đó ở đây
      // _showSnackBar('Còn 5 giây nữa là hết video!');
      _showNextOverlay();
      // ví dụ: preload câu tiếp theo, hiện nút "Tiếp", ghi log, v.v.
    }

    // nếu user tua ngược ra xa hơn 5s thì cho phép bắn lại
    if (_firedNearEnd && remaining > const Duration(seconds: 5)) {
      _firedNearEnd = false;
      _removeNextOverlay();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_nearEndListener);
    _removeNextOverlay();
    _controller.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, textAlign: TextAlign.center)),
    );
  }

  void _showNextOverlay() {
    if (!mounted) return;
    if (_nextOverlayEntry != null) return;

    _nextOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: ChicletOutlinedAnimatedButton(
              onPressed: () {
                if (!mounted) return;
                _controller.pause();
                _isCheckCubit.checkProgress(
                  progressId: widget.progressId,
                  videoId: widget.videoId,
                );
              },
              height: 60,
              width: 100,
              child: const Icon(
                Iconsax.next,
                color: AppColor.primary400,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_nextOverlayEntry!);
  }

  void _removeNextOverlay() {
    _nextOverlayEntry?.remove();
    _nextOverlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IsCheckCubit, int>(
      listener: (context, state) {
        print('IsCheckCubit state changed: $state');
        if (state == 1) {
          _showSnackBar('Đã từng xem!');
          Navigator.pop(context);
        } else if (state == 3) {
          _roadmapCubit.getRoadmaps(chapterId: "693f88c93320266f98d13f32");
          _showSnackBar('Cần load lại map!');
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state == 2) {
          _showSnackBar('Chưa xem lần nào!');
          Navigator.pop(context, {
            'contentId': widget.videoId,
            'isCompleted': true,
          });
        }
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          bottomActions: const [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            RemainingDuration(),
            // KHÔNG thêm PlaybackSpeedButton()
          ],
          onReady: () => setState(() => _isPlayerReady = true),
          // onEnded: (_) => _showSnackBar('Video Ended!'),
        ),
        builder: (context, player) => Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                ListView(children: [player]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
