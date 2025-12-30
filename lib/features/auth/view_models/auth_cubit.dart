import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:math/features/auth/models/auth.dart';
import 'package:math/features/auth/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(const AuthLoading());

    final result = await _authRepository.login(
      username: username,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthFailure(error: failure.message)),
      (auth) => emit(AuthSuccess(auth: auth)),
    );
  }

  Future<void> refreshToken() async {
    final result = await _authRepository.refreshToken();

    result.fold(
      (failure) => emit(AuthFailure(error: failure.message)),
      (accessToken) => emit(AuthTokenRefreshed(accessToken: accessToken)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    try {
      await _authRepository.logout();
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
