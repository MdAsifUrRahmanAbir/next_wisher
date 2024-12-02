
import '../../language/language_controller.dart';
import '../../utils/assets.dart';
import '../../utils/basic_screen_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
              Assets.splashImage,
            fit: BoxFit.cover,
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
