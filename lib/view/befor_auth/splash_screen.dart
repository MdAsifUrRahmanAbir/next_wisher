
import '../../language/language_controller.dart';
import '../../utils/assets.dart';
import '../../utils/basic_screen_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: mainCenter,
            children: [
              Image.asset(
                  Get.isDarkMode ? Assets.splashDark : Assets.splashLight,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ],
          ),
          Visibility(
            visible: Get.find<LanguageSettingController>().isLoading,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.sizeOf(context).height * 0.2,
                left: MediaQuery.sizeOf(context).width * 0.15,
                right: MediaQuery.sizeOf(context).width * 0.15,
              ),
              child: LinearProgressIndicator(
                color:
                CustomColor.whiteColor.withOpacity(1),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
