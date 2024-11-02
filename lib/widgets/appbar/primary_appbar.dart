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
  });

  final String title;
  final double? appbarSize;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      title: TitleHeading2Widget(
        text: title,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
      leading: showBackButton
          ? BackButtonWidget(
              onTap: onTap ?? () => Navigator.pop(context),
            )
          : null,
      backgroundColor: Colors.transparent,
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
