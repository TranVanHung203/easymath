import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:math/common/widget/exercises_background.dart';
import 'package:math/features/chuc_donvi/presentation/widgets/draggble_widget.dart';
import '../../view_models/chuc_donvi_cubit.dart';

class ChucDonviPage extends StatefulWidget {
  const ChucDonviPage({super.key});

  @override
  State<ChucDonviPage> createState() => _ChucDonviPageState();
}

class _ChucDonviPageState extends State<ChucDonviPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChucDonviCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return ExercisesBackground(
      title: 'Lấy 14 viên kẹo để vào khung sao cho phù hợp ',
      child: BlocBuilder<ChucDonviCubit, ChucDonviState>(
        builder: (context, state) {
          if (state is ChucDonviLoading) return const Placeholder();
          if (state is ChucDonviError) return Text(state.message);
          if (state is ChucDonviLoaded) {
            return DraggbleWidget(
              childWhenDragging: SvgPicture.network(
                state.items[0].url,
                width: 200,
                height: 200,
              ),
              childHolder: SvgPicture.network(
                state.items[1].url,
                width: 50,
                height: 50,
              ),
              childTarget: Table(
                border: TableBorder.all(
                  width: 1,
                ), // viền ngoài + đường kẻ trong
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      cell("Chục", header: true),
                      cell("Đơn vị", header: true),
                    ],
                  ),
                  TableRow(children: [cell("1"), cell("2")]),
                ],
              ),
              child: SvgPicture.network(
                state.items[0].url,
                width: 200,
                height: 200,
              ),
            );
          }
          return const Placeholder();
        },
      ),
    );
  }
}

Widget cell(String text, {bool header = false}) {
  return Container(
    color: header ? Colors.grey[300] : Colors.white,
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: header ? FontWeight.w600 : FontWeight.w400,
        fontSize: header ? 22 : 18,
      ),
    ),
  );
}
