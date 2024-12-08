import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/utils/custom_snackbar.dart';
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
      appBar: PrimaryAppBar(
        title: Strings.wishRequest
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
          TitleHeading3Widget(text:
            Strings.wishTitle,
          ),
          const SizedBox(height: 20),
          TitleHeading3Widget(text:
            Strings.enterAmount,
              fontWeight: FontWeight.bold
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: PrimaryTextInputWidget(
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    if(value.isNotEmpty){
                      controller.amount.value = double.parse(value);
                    }
                  },
                  labelText: Strings.enterAmount,
                  hint: '',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      if(controller.amount.value.isLowerThan(30) || controller.amount.value.isGreaterThan(2500)){
                        CustomSnackBar.error(Strings.wishLimit);
                        return;
                      }
                      controller.wishSaveProcess();
                    },
                    title: Strings.updateAndSave),
              ),
            ],
          ),
          const SizedBox(height: 30),
          TitleHeading3Widget(
            text: Strings.activate,
              fontWeight: FontWeight.bold,
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
                      TitleHeading4Widget(
                        text: Strings.yes,
                        color: controller.wishIsActivated.value
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
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
                  child: TitleHeading4Widget(
                    text: Strings.no,
                    color: !controller.wishIsActivated.value
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
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
              title: Strings.previewProfile,
            ),
          ),
        ],
      ),
    );
  }
}
