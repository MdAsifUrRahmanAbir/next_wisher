import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../controller/bottom_nav/dashboard_controller.dart';
import '../../controller/profile/wish_and_tips_controller.dart';
import '../../utils/strings.dart';
import '../talent_profile/talent_profile.dart';

class WishRequest extends StatefulWidget {
  const WishRequest({super.key});

  @override
  WishRequestState createState() => WishRequestState();
}

class WishRequestState extends State<WishRequest> {
  final controller = Get.put(WishAnTipsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish Request'),
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
      child: ListView(
        children: [
          const Text(
            'Please setup an amount to charge for Wish Request',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          const Text(
            'Enter Amount',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: PrimaryTextInputWidget(
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  labelText: Strings.enterAmount,
                  hint: '',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      controller.wishSaveProcess();
                    },
                    title: 'Update/Save'),
              ),
            ],
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
                onTap: (){
                  controller.wishIsActivated.value = true;
                  controller.wishSaveProcess();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: controller.wishIsActivated.value
                        ? Colors.green
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Yes',
                        style: TextStyle(
                          color: controller.wishIsActivated.value
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (controller.wishIsActivated.value)
                        const Icon(Icons.check, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  controller.wishIsActivated.value = false;
                  controller.wishSaveProcess();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: !controller.wishIsActivated.value
                        ? Colors.green
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: !controller.wishIsActivated.value
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
                Get.find<DashboardController>().talentsProcess(LocalStorage.getId()!);
                Get.to(TalentProfile(showBTM: false,));
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
