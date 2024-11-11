import '../../../backend/services/wish/mail_index_model.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class UserSentScreen extends StatelessWidget {
  const UserSentScreen({super.key, required this.data});

  final Email data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PrimaryAppBar(),
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TitleHeading3Widget(
                text: data.userName, color: Theme.of(context).primaryColor),
            verticalSpace(Dimensions.paddingSizeVertical * .4),
            data.name.isNotEmpty
                ? Column(
                    children: [
                      _row(Strings.name, data.name),
                      verticalSpace(Dimensions.paddingSizeVertical * .2),
                    ],
                  )
                : Column(
                    children: [
                      _row(Strings.forText, data.emailFor),
                      verticalSpace(Dimensions.paddingSizeVertical * .2),
                      _row(Strings.from, data.from),
                      verticalSpace(Dimensions.paddingSizeVertical * .2),
                    ],
                  ),
            _row(Strings.gender, data.genders),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            _row(Strings.occasion, data.occasion),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            _row(Strings.instruction, data.instructions),
          ],
        )));
  }

  _row(String title, String value) {
    return Row(
      children: [
        TitleHeading4Widget(text: "$title: ", fontWeight: FontWeight.bold),
        horizontalSpace(Dimensions.paddingSizeHorizontal * .2),
        Expanded(
            child: TitleHeading5Widget(
          text: value,
          opacity: .7,
        )),
      ],
    );
  }
}
