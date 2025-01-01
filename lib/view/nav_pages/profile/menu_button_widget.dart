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
      title: TitleHeading3Widget(
        text: title,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}