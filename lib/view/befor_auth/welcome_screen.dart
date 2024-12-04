import '../../language/language_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import '../bottom_nav/language_selection_bottom_sheet.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = "english"; // Default language
  RxBool isDarkMood = false.obs;

  @override
  void initState() {
    _selectedLanguage = languageSettingController.selectedLanguage.value;
    super.initState();
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LanguageSelectionBottomSheet(
          selectedLanguage: _selectedLanguage,
          onLanguageSelected: (String language) {
            setState(() {
              _selectedLanguage = language;
              languageSettingController.changeLanguage(language);
            });
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/welcome.png"))),
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
                  Positioned(
                    bottom: 50,
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
                    TextButton(
                        onPressed: () {
                          _showLanguageBottomSheet();
                        },
                        child: TitleHeading2Widget(
                          text: _selectedLanguage == "french"
                              ? "FR"
                              : _selectedLanguage == "portugues"
                                  ? "PR"
                                  : _selectedLanguage == "spanish"
                                      ? "SP"
                                      : "EN",
                          color: CustomColor.whiteColor,
                        )),

                    verticalSpace(Dimensions.paddingSizeVertical * .5),
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
