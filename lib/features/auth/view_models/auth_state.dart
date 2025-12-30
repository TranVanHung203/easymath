part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final Auth auth;

  const AuthSuccess({required this.auth});

  @override
  List<Object?> get props => [auth];
}

class AuthTokenRefreshed extends AuthState {
  final String accessToken;

  const AuthTokenRefreshed({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
