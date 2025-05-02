import '../../utils/basic_screen_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: mainCenter,
        children: [
          Image.asset(
            "assets/bg.png",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Image.asset(
            "assets/logo.png",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
