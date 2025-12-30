import 'package:auto_size_text/auto_size_text.dart';
import 'package:chiclet/chiclet.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:math/core/responsive/responsive_widget.dart';
import 'package:math/core/utils/theme/app_color.dart';

class DashboardAppbar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onMenu;
  final VoidCallback onVoice;
  final String? title;
  final int? currentIndex;

  const DashboardAppbar({
    super.key,
    required this.onBack,
    required this.onVoice,
    required this.onMenu,
    this.currentIndex,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width; // Không gọi lại nhiều lần
    final screenHeight = size.height;
    final isMobile = ResponsiveWidget.isMobile(context);
    final index = currentIndex ?? 0;
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ChicletSegmentedButton(
              backgroundColor: index.isEven
                  ? AppColor.primary400
                  : AppColor.primary700,
              // width: isMobile ? screenWidth * 0.5 : screenWidth * 0.6,
              height: isMobile ? screenHeight * 0.2 : screenHeight * 0.1,
              buttonHeight: 6,
              children: [
                Expanded(
                  child: ChicletButtonSegment(
                    onPressed: () {},
                    child: AutoSizeText(
                      maxLines: 1,
                      title ?? "Easy Math",
                      style: TextStyle(
                        fontSize: isMobile
                            ? screenWidth * 0.04
                            : screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ChicletButtonSegment(
                  onPressed: onVoice,
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.record_voice_over_rounded,
                    size: isMobile ? 25 : 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: isMobile ? screenWidth * 0.3 : screenWidth * 0.3),
          Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              ChicletOutlinedAnimatedButton(
                onPressed: onBack,
                height: isMobile ? 50 : 80,
                child: Icon(
                  Icons.keyboard_return_rounded,
                  size: isMobile ? 25 : 50,
                  color: AppColor.primary400,
                ),
              ),

              ChicletOutlinedAnimatedButton(
                onPressed: onMenu,
                height: isMobile ? 50 : 80,
                child: Icon(
                  Iconsax.menu_1_copy,
                  size: isMobile ? 25 : 50,
                  color: AppColor.primary400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
