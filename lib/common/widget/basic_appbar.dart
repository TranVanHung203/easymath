import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:math/core/utils/theme/app_color.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showTitle;
  final bool showBack;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onBackPress;

  const BasicAppbar({
    super.key,
    required this.title,
    this.showTitle = true,
    this.showBack = true,
    this.leftIcon,
    this.rightIcon,
    this.onBackPress,
  });

  static const double _appBarHeight = 30; // 👈 chiều cao mong muốn

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _appBarHeight, // 👈 quan trọng
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,

      leading:
          leftIcon ??
          (showBack
              ? IconButton(
                  padding: EdgeInsets.zero, // 👈 giảm padding
                  iconSize: 18, // 👈 icon nhỏ lại
                  icon: Icon(Icons.arrow_back_ios, color: AppColor.primary600),
                  onPressed: onBackPress ?? () => Navigator.pop(context),
                )
              : null),

      title: showTitle
          ? AutoSizeText(
              maxLines: 1,
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15, // 👈 chữ nhỏ hơn
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            )
          : null,

      centerTitle: true,
      actions: [
        if (rightIcon != null)
          Padding(padding: const EdgeInsets.only(right: 8), child: rightIcon!),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);
}
