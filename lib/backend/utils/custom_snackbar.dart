import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../utils/custom_color.dart';
import '../../language/language_controller.dart';
import '../../utils/dimensions.dart';

class CustomSnackBar {
  static success(String message) {
    return Get.snackbar(
      languageSettingController
          .getTranslation('Success'),
        languageSettingController
        .getTranslation(message),
      // (message),
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * 0.5,
          vertical: Dimensions.paddingSizeVertical * 0.5),
      backgroundColor: CustomColor.primaryLightColor,
      colorText: CustomColor.whiteColor,
      leftBarIndicatorColor: Colors.green,
      progressIndicatorBackgroundColor: Colors.red,
      isDismissible: true,
      animationDuration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 5.0,
      mainButton: TextButton(
        onPressed: () {
          Get.closeCurrentSnackbar();
        },
        child: Text(
          languageSettingController
              .getTranslation("Dismiss"),
          style: TextStyle(color: CustomColor.whiteColor),
        ),
      ),
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
      ),
    );
  }

  static error(String message) {
    return Get.snackbar(
        languageSettingController
            .getTranslation('Alert'),
        // Get.find<LanguageController>().getTranslation(message),
        languageSettingController
            .getTranslation(message),
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * 0.5,
            vertical: Dimensions.paddingSizeVertical * 0.5),
        backgroundColor: Colors.red.withValues(alpha: 0.8), // withOpacity(
        colorText: CustomColor.whiteColor,
        leftBarIndicatorColor: Colors.red,
        progressIndicatorBackgroundColor: Colors.red,
        isDismissible: true,
        animationDuration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5.0,
        mainButton: TextButton(
          onPressed: () {
            Get.closeCurrentSnackbar();
          },
          child: Text(
            languageSettingController
                .getTranslation("Dismiss"),
            style: TextStyle(color: CustomColor.whiteColor),
          ),
        ),
        icon: const Icon(
          Icons.warning,
          color: Colors.green,
        ));
  }

  static toast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Colors.white,
        // textColor: Colors.black,
        // fontSize: 16.0
    );
  }
}
