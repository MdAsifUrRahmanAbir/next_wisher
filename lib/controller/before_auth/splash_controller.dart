import 'dart:async';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../backend/utils/navigator_plug.dart';

class SplashController extends GetxController {
  final navigatorPlug = NavigatorPlug();


  @override
  void onReady() {
    super.onReady();
    navigatorPlug.startListening(
      seconds: 3,
      onChanged: () {
        _goToScreen();
      },
    );
  }

  _goToScreen() async {
    Timer(const Duration(seconds: 0), () {
      LocalStorage.isLoggedIn()
          ? Get.offAllNamed(Routes.btmScreen)
          : Get.offAllNamed(Routes.welcomeScreen);
    });
  }

  @override
  void onClose() {
    navigatorPlug.stopListening();
    super.onClose();
  }
}
