import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

/// {@template tkm_controller_mixin}
///
/// Mixin to connect the `State` in the `StatefulWidget` with a [TKMController]
///
/// With this Mixin the `StatefulWidget` have some implements methods
/// the [TKMController] child could access these methods to handle the animation behavior
///
/// `OpenState` is when animationController.value == 1.0
/// `CloseState` is when animationController.value == 0.0
///
/// {@endtemplate}
mixin TKMControllerMixin {
  late AnimationController animationController;

  void open() => animationController.forward();

  void close() => animationController.reverse();

  void start() {
    if (animationController.status == AnimationStatus.completed) {
      open();
    } else if (animationController.status == AnimationStatus.dismissed) {
      close();
    }
  }

  void animateToPosition(
    double value, {
    Duration? duration,
    Curve curve = Curves.linear,
  }) {
    assert(0.0 <= value && value <= 1.0);
    animationController.animateTo(value, duration: duration, curve: curve);
  }

  set setPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    animationController.value = value;
  }

  bool get isAnimationOpen => animationController.value == 1.0;
  bool get isAnimationClosed => animationController.value == 0.0;
  bool get isAnimating => animationController.isAnimating;
  double get getPosition => animationController.value;
}
