import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/basic_widget_imports.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
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
