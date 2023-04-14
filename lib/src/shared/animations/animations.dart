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

  static List<Effect<dynamic>> listViewAnimation(int index) {
    return <Effect>[
      FadeEffect(duration: (200 + index * 100).ms),
      const SlideEffect(begin: Offset(0, -1),curve: Curves.easeInOut)
    ];
  }
}
