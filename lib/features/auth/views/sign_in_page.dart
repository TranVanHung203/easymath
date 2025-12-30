import 'package:chiclet/chiclet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math/common/widget/basic_dialog.dart';
import 'package:math/common/widget/basic_text_field.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:math/features/auth/view_models/auth_cubit.dart';
import 'package:math/features/home/presentation/pages/dashboard_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late FocusNode _usernameFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thành công!')),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
            (route) => false,
          );
        } else if (state is AuthFailure) {
          showDialog(
            context: context,
            builder: (_) =>
                BasicDialog(title: 'Thông báo', content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            // Ảnh nền bên trái
            Image.asset(
              'assets/background.jpg',
              width: MediaQuery.of(context).size.width * 0.4,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // Form đăng nhập
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16,
                          children: [
                            Text(
                              "Đăng nhập",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            BasicTextField(
                              focusNode: _usernameFocus,
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                              hintText: "Tên đăng nhập",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập tên đăng nhập';
                                }
                                return null;
                              },
                            ),
                            BasicTextField(
                              focusNode: _passwordFocus,
                              controller: _passwordController,
                              textInputAction: TextInputAction.done,
                              hintText: "Mật khẩu",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập mật khẩu';
                                }
                                return null;
                              },
                            ),
                            ChicletAnimatedButton(
                              borderRadius: 100,
                              backgroundColor: AppColor.primary400,
                              onPressed: state is AuthLoading
                                  ? null
                                  : () {
                                      final error = _validateForm();

                                      if (error != null) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => BasicDialog(
                                            title: 'Thiếu thông tin',
                                            content: Text(error),
                                          ),
                                        );
                                        return;
                                      }

                                      context.read<AuthCubit>().login(
                                        username: _usernameController.text
                                            .trim(),
                                        password: _passwordController.text
                                            .trim(),
                                      );
                                    },

                              height: 64,
                              width: double.infinity,
                              child: state is AuthLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateForm() {
    if (_usernameController.text.trim().isEmpty) {
      return 'Vui lòng nhập tên đăng nhập';
    }
    if (_passwordController.text.trim().isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    return null;
  }
}
