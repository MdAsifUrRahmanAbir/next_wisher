import '../../routes/routes.dart';
import '../../utils/assets.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List asset = [
      "assets/categories/actor.jpg",
      "assets/categories/people.jpg",
      "assets/categories/sport.jpg",
      "assets/categories/model.jpg",
      "assets/categories/onboard.jpg",
      "assets/categories/onboard2.jpg",
    ];
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Image.asset(
                    asset[0],
                    fit: BoxFit.cover,
                  )),
                  Expanded(
                      child: Image.asset(
                    asset[1],
                    fit: BoxFit.cover,
                  )),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Image.asset(
                    asset[2],
                    fit: BoxFit.cover,
                  )),
                  Expanded(
                      child: Image.asset(
                    asset[3],
                    fit: BoxFit.cover,
                  )),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Image.asset(asset[4], fit: BoxFit.cover)),
                  Expanded(child: Image.asset(asset[5], fit: BoxFit.cover)),
                ],
              ),
            ),
          ],
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              color: Colors.black.withOpacity(.6),
              child: Column(
                mainAxisAlignment: mainSpaceBet,
                crossAxisAlignment: crossCenter,
                children: [
                  // Image.asset(Assets.appDarkLogo),
                  verticalSpace(5),
                  Stack(
                    children: [
                      Image.asset("assets/playstore.png"),
                      Positioned(bottom: 150,
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
              ),
            )),
      ],
    );
  }
}
