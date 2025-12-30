import 'package:flutter/material.dart';
//    final isMobile = ResponsiveWidget.isMobile(context);

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600 &&
      MediaQuery.of(context).size.shortestSide < 900;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 900;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return desktop;
    }
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        print('LayoutBuilder width: $width');
        // 📱 Mobile (kể cả xoay ngang)
        if (width < 600) {
          print('LayoutBuilder Mobile');
          return mobile;
        }

        // 📱 Mobile ngang → vẫn coi là mobile
        if (orientation == Orientation.landscape && width < 900) {
          print('LayoutBuilder Mobile Landscape');
          return mobile;
        }

        // 📱 Tablet
        if (width < 1200) {
          print('LayoutBuilder Tablet');
          return tablet;
        }
        print('LayoutBuilder Desktop');
        // 💻 Desktop
        return desktop;
      },
    );
  }
}
