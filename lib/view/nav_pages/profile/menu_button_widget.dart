import '../../../utils/basic_screen_imports.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MenuButton({super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      title: TitleHeading3Widget(
        text: title,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}