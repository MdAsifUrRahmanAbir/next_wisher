import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/welcome.png"))
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: mainSpaceBet,
            crossAxisAlignment: crossCenter,
            children: [
              // Image.asset(Assets.appDarkLogo),
              verticalSpace(5),
              Stack(
                children: [
                  Image.asset("assets/logo.png"),
                  Positioned(bottom: 50,
                    left: 1,
                    right: 1,
                    child: TitleHeading5Widget(
                      text: Strings.welcomeText,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeHorizontal * .5),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeHorizontal * 2.5,
                    vertical: Dimensions.paddingSizeVertical),
                child: Column(
                  children: [
                    PrimaryButton(
                        title: Strings.signIn,
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          Get.toNamed(Routes.loginScreen);
                        }),
                    verticalSpace(Dimensions.paddingSizeVertical * .5),
                    PrimaryButton(
                        title: Strings.register,
                        backgroundColor: CustomColor.redColor,
                        onPressed: () {
                          Get.toNamed(Routes.userTypeScreen);
                        }),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
