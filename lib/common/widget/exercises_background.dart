import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math/core/utils/theme/app_color.dart';

class ExercisesBackground extends StatelessWidget {
  final Widget child;
  final String title;
  const ExercisesBackground({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.hurricane100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Center(child: Text(title, style: TextStyle(fontSize: 24))),

          // child,
          Expanded(child: child),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Lottie.asset(
                "assets/khung_long_nha_nuoi.json",
                width: 100,
                height: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
