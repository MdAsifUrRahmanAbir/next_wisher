

import '../../utils/basic_widget_imports.dart';

class DrawerTileButtonWidget extends StatelessWidget {
  const DrawerTileButtonWidget({super.key, required this.text, required this.icon, this.onTap, this.trailing});

  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: TitleHeading3Widget(text: text),
      trailing: trailing,
    );
  }
}
