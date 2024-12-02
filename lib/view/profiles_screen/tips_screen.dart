import 'package:next_wisher/backend/local_storage/local_storage.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../controller/bottom_nav/dashboard_controller.dart';
import '../../controller/profile/wish_and_tips_controller.dart';
import '../../utils/strings.dart';
import '../talent_profile/talent_profile.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  TipsScreenState createState() => TipsScreenState();
}

class TipsScreenState extends State<TipsScreen> {
  final controller = Get.put(WishAnTipsController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Strings.tip,
      ),
      body: Obx(() =>
          controller.isLoading ? const CustomLoadingAPI() : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading3Widget(
            text: Strings.tip,
              fontSize: 20, fontWeight: FontWeight.bold
          ),
          const SizedBox(height: 10),
           TitleHeading4Widget(
            text: Strings.tipsTitle,
          ),
          const SizedBox(height: 30),
          const Text(
            'Activate',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.tipsIsActivated.value = true;
                  controller.tipsSaveProcess();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: controller.tipsIsActivated.value
                        ? Colors.green
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Yes',
                        style: TextStyle(
                          color: controller.tipsIsActivated.value
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (controller.tipsIsActivated.value)
                        const Icon(Icons.check, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  controller.tipsIsActivated.value = false;
                  controller.tipsSaveProcess();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: !controller.tipsIsActivated.value
                        ? Colors.green
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: !controller.tipsIsActivated.value
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: PrimaryButton(
              onPressed: () {
                Get.find<DashboardController>().talentsProcess(LocalStorage.getId()!);
                Get.to(TalentProfile(showBTM: false));
                debugPrint("Preview Profile clicked");
              },
              title: 'Preview Profile',
            ),
          ),
        ],
      ),
    );
  }
}
