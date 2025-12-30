import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:math/common/widget/basic_dialog.dart';
import 'package:math/core/responsive/responsive_widget.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:math/features/math/tenbyten/view_models/ten_by_ten_cubit.dart';

class TenByTenPage extends StatelessWidget {
  const TenByTenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);
    final cubit = context.read<TenByTenCubit>();
    return BlocListener<TenByTenCubit, TenByTenState>(
      listenWhen: (p, c) => p.message != c.message || p.success != c.success,
      listener: (context, state) {
        if (state.message != null) {
          showDialog(
            context: context,
            builder: (_) =>
                BasicDialog(title: 'Thông báo', content: Text(state.message!)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              /// ================= HEADER =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<TenByTenCubit, TenByTenState>(
                      builder: (_, state) {
                        final filled = state.cells.where((e) => e).length;
                        return Text(
                          'Hãy bôi 15 ô..., đã bôi: $filled / ${state.target}',
                        );
                      },
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: cubit.reset,
                          child: const Text('Reset'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: cubit.submit,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// ================= GRID + LOTTIE =================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final size = constraints.maxWidth < constraints.maxHeight
                          ? constraints.maxWidth
                          : constraints.maxHeight;

                      final spacing = 4.0;
                      final cellSize = (size - spacing * 9) / 10;

                      return BlocBuilder<TenByTenCubit, TenByTenState>(
                        builder: (_, state) {
                          return Center(
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Stack(
                                children: [
                                  /// ================= GRID =================
                                  GestureDetector(
                                    onPanStart: (_) => cubit.hideGuide(),
                                    onPanUpdate: (details) {
                                      final pos = details.localPosition;

                                      final col =
                                          (pos.dx / (cellSize + spacing))
                                              .floor();
                                      final row =
                                          (pos.dy / (cellSize + spacing))
                                              .floor();

                                      if (row < 0 ||
                                          row >= 10 ||
                                          col < 0 ||
                                          col >= 10)
                                        return;

                                      final realIndex = col * 10 + row;
                                      cubit.fillCell(realIndex);
                                    },
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                          ),
                                      itemCount: 100,
                                      itemBuilder: (_, index) {
                                        final row = index ~/ 10;
                                        final col = index % 10;
                                        final realIndex = col * 10 + row;
                                        final filled = state.cells[realIndex];

                                        return Container(
                                          decoration: BoxDecoration(
                                            color: filled
                                                ? AppColor.primary600
                                                : AppColor.hurricane50,
                                            border: Border.all(
                                              color: Colors.black12,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  // ================= LOTTIE (CỘT ĐẦU, SIZE TO) =================
                                  if (state.showGuide)
                                    Positioned(
                                      top: 0,
                                      left: -2,
                                      child: IgnorePointer(
                                        child: Lottie.asset(
                                          'assets/Hand.json',
                                          height: isMobile ? 200 : 200 * 3,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TenByTenView extends StatelessWidget {
  const _TenByTenView();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);
    final cubit = context.read<TenByTenCubit>();

    return BlocListener<TenByTenCubit, TenByTenState>(
      listenWhen: (p, c) => p.message != c.message || p.success != c.success,
      listener: (context, state) {
        if (state.message != null) {
          showDialog(
            context: context,
            builder: (_) =>
                BasicDialog(title: 'Thông báo', content: Text(state.message!)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              /// ================= HEADER =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<TenByTenCubit, TenByTenState>(
                      builder: (_, state) {
                        final filled = state.cells.where((e) => e).length;
                        return Text(
                          'Hãy bôi 15 ô..., đã bôi: $filled / ${state.target}',
                        );
                      },
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: cubit.reset,
                          child: const Text('Reset'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: cubit.submit,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// ================= GRID + LOTTIE =================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final size = constraints.maxWidth < constraints.maxHeight
                          ? constraints.maxWidth
                          : constraints.maxHeight;

                      final spacing = 4.0;
                      final cellSize = (size - spacing * 9) / 10;

                      return BlocBuilder<TenByTenCubit, TenByTenState>(
                        builder: (_, state) {
                          return Center(
                            child: SizedBox(
                              width: size,
                              height: size,
                              child: Stack(
                                children: [
                                  /// ================= GRID =================
                                  GestureDetector(
                                    onPanStart: (_) => cubit.hideGuide(),
                                    onPanUpdate: (details) {
                                      final pos = details.localPosition;

                                      final col =
                                          (pos.dx / (cellSize + spacing))
                                              .floor();
                                      final row =
                                          (pos.dy / (cellSize + spacing))
                                              .floor();

                                      if (row < 0 ||
                                          row >= 10 ||
                                          col < 0 ||
                                          col >= 10)
                                        return;

                                      final realIndex = col * 10 + row;
                                      cubit.fillCell(realIndex);
                                    },
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                          ),
                                      itemCount: 100,
                                      itemBuilder: (_, index) {
                                        final row = index ~/ 10;
                                        final col = index % 10;
                                        final realIndex = col * 10 + row;
                                        final filled = state.cells[realIndex];

                                        return Container(
                                          decoration: BoxDecoration(
                                            color: filled
                                                ? AppColor.primary600
                                                : AppColor.hurricane50,
                                            border: Border.all(
                                              color: Colors.black12,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  // ================= LOTTIE (CỘT ĐẦU, SIZE TO) =================
                                  if (state.showGuide)
                                    Positioned(
                                      top: 0,
                                      left: -2,
                                      child: IgnorePointer(
                                        child: Lottie.asset(
                                          'assets/Hand.json',
                                          height: isMobile ? 200 : 200 * 3,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
