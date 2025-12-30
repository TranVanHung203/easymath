import 'package:dartz/dartz.dart';
import 'package:math/core/error/failure.dart';
import 'package:math/features/auth/models/auth.dart';
import 'package:math/features/auth/services/auth_api_service.dart';
import 'package:math/core/services/share_prefs_service.dart';

class AuthRepository {
  final AuthApiService _authApiService;
  final SharePrefsService _sharePrefsService;

  AuthRepository({
    required AuthApiService authApiService,
    required SharePrefsService sharePrefsService,
  }) : _authApiService = authApiService,
       _sharePrefsService = sharePrefsService;

  Future<Either<Failure, Auth>> login({
    required String username,
    required String password,
  }) async {
    final result = await _authApiService.login(
      username: username,
      password: password,
    );

    return result.fold((failure) => Left(failure), (auth) async {
      // Save tokens to local storage
      if (auth.accessToken != null) {
        await _sharePrefsService.saveAccessToken(auth.accessToken);
      }
      if (auth.refreshToken != null) {
        await _sharePrefsService.saveRefreshToken(auth.refreshToken);
      }
      return Right(auth);
    });
  }

  Future<Either<Failure, String>> refreshToken() async {
    final currentRefreshToken = _sharePrefsService.getRefreshToken();

    if (currentRefreshToken == null) {
      return Left(Failure(message: 'Refresh token not found'));
    }

    final result = await _authApiService.refreshToken(
      refreshToken: currentRefreshToken,
    );

    return result.fold((failure) => Left(failure), (newAccessToken) async {
      // Update access token
      await _sharePrefsService.saveAccessToken(newAccessToken);
      return Right(newAccessToken);
    });
  }

  Future<void> logout() async {
    await _sharePrefsService.clear();
  }
}
