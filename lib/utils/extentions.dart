import 'package:flutter/material.dart';

import '../Color/Color.dart';

extension GradientDecoration on BuildContext {
  BoxDecoration customGradientBox() {


    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          colors.primary.withOpacity(0.7),
          colors.secondary,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.02, 1],
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
    );
  }
}