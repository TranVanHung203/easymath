import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/chuc_donvi.dart';
import '../repositories/chuc_donvi_repository.dart';

sealed class ChucDonviState {}

class ChucDonviInitial extends ChucDonviState {}

class ChucDonviLoading extends ChucDonviState {}

class ChucDonviLoaded extends ChucDonviState {
  final List<ChucDonvi> items;
  ChucDonviLoaded(this.items);
}

class ChucDonviError extends ChucDonviState {
  final String message;
  ChucDonviError(this.message);
}

class ChucDonviCubit extends Cubit<ChucDonviState> {
  final ChucDonviRepository repo;

  ChucDonviCubit(this.repo) : super(ChucDonviInitial());

  Future<void> load() async {
    try {
      emit(ChucDonviLoading());
      final data = await repo.getAll();
      emit(ChucDonviLoaded(data));
    } catch (e) {
      emit(ChucDonviError(e.toString()));
    }
  }
}
