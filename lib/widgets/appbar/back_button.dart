import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/basic_widget_imports.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onTap, this.color});

  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: CircleAvatar(
        backgroundColor: color ?? Theme.of(context).primaryColor.withValues(alpha: .3),
        child: Animate(
            effects: const [FadeEffect(), ScaleEffect()],
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
            )),
      ),
    );
  }
}
