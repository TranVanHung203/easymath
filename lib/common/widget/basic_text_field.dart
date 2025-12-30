import 'package:flutter/material.dart';
import 'package:math/core/utils/theme/app_color.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField({
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    required this.validator,
    this.hintText = 'Nhập dữ liệu',
    super.key,
  });
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.primary600,
      cursorErrorColor: AppColor.primary600,
      validator: validator,
      textInputAction: textInputAction,
      focusNode: focusNode,
      controller: controller,
      maxLength: 50,

      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: Colors.grey, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: AppColor.primary600, width: 2),
        ),
      ),
    );
  }
}
