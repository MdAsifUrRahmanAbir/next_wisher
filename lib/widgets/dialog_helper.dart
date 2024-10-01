
import '../backend/utils/custom_loading_api.dart';
import '../utils/basic_widget_imports.dart';
import 'text_labels/title_heading5_widget.dart';

class DialogHelper {
  static void showAlertDialog(BuildContext context,
      {required String title,
      String? btnText,
      bool isLoading = false,
      required String content,
      required VoidCallback onTap}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TitleHeading3Widget(text: title),
          content: TitleHeading4Widget(text: content, opacity: .6),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.close(1); // Close the dialog
              },
              child: const TitleHeading5Widget(
                  text: "Cancel", color: CustomColor.redColor),
            ),
            isLoading
                ? const CustomLoadingAPI()
                : TextButton(
                    onPressed: onTap,
                    child: TitleHeading5Widget(text: btnText ?? title),
                  ),
          ],
        );
      },
    );
  }
}
