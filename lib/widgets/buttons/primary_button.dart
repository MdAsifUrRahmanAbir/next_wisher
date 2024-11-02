import '../../utils/basic_widget_imports.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderWidth = 0,
    this.height,
    this.shape,
    this.icon,
    this.fontSize,
    this.fontWeight,
    this.prefix = "",
    this.suffix = "", this.backgroundColor,
  });
  final String title, prefix, suffix;
  final VoidCallback onPressed;
  final double borderWidth;
  final double? height;
  final OutlinedBorder? shape;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.buttonHeight * 0.7,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape ??
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * .4)),
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          side: BorderSide(
            width: borderWidth,
            color: backgroundColor ?? Theme.of(context).primaryColor
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // icon ?? const SizedBox(),
            Visibility(
              visible: prefix.isNotEmpty,
              child: Text(
                  (prefix),
                style: CustomStyle.darkHeading3TextStyle.copyWith(
                  fontSize: fontSize ?? Dimensions.headingTextSize5,
                  color: CustomColor.whiteColor,
                  fontWeight: fontWeight ?? FontWeight.w900,
                ),
              ),
            ),

            Text(
               (title),
              style: CustomStyle.darkHeading3TextStyle.copyWith(
                fontSize: fontSize ?? Dimensions.headingTextSize3,
                color: CustomColor.whiteColor,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
            ),


            Visibility(
              visible: suffix.isNotEmpty,
              child: Text(
           (suffix),
                style: CustomStyle.darkHeading3TextStyle.copyWith(
                  fontSize: fontSize ?? Dimensions.headingTextSize5,
                  color: CustomColor.whiteColor,
                  fontWeight: fontWeight ?? FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
