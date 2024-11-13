import 'dart:async';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../backend/local_storage/local_storage.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    _goToScreen();
  }

  _goToScreen() async {
    Timer(const Duration(seconds: 3), () {
      LocalStorage.isLoggedIn()
          ? Get.offAllNamed(Routes.btmScreen)
          : Get.offAllNamed(Routes.welcomeScreen);
    });
  }
}
