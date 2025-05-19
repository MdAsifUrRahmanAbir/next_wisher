import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
// import 'helper/local_notification_helper.dart';
import 'helper/notification_helper.dart';
import 'language/language_controller.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';
import 'utils/strings.dart';
import 'utils/theme.dart';



// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint("Handling a background message: ${message.messageId}");
// }

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationHelper.initialization();
  // NotificationService.init();

  NotificationHelper.getBackgroundNotification();
  debugPrint("MAIN >> 3");
  NotificationHelper.localNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: Themes().theme,
        initialRoute: Routes.splashScreen,
        initialBinding: BindingsBuilder(
              () {
                languageSettingController;
          },
        ),
        getPages: Pages.list,
        navigatorKey: Get.key,
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: widget!,
              ));
        },
      ),
    );
  }
}