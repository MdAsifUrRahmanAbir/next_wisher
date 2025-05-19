import 'package:file_picker/file_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';

class CustomVideoPicketWidget extends StatefulWidget {
  const CustomVideoPicketWidget({super.key, required this.onPicked});

  final ValueChanged onPicked;

  @override
  CustomVideoPicketWidgetState createState() => CustomVideoPicketWidgetState();
}

class CustomVideoPicketWidgetState extends State<CustomVideoPicketWidget> {
  String? _fileName;

  // Request permission for file picking
  // Future<bool> _requestPermission() async {
  //   PermissionStatus status = await Permission.storage.request();
  //   if (status == PermissionStatus.granted) {
  //     return true;
  //   } else {
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //        SnackBar(content: Text(languageSettingController.getTranslation('Storage permission is required to upload a video.'))),
  //     );
  //     return false;
  //   }
  // }

  // Pick video file
  Future<void> _pickFile() async {
    bool permissionGranted = true;
    if (permissionGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null) {
        setState(() {
          _fileName = result.files.single.name;
          widget.onPicked(result.files.single.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
    languageSettingController.getTranslation("Verification: Please upload a video of your face. 10 seconds maximum"),
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * .4),
            border: Border.all(
              color: Theme.of(context).primaryColor
            )
          ),
          child: Row(
            children: [
              TextButton(
                onPressed: _pickFile,
                child: Text(languageSettingController.getTranslation("Choose File")),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _fileName ?? languageSettingController.getTranslation("No file chosen"),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}