import 'package:chiclet/chiclet.dart';
import 'package:flutter/material.dart';
import 'package:math/core/utils/theme/app_color.dart';

class VideoAppbar extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback onMenu;
  final String? title;

  const VideoAppbar({super.key, this.onBack, required this.onMenu, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChicletOutlinedAnimatedButton(
            onPressed: Navigator.of(context).pop,
            height: 50,
            child: const Icon(
              Icons.keyboard_return_rounded,
              size: 40,
              color: AppColor.primary400,
            ),
          ),
          Text(
            title ?? 'Video Lesson',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColor.primary400,
            ),
          ),
          SizedBox(width: 50, height: 50),
          // ChicletOutlinedAnimatedButton(
          //   onPressed: onMenu,
          //   height: 50,
          //   child: const Icon(
          //     Icons.menu_rounded,
          //     size: 40,
          //     color: AppColor.primary400,
          //   ),
          // ),
        ],
      ),
    );
  }
}
