import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';

class LanguageSelectionBottomSheet extends StatefulWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const LanguageSelectionBottomSheet({super.key,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  LanguageSelectionBottomSheetState createState() =>
      LanguageSelectionBottomSheetState();
}

class LanguageSelectionBottomSheetState
    extends State<LanguageSelectionBottomSheet> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.selectedLanguage;
  }

  void _selectLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    widget.onLanguageSelected(language);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleHeading2Widget(
            text: Strings.selectLanguage,
              fontWeight: FontWeight.bold
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: " English"),
            value: "english",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: " Français"),
            value: "french",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: " Portuguese"),
            value: "portugues",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: " Español"),
            value: "spanish",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
        ],
      ),
    );
  }
}