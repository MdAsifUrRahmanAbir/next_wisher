import '../../utils/basic_widget_imports.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({super.key, required this.preText, required this.postText, required this.onPressed, this.opacity, this.textAlign});

  final String preText, postText;
  final VoidCallback onPressed;
  final double? opacity;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: (preText),
              style: Theme.of(context).textTheme.bodySmall
            ),
            TextSpan(
              text: (postText),
              style: CustomStyle.lightHeading5TextStyle.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              )
            ),
          ],
        ),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}
