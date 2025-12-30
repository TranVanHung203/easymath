import 'package:chiclet/chiclet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/common/widget/basic_appbar.dart';
import 'package:math/common/widget/slide_up_route.dart';
import 'package:math/core/services/voice_service.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:math/features/math/keo_tha/presentation/pages/keo_tha_page.dart';
import 'package:math/features/math/slider_game/presentation/pages/slider_game_page.dart';
import 'package:math/features/video/presentation/pages/video_page.dart';
import 'package:math/features/progress/view_models/progress_cubit.dart';

class ProgressPage extends StatefulWidget {
  final String? progressId;
  final String? type;
  final String? title;

  const ProgressPage({
    super.key,
    required this.progressId,
    this.type,
    this.title,
  });

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late final ProgressCubit _progressCubit;

  @override
  void initState() {
    super.initState();
    _progressCubit = context.read<ProgressCubit>();

    final id = widget.progressId;
    if (id != null && id.isNotEmpty) {
      _progressCubit.fetchProgress(progressId: id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: widget.title ?? 'Nội dung bài học',
        showBack: false,
      ),
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) {
          if (widget.progressId == null || widget.progressId!.isEmpty) {
            return const Center(child: Text('progressId bị null / rỗng'));
          }

          if (state is ProgressLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProgressError) {
            return Center(child: Text(state.message));
          }

          if (state is ProgressLoaded) {
            final progressContent = state.progress;
            final items = progressContent.content;

            if (items.isEmpty) {
              return const Center(child: Text('Chưa có nội dung'));
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: item.isCompleted == true
                              ? Colors.green
                              : Colors.grey,
                        ),

                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: item.title ?? ''),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: GestureDetector(
                                      onTap: () {
                                        VoiceService.instance.speak(
                                          item.title ?? '',
                                        );
                                      },
                                      child: Icon(
                                        Icons.volume_up,
                                        size: 20,
                                        color: AppColor.primary600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        IgnorePointer(
                          ignoring: item.isLocked == true,
                          child: Opacity(
                            opacity: item.isLocked == true ? 0.6 : 1.0,
                            child: Tooltip(
                              message: item.isLocked == true
                                  ? 'Bài học đang bị khóa'
                                  : '',
                              child: ChicletOutlinedAnimatedButton(
                                onPressed: () async {
                                  if (item.isLocked == true) {
                                    // Safety: should be blocked by IgnorePointer, but keep check as fallback
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Bài học đang bị khóa'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (widget.type == 'video') {
                                    final result = await Navigator.of(context)
                                        .push(
                                          SlideUpRoute(
                                            page: VideoPage(
                                              progressId: item.progressId ?? "",
                                              videoId: item.id ?? '',

                                              url: item.url ?? '',
                                            ),
                                          ),
                                        );
                                    if (result != null) {
                                      _progressCubit.markItemCompleted(
                                        contentId: result['contentId'],
                                      );
                                      print('VideoPage returned: $result');
                                    }
                                  } else if (widget.type == 'quiz') {
                                    final result = await Navigator.of(context).push(
                                      SlideUpRoute(
                                        // Có cái khung 15 câu hiện tại thì để như này
                                        page: KeoThaPage(),
                                      ),
                                    );
                                    if (result != null) {
                                      // _progressCubit.markItemCompleted(
                                      //   contentId: result['contentId'],
                                      // );
                                      // print('VideoPage returned: $result');
                                    }
                                  }
                                },
                                height: 40,
                                buttonHeight: 2,
                                borderWidth: 2,
                                borderRadius: 16,
                                child: Icon(
                                  color: AppColor.primary400,
                                  getContentTypeIcon(
                                    contentType: item.type ?? widget.type,
                                    isLocked: item.isLocked,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  IconData getContentTypeIcon({required String? contentType, bool? isLocked}) {
    if (isLocked == true) return Icons.lock;

    switch (contentType?.toLowerCase()) {
      case 'video':
        return Icons.play_arrow;
      case 'exercise':
        return Icons.assignment;
      case 'quiz':
        return Icons.arrow_forward_ios;
      default:
        return Icons.play_circle;
    }
  }
}
