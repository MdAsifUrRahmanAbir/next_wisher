import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../dynamic_webview_screen.dart';
import '../nav_pages/profile/menu_button_widget.dart';


class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          MenuButton(
            title: "Privacy Policy",
            onTap: () {
              Get.to(WebViewScreen(
                link: 'https://nextwisher.com/pages/privacy-policy',
                appTitle: 'Privacy Policy',
              ));
            },
          ),

          const Divider(height: 1, thickness: 1),
          MenuButton(
            title: "Terms of service",
            onTap: () {
              Get.to(WebViewScreen(
                link:
                'https://nextwisher.com/pages/terms-of-service',
                appTitle: 'Terms of service',
              ));
            },
          ),

          const Divider(height: 1, thickness: 1),
          MenuButton(
            title: "FAQ",
            onTap: () {
              Get.to(WebViewScreen(
                link: 'https://nextwisher.com/faq',
                appTitle: 'FAQ',
              ));
            },
          ),

          const Divider(height: 1, thickness: 1),
          MenuButton(
            title: "Contact",
            onTap: () {
              Get.to(WebViewScreen(
                link: 'https://nextwisher.com/contact',
                appTitle: 'Contact',
              ));
            },
          ),
        ],
      ),
    );
  }
}
