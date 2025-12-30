import 'package:flutter/material.dart';
import 'dart:math' as math;

enum ButtonTypes { roundedRectangle, circle, oval }

class ChicletButtonTypes {
  static ButtonTypes get roundedRectangle => ButtonTypes.roundedRectangle;

  static ButtonTypes get circle => ButtonTypes.circle;

  static ButtonTypes get oval => ButtonTypes.oval;
}

class ChicletOutlinedFrame extends StatelessWidget {
  final Widget child;
  final bool isPressed;

  final double? width;
  final double height;
  final double buttonHeight;
  final double borderWidth;
  final double borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? disabledBorderColor;
  final ButtonTypes buttonType;

  const ChicletOutlinedFrame({
    super.key,
    required this.child,
    this.isPressed = false,
    this.width,
    this.height = 50,
    this.buttonHeight = 4,
    this.borderWidth = 2,
    this.borderRadius = 16,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.disabledBorderColor,
    this.buttonType = ButtonTypes.roundedRectangle,
  });

  @override
  Widget build(BuildContext context) {
    final double? chicletWidth = buttonType == ButtonTypes.circle
        ? height
        : width;

    final double chicletBorderRadius =
        buttonType == ButtonTypes.roundedRectangle
        ? (borderRadius > height / 2 ? height / 2 : borderRadius)
        : buttonType == ButtonTypes.circle
        ? height / 2
        : borderRadius;

    return Container(
      width: chicletWidth,
      height: isPressed ? height : height + buttonHeight,
      margin: EdgeInsets.only(top: isPressed ? buttonHeight : 0),
      padding: EdgeInsets.fromLTRB(0, 0, 0, isPressed ? 0 : buttonHeight),
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: buttonType == ButtonTypes.oval
            ? BorderRadius.all(
                Radius.elliptical((chicletWidth ?? height), height),
              )
            : BorderRadius.circular(chicletBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: ClipRRect(
          borderRadius: buttonType == ButtonTypes.oval
              ? BorderRadius.all(
                  Radius.elliptical(
                    math.max((chicletWidth ?? height) - borderWidth * 2, 0),
                    math.max(height - borderWidth * 2, 0),
                  ),
                )
              : BorderRadius.circular(
                  math.max(chicletBorderRadius - borderWidth, 0),
                ),
          child: Container(color: backgroundColor, child: child),
        ),
      ),
    );
  }
}
