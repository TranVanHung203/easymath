import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:math/core/constants/api_urls.dart';
import 'package:math/core/services/share_prefs_service.dart';
import 'package:math/core/utils/is_expire_token.dart';

class CheckTokenInterceptor extends Interceptor {
  final SharePrefsService _sharePrefsService;
  final Set<String> _noAuthPaths = {AuthApiUrls.login, AuthApiUrls.refresh};

  CheckTokenInterceptor({required SharePrefsService sharePrefsService})
    : _sharePrefsService = sharePrefsService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_noAuthPaths.contains(options.path)) {
      final currentToken = _sharePrefsService.getAccessToken();
      print("currentToken: $currentToken");
      if (isExpireToken(currentToken)) {
        log('Token is expired or not found, attempting refresh...');
        final refreshToken = _sharePrefsService.getRefreshToken();
        if (refreshToken != null) {
          try {
            // Create a new Dio instance without interceptor to avoid infinite loop
            final refreshDio = Dio(
              BaseOptions(
                baseUrl: options.baseUrl,
                headers: {'Accept': 'application/json'},
              ),
            );
            final response = await refreshDio.post(
              AuthApiUrls.refresh,
              data: {'refreshToken': refreshToken},
            );

            final newAccessToken = response.data['accessToken'];
            if (newAccessToken != null && newAccessToken.isNotEmpty) {
              await _sharePrefsService.saveAccessToken(newAccessToken);
              options.headers['Authorization'] = 'Bearer $newAccessToken';
            } else {
              throw Exception('No accessToken in response');
            }
          } catch (e) {
            log('Refresh token failed: $e');
            handler.reject(
              DioException(
                requestOptions: options,
                error: 'Token refresh failed: $e',
                type: DioExceptionType.unknown,
              ),
            );
            return;
          }
        } else {
          log('No refresh token found');
          handler.reject(
            DioException(
              requestOptions: options,
              error: 'Không tìm thấy token',
              type: DioExceptionType.unknown,
            ),
          );
          return;
        }
      } else if (currentToken != null) {
        options.headers['Authorization'] = 'Bearer $currentToken';
      }
    }
    handler.next(options);
  }
}
