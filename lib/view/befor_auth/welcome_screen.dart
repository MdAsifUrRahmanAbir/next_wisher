import '../../routes/routes.dart';
import '../../utils/assets.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          image: const DecorationImage(
              image: NetworkImage(
                "https://www.shutterstock.com/image-photo/full-body-little-small-fun-600nw-2110549943.jpg",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Spacer(),
                Container(
                  color: Colors.black.withOpacity(.6),
                  child: Column(
                    mainAxisAlignment: mainEnd,
                    crossAxisAlignment: crossStart,
                    children: [
                      Image.asset(Assets.appDarkLogo),
                      verticalSpace(5),
                      TitleHeading2Widget(
                        text: Strings.welcomeText,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeHorizontal * .5),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeHorizontal,
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
                ),
              ],
            ),
          )),
    );
  }
}
