import 'dart:async';

import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';

class NavigatorPlug {
  StreamSubscription<bool>? _subscription;
  bool _timerStarted = false;

  void startListening({
    required int seconds,
    required VoidCallback onChanged,
  }) {
    _subscription = Get.find<LanguageSettingController>().isLoadingValue.stream.listen(
          (isLoading) {
        if (!_timerStarted) {
          _timerStarted = true;
          Timer(
            Duration(seconds: seconds),
                () {
              if (!Get.find<LanguageSettingController>().isLoadingValue.value) {
                _subscription?.cancel();
                onChanged();
              } else {
                _timerStarted = false;
              }
            },
          );
        }
      },
    );
  }

  void stopListening() {
    _subscription?.cancel();
  }
}