import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/backend/utils/no_data_widget.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/services/wish/mail_index_model.dart';
import '../../../controller/bottom_nav/message_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../reload_action.dart';
import 'message_tile_widget.dart';
import 'user_inbox_screen.dart';
import 'user_sent_screen.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Obx(() => Row(
              children: [
                TextButton(
                  onPressed: () {
                    controller.selectedType.value = 1;
                  },
                  child: TitleHeading2Widget(
                    text: Strings.inbox,
                    color: controller.selectedType.value == 1
                        ? Theme.of(context).primaryColor
                        : null,
                    opacity: controller.selectedType.value == 1 ? 1 : .5,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    controller.selectedType.value = 2;
                  },
                  child: TitleHeading2Widget(
                    text: Strings.sent,
                    color: controller.selectedType.value == 2
                        ? Theme.of(context).primaryColor
                        : null,
                    opacity: controller.selectedType.value == 2 ? 1 : .5,
                  ),
                ),
              ],
            )),
      ),
      body: Obx(() =>
          controller.isLoading ? const CustomLoadingAPI() : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return ReloadAction(
      child: Obx(() => controller.selectedType.value == 1
          ? controller.inbox.isEmpty
              ? const NoDataWidget()
              : ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.inbox.length,
                  itemBuilder: (context, index) {
                    Email data = controller.inbox[index];

                    debugPrint(">> Name: ${data.name} >> Role: ${data.role}");

                    debugPrint("--------------------------------------");
                    debugPrint(data.expirationDate.isAfter(DateTime.now()).toString());
                    debugPrint(" Expiration Date: ${data.expirationDate}");
                    debugPrint(" Now Date: ${DateTime.now()}");

                    return MessageTileWidget(
                      onTap: () {
                        if (data.seen == 0) {
                          debugPrint(data.seen.toString());
                          controller.mailSeenProcess(data.id.toString());
                        }
                        debugPrint(LocalStorage.isUser().toString());
                        if(LocalStorage.isUser()){
                          debugPrint(LocalStorage.isUser().toString());
                          controller.ratingCheckModelProcess(userId: data.userId.toString(), earningId: data.talentEarningId.toString());
                        }
                        LocalStorage.isUser() ? Get.to(UserInboxScreen(data: data)) : Get.to(UserSentScreen(data: data,
                            isFiveDaysPass: !data.expirationDate.isAfter(DateTime.now())
                        ));
                      },
                      data: data,
                    );
                  },
                  separatorBuilder: (_, i) =>
                      verticalSpace(Dimensions.paddingSizeVertical * .3),
                )
          : controller.sent.isEmpty
              ? const NoDataWidget()
              : ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  itemCount: controller.sent.length,
                  itemBuilder: (context, index) {
                    Email data = controller.sent[index];

                    debugPrint(">> Name: ${data.name} >> Role: ${data.role}");

                    debugPrint("--------------------------------------");
                    debugPrint(data.expirationDate.isAfter(DateTime.now()).toString());
                    debugPrint(" Expiration Date: ${data.expirationDate}");
                    debugPrint(" Now Date: ${DateTime.now()}");
                    return MessageTileWidget(
                        onTap: () {
                          if (data.seen == 0) {
                            debugPrint(data.seen.toString());
                            controller.mailSeenProcess(data.id.toString());
                          }
                          !LocalStorage.isUser() ? Get.to(UserInboxScreen(data: data)) : Get.to(UserSentScreen(data: data, isFiveDaysPass: !data.expirationDate.isAfter(DateTime.now())));
                        },
                        data: data);
                  },
                  separatorBuilder: (_, i) =>
                      verticalSpace(Dimensions.paddingSizeVertical * .3),
                )),
    );
  }
}
