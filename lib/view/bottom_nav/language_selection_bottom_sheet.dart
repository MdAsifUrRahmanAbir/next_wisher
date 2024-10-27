import '../../utils/basic_screen_imports.dart';

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
          const TitleHeading2Widget(
            text: "Select Language",
              fontWeight: FontWeight.bold
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: "English"),
            value: "English",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: "Français"),
            value: "Français",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: "Portuguese"),
            value: "Portuguese",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
          RadioListTile(
            title: const TitleHeading2Widget(
                text: "Español"),
            value: "Español",
            groupValue: _selectedLanguage,
            onChanged: (value) => _selectLanguage(value!),
          ),
        ],
      ),
    );
  }
}