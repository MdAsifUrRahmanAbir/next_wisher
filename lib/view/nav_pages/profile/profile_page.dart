import '../../../utils/basic_screen_imports.dart';
import '../../profiles_screen/account_screen.dart';
import '../../profiles_screen/earnings_screen.dart';
import '../../profiles_screen/guidline_screen.dart';
import '../../profiles_screen/profle_setup_screen.dart';
import '../../profiles_screen/tips_screen.dart';
import '../../profiles_screen/wish_request_screen.dart';
import 'menu_button_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void onAccountTap() {
    debugPrint("Account tapped");
    Get.to(const AccountScreen());
    // Add your navigation or other logic here
  }

  void onProfileSetupTap() {
    debugPrint("Profile Setup tapped");
    Get.to(const ProfileSetupScreen());
    // Add your navigation or other logic here
  }

  void onWishRequestTap() {
    debugPrint("Wish Request tapped");
    Get.to(const WishRequest());
    // Add your navigation or other logic here
  }

  void onTipsTap() {
    debugPrint("Tips tapped");
    Get.to(const TipsScreen());
    // Add your navigation or other logic here
  }

  void onEarningsTap() {
    debugPrint("Earnings tapped");
    Get.to(const EarningScreen());
    // Add your navigation or other logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: mainCenter,
          children: [
            verticalSpace(Dimensions.buttonHeight),
            MenuButton(
              title: "Guideline",
              onTap: (){
                Get.to(const GuidelineScreen());
              },
            ),
            const Divider(height: 1,thickness: 1),
            MenuButton(
              title: "Account",
              onTap: onAccountTap,
            ),
            const Divider(height: 1,thickness: 1),
            MenuButton(
              title: "Profile Setup",
              onTap: onProfileSetupTap,
            ),
            const Divider(height: 1,thickness: 1),

            MenuButton(
              title: "Wish Request",
              onTap: onWishRequestTap,
            ),
            const Divider(height: 1,thickness: 1),

            MenuButton(
              title: "Tips",
              onTap: onTipsTap,
            ),
            const Divider(height: 1,thickness: 1),

            MenuButton(
              title: "Earnings",
              onTap: onEarningsTap,
            ),
          ],
        ),
      ),
    );
  }
}
