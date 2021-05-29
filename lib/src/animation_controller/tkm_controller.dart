import 'package:flutter/material.dart';
import 'tkm_controller_mixin.dart';

/// {@template tkm_controller}
///
/// Class to create a controller to handle some encapsulated custom animation widget
/// With this class, the custom widget has a way to handle some behavior for animationController
/// without exposing the animationController to public
///
/// The basic use is `extends` this class to your custom controller,
/// add the mixin you need to add new functionalities to the custom controller
/// With this the `TKMController` try to reproduce https://en.wikipedia.org/wiki/Interface_segregation_principle
///
/// The State class of custom widget should implements the `Mixin` [AnimationControllerMixin]
/// After that in the `initState` method from `StatefulWidget` call the `addState`
/// to attached the state to the controller
///
/// {@endtemplate}

const _message =
    'TKMController must be attached to a Widget with AnimationControllerMixin';

abstract class TKMController extends BaseControllerFunction {}

abstract class BaseControllerFunction<S extends TKMControllerMixin> {
  S? stateMixin;

  /// Attached the state to this controller
  set addState(S state) {
    stateMixin = state;
  }

  /// Determine if the state with AnimationControllerMixin is attached to an instance
  bool get isAttached => stateMixin != null;
}

mixin CloseFunction implements BaseControllerFunction {
  /// Start animation to close
  /// Clossed is animationController.value == 1.0
  void close() {
    assert(isAttached, _message);
    stateMixin!.open();
  }

  /// Returns whether or not the panel is 'closed'.
  /// Clossed is animationController.value == 0.0
  bool get isClosed {
    assert(isAttached, _message);
    return stateMixin!.isAnimationClosed;
  }
}

mixin OpenFunction implements BaseControllerFunction {
  /// Start animation to close
  /// Clossed is animationController.value == 0.0
  void open() {
    assert(isAttached, _message);
    stateMixin!.open();
  }

  /// Returns whether or not the animation is 'open'.
  /// Clossed is animationController.value == 1.0
  bool get isOpen {
    assert(isAttached, _message);
    return stateMixin!.isAnimationOpen;
  }
}

mixin StartFunction implements BaseControllerFunction {
  /// Run animation and decide if execute open or close
  void start() {
    // assert(isAttached, _message);
    // stateMixin.start();
  }
}

mixin GetPositionFunction implements BaseControllerFunction {
  /// Gets the current animationController position.
  /// Decimal between 0.0 and 1.0
  double get getPosition {
    assert(isAttached, _message);
    return stateMixin!.getPosition;
  }
}

mixin SetPositionFunction implements BaseControllerFunction {
  /// Sets the animationController position (without animation).
  /// The value must between 0.0 and 1.0
  set setPosition(double value) {
    assert(isAttached, _message);
    assert(0.0 <= value && value <= 1.0);
    stateMixin!.setPosition = value;
  }
}

mixin AnimateToPositionFunction implements BaseControllerFunction {
  /// Animates the widget position to the value.
  /// The value must between 0.0 and 1.0
  /// (optional) duration specifies the time for the animation to complete
  /// (optional) curve specifies the easing behavior of the animation.
  void animateToPosition(
    double value, {
    Duration? duration,
    Curve curve = Curves.linear,
  }) {
    assert(isAttached, _message);
    assert(0.0 <= value && value <= 1.0);
    stateMixin!.animateToPosition(value, duration: duration, curve: curve);
  }
}
