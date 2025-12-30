import 'package:flutter/material.dart';
import 'package:math/core/utils/theme/app_color.dart';

class DraggbleWidget extends StatefulWidget {
  final Widget childHolder;
  final Widget child;
  final Widget childWhenDragging;
  final Widget childTarget;
  const DraggbleWidget({
    super.key,
    required this.child,
    required this.childHolder,
    required this.childWhenDragging,
    required this.childTarget,
  });

  @override
  State<DraggbleWidget> createState() => _DraggbleWidgetState();
}

class _DraggbleWidgetState extends State<DraggbleWidget> {
  int units = 0;
  int tens = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable<int>(
          // Data is the value this Draggable stores.
          data: 1,
          dragAnchorStrategy: (draggable, context, position) {
            return Offset(10, 80);
          },
          feedback: widget.childHolder,
          childWhenDragging: PressScale(child: widget.childWhenDragging),
          child: PressScale(child: widget.child),
        ),
        DragTarget<int>(
          builder:
              (
                BuildContext context,
                List<int?> candidateData,
                List<dynamic> rejected,
              ) {
                // Tổng data đang rê vào (thường chỉ 1 phần tử)
                final int incoming = candidateData.fold<int>(
                  0,
                  (sum, e) => sum + (e ?? 0),
                );
                final bool isHovering = incoming > 0;

                // Preview (giả lập nếu thả vào)
                int pUnits = units + incoming;
                int pTens = tens + (pUnits ~/ 10);
                pUnits = pUnits % 10;

                return SizedBox(
                  width: 220,
                  height: 140,
                  child: Table(
                    border: TableBorder.all(width: 1),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          _cell("Chục", header: true),
                          _cell("Đơn vị", header: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          _cell(
                            (isHovering ? pTens : tens).toString(),
                            opacity: isHovering ? 0.35 : 1.0,
                          ),
                          _cell(
                            (isHovering ? pUnits : units).toString(),
                            opacity: isHovering ? 0.35 : 1.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
          onAcceptWithDetails: (details) {
            setState(() {
              units += details.data;
              tens += units ~/ 10;
              units = units % 10;
            });
          },
        ),
      ],
    );
  }

  Widget _cell(String text, {bool header = false, double opacity = 1.0}) {
    return Container(
      color: header ? AppColor.hurricane500 : Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: header ? 0 : 12,
        vertical: header ? 0 : 30,
      ),
      child: Opacity(
        opacity: opacity,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: header ? 24 : 30,
            color: header ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class PressScale extends StatefulWidget {
  final Widget child;
  final double pressedScale;
  final Duration duration;

  const PressScale({
    super.key,
    required this.child,
    this.pressedScale = 0.95,
    this.duration = const Duration(milliseconds: 90),
  });

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => setState(() => _down = true),
      onPointerUp: (_) => setState(() => _down = false),
      onPointerCancel: (_) => setState(() => _down = false),
      child: AnimatedScale(
        scale: _down ? widget.pressedScale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
