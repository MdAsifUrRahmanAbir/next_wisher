import 'package:next_wisher/backend/local_storage/local_storage.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/widgets/dialog_helper.dart';

import '../../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../../controller/profile/profile_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
import '../../dynamic_webview_screen.dart';
import '../../profiles_screen/earnings_screen.dart';
import 'menu_button_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.put(ProfileController());

  void onAccountTap() {
    debugPrint("Account tapped");
    Get.toNamed(Routes.accountScreen);
    // Add your navigation or other logic here
  }

  void onProfileSetupTap() {
    debugPrint("Profile Setup tapped");
    Get.toNamed(Routes.profileSetupScreen);
    // Add your navigation or other logic here
  }

  void onWishRequestTap() {
    debugPrint("Wish Request tapped");
    Get.toNamed(Routes.wishRequest);
    // Add your navigation or other logic here
  }

  void onTipsTap() {
    debugPrint("Tips tapped");
    Get.toNamed(Routes.tipsScreen);
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  // verticalSpace(Dimensions.buttonHeight),
                  MenuButton(
                    title: Strings.guideline,
                    onTap: () {
                      Get.toNamed(Routes.guidelineScreen);
                    },
                  ),
                  const Divider(height: 1, thickness: 1),
                  MenuButton(
                    title: Strings.account,
                    onTap: onAccountTap,
                  ),
                  _talentSitesWidget(),
                  const Divider(height: 1, thickness: 1),
                  MenuButton(
                    title: Strings.themeChange,
                    onTap: () {
                      Get.toNamed(Routes.themeChangeScreen);
                    },
                  ),
                  const Divider(height: 1, thickness: 1),
                  Obx(() => Get.find<BottomNavController>().isLogoutLoading
                      ? const CustomLoadingAPI()
                      : MenuButton(
                          title: Strings.logout,
                          onTap: () {
                            DialogHelper.showAlertDialog(context,
                                title: Strings.logout,
                                content: Strings.logOutContent, onTap: () {
                              Get.find<BottomNavController>().logoutProcess();
                            });
                          },
                        )),
                ],
              ),
            ),
          ),
          Container(
            height: 250,
            color: Colors.black,
            child: Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 150,
                  fit: BoxFit.contain,
                ),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(WebViewScreen(
                            link: 'https://nextwisher.com/pages/privacy-policy',
                            appTitle: 'Privacy Policy',
                          ));
                        },
                        child: TitleHeading5Widget(
                          text: "Privacy Policy",
                          color: Colors.white,
                        )),
                    TextButton(
                        onPressed: () {
                          Get.to(WebViewScreen(
                            link:
                                'https://nextwisher.com/pages/terms-of-service',
                            appTitle: 'Terms of service',
                          ));
                        },
                        child: TitleHeading5Widget(
                          text: "Terms of service",
                          color: Colors.white,
                        )),
                    TextButton(
                        onPressed: () {
                          Get.to(WebViewScreen(
                            link: 'https://nextwisher.com/pages/faq',
                            appTitle: 'FAQ',
                          ));
                        },
                        child: TitleHeading5Widget(
                          text: "FAQ",
                          color: Colors.white,
                        )),
                    TextButton(
                        onPressed: () {
                          Get.to(WebViewScreen(
                            link: 'https://nextwisher.com/pages/contact',
                            appTitle: 'Contact',
                          ));
                        },
                        child: TitleHeading5Widget(
                          text: "Contact",
                          color: Colors.white,
                        )),
                  ],
                ),
                TitleHeading4Widget(
                  text: "© 2024 Nextwisher",
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _talentSitesWidget() {
    return LocalStorage.isUser()
        ? const SizedBox.shrink()
        : Column(
            children: [
              const Divider(height: 1, thickness: 1),
              MenuButton(
                title: "Profile Setup",
                onTap: onProfileSetupTap,
              ),
              const Divider(height: 1, thickness: 1),
              MenuButton(
                title: "Wish Request",
                onTap: onWishRequestTap,
              ),
              const Divider(height: 1, thickness: 1),
              MenuButton(
                title: "Tips",
                onTap: onTipsTap,
              ),
              const Divider(height: 1, thickness: 1),
              MenuButton(
                title: "Earnings",
                onTap: onEarningsTap,
              ),
            ],
          );
  }
}
