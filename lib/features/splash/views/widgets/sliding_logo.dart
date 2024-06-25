import 'package:flutter/material.dart';

import '/core/utilities/assets_data.dart';

class SlidingLogo extends StatelessWidget {
  const SlidingLogo({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Image.asset(
            AssetsData.logoImage,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        );
      },
    );
  }
}
