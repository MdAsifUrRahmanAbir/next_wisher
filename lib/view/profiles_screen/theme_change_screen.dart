import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../../utils/basic_screen_imports.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../controller/profile/guidline_controller.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';


class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({super.key});

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {

  bool isDark = false;
  @override
  void initState() {
    setState(() {
      isDark = (Themes().theme == ThemeMode.dark);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
         SwitchListTile(
             title: Row(
               children: [
                 Icon(isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
                 horizontalSpace(10),
                 TitleHeading3Widget(text: Strings.themeChange),
               ],
             ),
             value: isDark, onChanged: (value){
           setState(() {
             isDark = value;
             Themes().switchTheme();
           });
         })
        ],
      ),
    );
  }
}
