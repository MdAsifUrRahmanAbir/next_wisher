import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';

class TitleHeading3Widget extends StatelessWidget {
  const TitleHeading3Widget({
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
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  static const paddingValue = EdgeInsets.all(0.0);

  @override
  Widget build(BuildContext context) {
    // RxBool isDark = Get.isDarkMode.obs;
    return Opacity(
      opacity: opacity,
      child: Padding(
          padding: padding,
          child: Text(
              (text),
              // style: isDark.value
              //     ? CustomStyle.darkHeading3TextStyle.copyWith(
              //         fontSize: fontSize, fontWeight: fontWeight, color: color)
              //     : CustomStyle.lightHeading3TextStyle.copyWith(
              //         fontSize: fontSize, fontWeight: fontWeight, color: color),
            style: TextStyle(
                fontSize: fontSize ?? Dimensions.headingTextSize3,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: color
            ),
              textAlign: textAlign,
              overflow: textOverflow,
              maxLines: maxLines,
            )
          ),
    );
  }
}
