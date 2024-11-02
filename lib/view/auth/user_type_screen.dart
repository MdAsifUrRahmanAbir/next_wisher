import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Strings.createAccountAsA,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal,
          vertical: Dimensions.paddingSizeVertical,
        ),
        child: ListView(
          children: [
            // Image.asset(Assets.appBasicLogo),
            // verticalSpace(Dimensions.marginSizeVertical),
            // TitleHeading3Widget(
            //   text: Strings.createAccountAsA,
            //   color: Theme.of(context).primaryColor,
            // ),
            verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
            TitleHeading5Widget(
              text: Strings.aUserCanPlace,
            ),
            verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
            TitleHeading5Widget(
              text: Strings.aTalentCanEarn,
            ),
            verticalSpace(Dimensions.marginSizeVertical),
            Row(
              children: [
                Expanded(
                    child: PrimaryButton(
                        title: Strings.user,
                        onPressed: () {
                          Get.toNamed(Routes.userRegistrationScreen);
                        })),
                horizontalSpace(Dimensions.paddingSizeHorizontal * .5),
                Expanded(
                    child: PrimaryButton(
                        title: Strings.talent,
                        backgroundColor: Get.isDarkMode
                            ? CustomColor.secondaryDarkColor
                            : CustomColor.secondaryLightColor,
                        onPressed: () {
                          Get.toNamed(Routes.talentRegistrationScreen);
                        })),
              ],
            ),
            verticalSpace(Dimensions.marginSizeVertical),
          ],
        ),
      ),
    );
  }
}
