import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/basic_widget_imports.dart';

// custom appbar
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    super.key,
    required this.title,
    this.appbarSize,
    required this.onMenuTap,
    this.actions
  });

  final Widget title;
  final double? appbarSize;
  final VoidCallback onMenuTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: title,
      elevation: 0,
      leading: Animate(
        effects: const [FadeEffect(), ScaleEffect()],
        child: IconButton(
            onPressed: onMenuTap,
            icon: const Icon(
                Icons.dashboard
            )),
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
    );
  }

  @override
  // Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  Size get preferredSize =>
      Size.fromHeight(appbarSize ?? Dimensions.appBarHeight * .8);
}
