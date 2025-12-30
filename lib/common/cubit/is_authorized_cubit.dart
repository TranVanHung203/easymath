import 'package:math/core/services/share_prefs_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsAuthorizedCubit extends Cubit<bool> {
  final SharePrefsService _sharePrefsService;

  IsAuthorizedCubit({required SharePrefsService sharePrefsService})
    : _sharePrefsService = sharePrefsService,
      super(false);

  void isAuthorized() {
    final token = _sharePrefsService.getAccessToken();
    emit(token != null);
  }

  void logout() async {
    await _sharePrefsService.clear();
    emit(false);
  }
}
