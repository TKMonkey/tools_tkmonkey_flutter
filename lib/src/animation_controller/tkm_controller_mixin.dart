import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

/// {@template tkm_controller_mixin}
///
/// Mixin to connect the `State` in the `StatefulWidget` with a [TKMController]
///
/// With this Mixin the `StatefulWidget` have some implements methods
/// the [TKMController] child could access these methods to handle the animation behavior
///
/// `ForwardState` is when animationController.value == 0.0
/// `ReverseState` is when animationController.value == 1.0
///
/// {@endtemplate}
mixin TKMControllerMixin {
  late AnimationController animationController;

  void forward({double? from}) => animationController.forward(from: from);

  void reverse({double? from}) => animationController.reverse(from: from);

  void run() {
    if (isAnimationCompleted) {
      reverse();
    } else if (isAnimationDismissed) {
      forward();
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

  bool get isAnimationDismissed =>
      animationController.status == AnimationStatus.dismissed;
  bool get isAnimationCompleted =>
      animationController.status == AnimationStatus.completed;
  bool get isAnimating => animationController.isAnimating;
  double get getPosition => animationController.value;
}
