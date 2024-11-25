import '../../utils/basic_widget_imports.dart';
import 'back_button.dart';

// custom appbar
class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
    this.title = "",
    this.appbarSize,
    this.onTap,
    this.showBackButton = true,
    this.actions,
    this.color,
  });

  final String title;
  final double? appbarSize;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      title: TitleHeading2Widget(
        text: capitalizeWords(title),
        fontWeight: FontWeight.w600,
        color: color == null ? null: Colors.white,
      ),
      elevation: 0,
      leading: showBackButton
          ? BackButtonWidget(
              onTap: onTap ?? () => Navigator.pop(context),
        color: color == null ? null: Colors.white,
            )
          : null,
      backgroundColor: color ?? Colors.transparent,
      actions: actions,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
    );
  }

  @override
  // Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  Size get preferredSize =>
      Size.fromHeight(appbarSize ?? Dimensions.appBarHeight * .7);
}

String capitalizeWords(String input) {
  if (input.isEmpty) return input;
  return input
      .split(' ') // Split the string into words
      .map((word) => word.isNotEmpty
      ? word[0].toUpperCase() + word.substring(1).toLowerCase()
      : word) // Capitalize the first letter of each word
      .join(' '); // Join the words back into a single string
}