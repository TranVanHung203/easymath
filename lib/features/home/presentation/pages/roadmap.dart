import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math/core/responsive/responsive_widget.dart';
import 'package:math/features/home/presentation/widgets/horizontal_wavy_path_painter.dart';
import 'package:math/features/home/presentation/widgets/progress_icon.dart';
import 'package:math/features/home/models/roadmap.dart';

class DuoHorizontalPage extends StatelessWidget {
  final Skill skill;
  final Roadmap roadmap;

  const DuoHorizontalPage({
    super.key,
    required this.skill,
    required this.roadmap,
  });

  @override
  Widget build(BuildContext context) {
    return HorizontalWavyPath(skill: skill, roadmap: roadmap);
  }
}

class HorizontalWavyPath extends StatelessWidget {
  final Skill skill;
  final Roadmap roadmap;

  const HorizontalWavyPath({
    super.key,
    required this.skill,
    required this.roadmap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);

    final double pathHeight = isMobile ? 200 : 300;
    final double nodeSize = isMobile ? 70 : 100;
    final double leftPadding = isMobile ? 60 : 80;
    final double rightPadding = isMobile ? 60 : 80;

    /// 🛟 Khoảng trống an toàn cho HERO (tránh AppBar)
    final double topSafeSpace = isMobile ? 60 : 100;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double centerY = topSafeSpace + pathHeight / 2;
          final double amplitude = pathHeight * 0.25;

          final int count = skill.progresses.length;

          final double horizontalStep = count <= 1
              ? 0
              : (width - leftPadding - rightPadding) / (count - 1);

          final List<Offset> centers = [];
          for (int i = 0; i < count; i++) {
            final double x = leftPadding + i * horizontalStep;
            final double y = centerY + amplitude * math.sin(i * math.pi / 3);
            centers.add(Offset(x, y));
          }

          final int currentIndex = skill.progresses.indexWhere(
            (p) => p.isCurrent ?? false,
          );
          final bool hasCurrent = currentIndex != -1;

          final double heroSize = isMobile ? 120 : 180;
          final double gap = isMobile ? 8 : 12;
          final double heroDownOffset = isMobile ? 24 : 28;
          final double circleSize = isMobile ? 120 : 180;

          Offset? heroOffset;
          double? heroTop;

          if (hasCurrent) {
            heroOffset = centers[currentIndex];
            final double nodeTop = heroOffset.dy - nodeSize / 2;
            heroTop = nodeTop - heroSize - gap + heroDownOffset;
          }

          return SizedBox(
            width: width,
            height: pathHeight + topSafeSpace,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                /// 🌊 PATH
                CustomPaint(
                  size: Size(width, pathHeight + topSafeSpace),
                  painter: HorizontalWavyPathPainter(centers),
                ),

                /// 🎯 VÒNG TRÒN CURRENT
                if (hasCurrent)
                  Positioned(
                    left: heroOffset!.dx - circleSize / 2,
                    top: heroOffset.dy - circleSize / 2,
                    child: IgnorePointer(
                      child: SizedBox(
                        width: circleSize,
                        height: circleSize,
                        child: Lottie.asset(
                          'assets/cirle.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                /// 🧩 NODES
                for (int i = 0; i < count; i++)
                  Positioned(
                    left: centers[i].dx - nodeSize / 2,
                    top: centers[i].dy - nodeSize / 2,
                    child: ProgressIcon(progress: skill.progresses[i]),
                  ),

                /// 🦌 HERO
                if (hasCurrent)
                  Positioned(
                    left: heroOffset!.dx - heroSize / 2,
                    top: heroTop!,
                    child: Lottie.asset(
                      width: heroSize,
                      height: heroSize,

                      'assets/huou_cao_co.json',
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
