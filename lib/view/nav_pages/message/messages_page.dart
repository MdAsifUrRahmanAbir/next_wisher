import '../../../controller/bottom_nav/message_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

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
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const ListTile(
            dense: true,
            title: TitleHeading4Widget(
              text: "Message",
              fontWeight: FontWeight.bold,
            ),
            subtitle: TitleHeading5Widget(text: "Message is here.."),
          );
        },
        separatorBuilder: (_, i) =>
            verticalSpace(Dimensions.paddingSizeVertical * .3),
      ),
    );
  }
}
