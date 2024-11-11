import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/backend/utils/no_data_widget.dart';

import '../../../backend/services/wish/mail_index_model.dart';
import '../../../controller/bottom_nav/message_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
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
                        : Colors.black,
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
                        : Colors.black,
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
    return Obx(() => controller.selectedType.value == 1
        ? controller.inbox.isEmpty
            ? const NoDataWidget()
            : ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.inbox.length,
                itemBuilder: (context, index) {
                  Email data = controller.inbox[index];
                  return ListTile(
                    tileColor: data.seen == 0 ? Colors.red.withOpacity(.1) : Colors.transparent,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: TitleHeading2Widget(text: getInitials(data.name), color: Colors.white,),
                    ),
                    onTap: (){
                      if(data.seen == 0) {
                        debugPrint(data.seen.toString());
                        controller.mailSeenProcess(data.id.toString());
                      }
                      Get.to(UserInboxScreen(data: data));
                    },
                    dense: true,
                    title: TitleHeading4Widget(
                      text: data.name,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: TitleHeading5Widget(text: data.instructions),
                  );
                },
                separatorBuilder: (_, i) =>
                    verticalSpace(Dimensions.paddingSizeVertical * .3),
              )
        : controller.sent.isEmpty
            ? const NoDataWidget()
            : ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.sent.length,
                itemBuilder: (context, index) {
                  Email data = controller.sent[index];
                  return ListTile(
                    tileColor: data.seen == 0 ? Colors.red.withOpacity(.1) : Colors.transparent,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: TitleHeading2Widget(text: getInitials(data.name), color: Colors.white,),
                    ),
                    onTap: (){
                      if(data.seen == 0) {
                        debugPrint(data.seen.toString());
                        controller.mailSeenProcess(data.id.toString());
                      }
                      Get.to(UserSentScreen(data: data));
                    },
                    dense: true,
                    title: TitleHeading4Widget(
                      text: data.name,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: TitleHeading5Widget(text: data.instructions),
                  );
                },
                separatorBuilder: (_, i) =>
                    verticalSpace(Dimensions.paddingSizeVertical * .3),
              ));
  }


  String getInitials(String name) {
    List<String> nameParts = name.split(' '); // Split the name by spaces
    String initials = '';

    if (nameParts.length == 1) {
      // If there's only one word, take the first two letters
      initials = nameParts[0].substring(0, nameParts[0].length < 2 ? nameParts[0].length : 2);
    } else {
      // Take initials of the first two words only, if available
      for (int i = 0; i < nameParts.length && i < 2; i++) {
        if (nameParts[i].isNotEmpty) {
          initials += nameParts[i][0]; // Take the first letter of each part
        }
      }
    }

    return initials.toUpperCase();
  }
}
