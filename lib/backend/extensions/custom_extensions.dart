import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_endpoint.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

extension GlassWidget<T extends Widget> on T {
  ClipRRect customGlassWidget({
    double blurX = 5.0,
    double blurY = 5.0,
    Color tintColor = Colors.white,
    BorderRadius? clipBorderRadius = BorderRadius.zero,
    Clip clipBehaviour = Clip.antiAlias,
    TileMode tileMode = TileMode.clamp,
    CustomClipper<RRect>? clipper,
  }) {
    return ClipRRect(
      clipper: clipper,
      clipBehavior: clipBehaviour,
      borderRadius: clipBorderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurX,
          sigmaY: blurY,
          tileMode: tileMode,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: (tintColor != Colors.transparent)
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      tintColor.withValues(alpha: 0.1),
                      tintColor.withValues(alpha: 0.08),
                    ],
                  )
                : null,
          ),
          child: this,
        ),
      ),
    );
  }
}

extension EndPointExtensions on String {
  String addBaseURl() {
    return "${ApiEndpoint.baseUrl}$this";
  }

  double parseDouble() {
    return double.parse(this);
  }
}

extension EndPointCustomExtension on String {
  String addBaseCustomURl() {
    return ApiEndpoint.baseUrl + this;
  }

  double parseDouble() {
    return double.parse(this);
  }
}

extension SupperRoute on String {
  get toNamed => Get.toNamed(this);

  get offAllNamed => Get.offAllNamed(this);

  get offNamed => Get.offNamed(this);
}
