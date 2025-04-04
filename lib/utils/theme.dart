// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_color.dart';

class Themes {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  static final light = ThemeData.light().copyWith(
    primaryColor: CustomColor.primaryLightColor,
    scaffoldBackgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light, // For light mode
      ),
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: CustomColor.primaryLightTextColor,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
    iconTheme: const IconThemeData(
      color: Colors.black
    )
  );                       

  static final dark = ThemeData.dark().copyWith(
    primaryColor: CustomColor.primaryDarkColor,
    scaffoldBackgroundColor: CustomColor.primaryDarkScaffoldBackgroundColor,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark, // For light mode
      ),
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: CustomColor.primaryDarkTextColor,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      iconTheme: const IconThemeData(
          color: Colors.white
      )
  );
}