import '../../utils/basic_screen_imports.dart';
import 'title_heading5_widget.dart';

class TitleAndValueWidget extends StatelessWidget {
  const TitleAndValueWidget(
      {super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      children: [
        Row(
          crossAxisAlignment: crossStart,
          children: [
            TitleHeading5Widget(
                text: title, color: Theme.of(context).primaryColor),
            horizontalSpace(5),
            Expanded(child: TitleHeading4Widget(
                text: value,
              textAlign: TextAlign.right,
            )),
          ],
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
      ],
    );
  }
}
