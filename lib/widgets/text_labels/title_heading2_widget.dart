import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../language/language_controller.dart';
import '../../utils/dimensions.dart';

class TitleHeading2Widget extends StatelessWidget {
  const TitleHeading2Widget({
    super.key,
    required this.text,
    this.textAlign,
    this.textOverflow,
    this.padding = paddingValue,
    this.opacity = 1.0,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  static const paddingValue = EdgeInsets.all(0.0);

  @override
  Widget build(BuildContext context) {
    // RxBool isDark = Get.isDarkMode.obs;
    return Opacity(
      opacity: opacity,
      child: Padding(
          padding: padding,
          child: Obx(
            () => Text(
              languageSettingController.isLoading
                  ? ""
                  : languageSettingController.getTranslation(text),
              // style: isDark.value
              //     ? CustomStyle.darkHeading2TextStyle.copyWith(
              //         fontSize: fontSize, fontWeight: fontWeight, color: color)
              //     : CustomStyle.lightHeading2TextStyle.copyWith(
              //         fontSize: fontSize, fontWeight: fontWeight, color: color),
              style: TextStyle(
                  fontSize: fontSize ?? Dimensions.headingTextSize2,
                  fontWeight: fontWeight ?? FontWeight.w700,
                  color: color),
              textAlign: textAlign,
              overflow: textOverflow,
              maxLines: maxLines,
            ),
          )),
    );
  }
}
