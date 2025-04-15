import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: crossCenter,
        mainAxisAlignment: mainCenter,
        children: [
          Lottie.asset('assets/empty_animation.json',
              height: Dimensions.buttonHeight * 3),
          TitleHeading3Widget(
            text: "No result found",
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
