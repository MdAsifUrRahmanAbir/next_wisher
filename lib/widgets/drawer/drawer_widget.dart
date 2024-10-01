
import 'package:flutter_animate/flutter_animate.dart';
import '../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../view/dynamic_webview_screen.dart';
import '../dialog_helper.dart';
import 'drawer_tile_widget.dart';


class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final controller = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius * 2))),
      child: Drawer(
        child: _allItemListView(context),
      ),
    );
  }

  _drawerItems(BuildContext context) {
    return Column(
      children: AnimateList(children: [
        verticalSpace(Dimensions.marginSizeVertical * 1),
        // const ProfileImageWidget(
        //   isCircle: true,
        // ),
        // verticalSpace(Dimensions.marginSizeVertical * .5),
        // TitleHeading2Widget(
        //   text: Get.find<UpdateProfileController>()
        //       .profileModel
        //       .data
        //       .user
        //       .fullname,
        //   fontSize: Dimensions.headingTextSize2 * .85,
        // )
        //     .animate()
        //     .fadeIn(duration: 900.ms, delay: 300.ms)
        //     .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
        // verticalSpace(Dimensions.marginSizeVertical * .2),
        // TitleHeading4Widget(
        //   text:
        //       Get.find<UpdateProfileController>().profileModel.data.user.email,
        //   fontSize: Dimensions.headingTextSize4 * .9,
        //   opacity: .4,
        // )
        //     .animate()
        //     .fadeIn(duration: 900.ms, delay: 300.ms)
        //     .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
        // verticalSpace(Dimensions.marginSizeVertical * 1),


        DrawerTileButtonWidget(
          onTap: () {
            Get.toNamed(Routes.changePasswordScreen);
          },
          text: Strings.changePassword,
          icon: Icons.key,
        ),

        Obx(() => DrawerTileButtonWidget(
          onTap: (){
            controller.isDark.value = !controller.isDark.value;
            debugPrint(controller.isDark.value.toString());
            Themes().switchTheme();
          },
          text: Strings.changeTheme,
          icon: controller.isDark.value ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        )),

        DrawerTileButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                          appTitle: Strings.helpCenter,
                          link: "https://app.bnbcleaning.london/user/page/help",
                        )));
          },
          text: Strings.helpCenter,
          icon: Icons.help_outline_rounded,
        ),
        DrawerTileButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                          appTitle: Strings.privacyPolicy,
                          link: "https://app.bnbcleaning.london/user/page/faq",
                        )));
          },
          text: Strings.privacyPolicy,
          icon: Icons.privacy_tip_outlined,
        ),
        DrawerTileButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                          appTitle: Strings.faq,
                          link: "https://app.bnbcleaning.london/user/page/faq",
                        )));
          },
          text: Strings.faq,
          icon: Icons.info_outline,
        ),
        DrawerTileButtonWidget(
                onTap: () {
                  DialogHelper.showAlertDialog(context,
                      title: Strings.logout,
                      content: Strings.logOutContent, onTap: () async {
                    Get.close(1);
                    Get.offAllNamed(Routes.loginScreen);
                    // await controller.logOutProcess();
                  });
                },
                text: Strings.logout,
                icon: Icons.power_settings_new_outlined,
              ),
        verticalSpace(Dimensions.marginSizeVertical * .2),
      ]),
    );
  }

  _allItemListView(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        verticalSpace(Dimensions.heightSize * .2),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .07,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Get.close(1),
                  icon: Icon(
                    Icons.arrow_back,
                    size: Dimensions.iconSizeDefault * 1.2,
                  ),
                ),
              ),
              // Positioned(
              //   top: 0,
              //   left: 1,
              //   right: 1,
              //   child: AppIconWidget(
              //     height: MediaQuery.sizeOf(context).height * .06,
              //     width: MediaQuery.sizeOf(context).width * .4,
              //   ),
              // ),
            ],
          ),
        ),
        _drawerItems(context),
      ],
    );
  }
}
