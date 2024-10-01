import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
          Text(
            "No records found",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
