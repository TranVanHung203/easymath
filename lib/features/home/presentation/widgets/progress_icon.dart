import 'package:chiclet/chiclet.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:math/common/widget/chiclet_popover_frame.dart'
    hide ChicletButtonTypes;
import 'package:math/core/responsive/responsive_widget.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:math/features/home/models/roadmap.dart';
import 'package:math/features/progress/presentation/pages/progress_page.dart';
import 'package:popover/popover.dart';

class ProgressIcon extends StatelessWidget {
  final Progress progress;
  const ProgressIcon({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);
    // Xác định trạng thái: 2=current, 1=completed, 0=not started
    final int status = checkProgressStatus(
      isCurrent: progress.isCurrent ?? false,
      isCompleted: progress.isCompleted ?? false,
    );
    // MÀU THEO TRẠNG THÁI
    Color buttonColor;
    Color backgroundColor;
    if (status == 2) {
      // CURRENT
      buttonColor = AppColor.primary600;
      backgroundColor = AppColor.primary500;
    } else if (status == 1) {
      // Completed
      buttonColor = AppColor.primary600;
      backgroundColor = AppColor.primary500;
    } else {
      // Not started
      buttonColor = AppColor.hurricane600;
      backgroundColor = AppColor.hurricane500;
    }

    return Builder(
      builder: (btnContext) {
        return ChicletAnimatedButton(
          buttonHeight: 8,
          buttonColor: buttonColor,
          backgroundColor: backgroundColor,

          onPressed: () {
            final double popoverHeight = _calculatePopoverHeight(isMobile);
            showPopover(
              context: btnContext,
              direction: PopoverDirection.right,
              backgroundColor: Colors.transparent,
              width: isMobile ? 270 : 350,
              height: popoverHeight,
              arrowHeight: 15,
              arrowWidth: 30,
              onPop: () => print('Popover was popped!'),
              bodyBuilder: (_) {
                return ChicletOutlinedFrame(
                  borderRadius: 16,
                  borderWidth: 2,
                  buttonHeight: 6,
                  borderColor: AppColor.hurricane200,
                  backgroundColor: Colors.transparent,
                  child: ProgressPage(
                    progressId: progress.id,
                    type: progress.contentType,
                    title: progress.progressName,
                  ),
                );
              },
            );
          },

          height: isMobile ? 60 : 110,
          width: isMobile ? 60 : 110,
          buttonType: ChicletButtonTypes.circle,
          child: Icon(
            getContentTypeIcon(),
            size: isMobile ? 40 : 60,
            color: Colors.white,
          ),
        );
      },
    );
  }

  int checkProgressStatus({
    required bool isCurrent,
    required bool isCompleted,
  }) {
    // 2 = Current, 1 = Completed, 0 = Not started
    if (isCurrent) return 2;
    if (isCompleted) return 1;
    return 0;
  }

  IconData getContentTypeIcon() {
    switch (progress.contentType?.toLowerCase()) {
      case 'video':
        return Iconsax.video;
      case 'test':
        return Iconsax.gift;
      case 'quiz':
        return Iconsax.book;
      default:
        return Icons.play_circle;
    }
  }

  double _calculatePopoverHeight(bool isMobile) {
    final int count = progress.totalVideo ?? 0;
    final double base = isMobile ? 80.0 : 80.0;
    final double minH = isMobile ? 120.0 : 250.0;
    final double maxH = isMobile ? 450.0 : 500.0;

    double h = (count * base) + 56.0;
    if (h < minH) h = minH;
    if (h > maxH) h = maxH;

    return h;
  }
}
