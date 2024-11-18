import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../controller/profile/wish_and_tips_controller.dart';

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
      appBar: AppBar(
        title: const Text('Tips'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
          const Text(
            'Tips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please activate the Tips option to receive tips from your fans or followers',
            style: TextStyle(fontSize: 16, color: Colors.black87),
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
                // Handle Preview Profile action
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
