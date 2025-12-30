import 'package:chiclet/chiclet.dart';
import 'package:flutter/material.dart';
import 'package:math/core/utils/theme/app_color.dart';

class BasicDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showCancel;

  const BasicDialog({
    super.key,
    this.title,
    this.content,
    this.confirmText = 'OK',
    this.cancelText = 'Hủy',
    this.onConfirm,
    this.onCancel,
    this.showCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

            if (content != null) ...[const SizedBox(height: 12), content!],

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showCancel)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    child: Text(cancelText!),
                  ),
                ChicletOutlinedAnimatedButton(
                  width: 100,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm?.call();
                  },
                  height: 48,
                  child: Text(
                    confirmText!,
                    style: TextStyle(
                      color: AppColor.primary400,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
