import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Animations {
  static var appBarTitleAnimation = <Effect>[
    const FadeEffect(
      duration: Duration(milliseconds: 200),
    ),
    const SlideEffect(
      duration: Duration(milliseconds: 500),
      begin: Offset(1, 0),
    )
  ];
  static var contentColumnAnimation = <Effect>[
    const FadeEffect(),
    SlideEffect(duration: 200.ms)
  ];
}
