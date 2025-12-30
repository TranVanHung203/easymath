import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/core/di/injection.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:math/features/activities/view_models/is_check_cubit.dart';
import 'package:math/features/video/presentation/pages/my_home_youtube_page.dart';
import 'package:math/features/video/presentation/widgets/video_appbar.dart';

class VideoPage extends StatefulWidget {
  final String? title;
  final String progressId;
  final String videoId;
  final String url;
  const VideoPage({
    super.key,
    this.title,
    required this.url,
    required this.progressId,
    required this.videoId,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VideoAppbar(onMenu: () {}),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.hurricane100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BlocProvider(
                  create: (context) => sl<IsCheckCubit>(),
                  child: MyHomeYoutubePage(
                    videoUrlOrId: widget.url,
                    progressId: widget.progressId,
                    videoId: widget.videoId,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
