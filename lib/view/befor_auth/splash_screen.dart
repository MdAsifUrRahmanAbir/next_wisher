
import '../../utils/assets.dart';
import '../../utils/basic_screen_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
          Assets.splashImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
