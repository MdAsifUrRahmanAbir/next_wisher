import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

class CustomSnackBar {
  static success(String message) {
    return Get.snackbar(
      'Success',
      // Get.find<LanguageController>().getTranslation(message),
      (message),
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
        child: const Text(
          "Dismiss",
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
        'Alert',
        // Get.find<LanguageController>().getTranslation(message),
        (message),
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * 0.5,
            vertical: Dimensions.paddingSizeVertical * 0.5),
        backgroundColor: Colors.red.withOpacity(0.8),
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
          child: const Text(
            "Dismiss",
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
