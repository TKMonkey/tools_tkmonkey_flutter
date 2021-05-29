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
/// After that call the mixin Function with your own functions
///
/// ```dart
/// class CustomController extends TKMController with OpenFunction {
///   void open() => openFunction();
/// }
/// ```
///
/// The State class of custom widget should implements the `Mixin` [AnimationControllerMixin]
/// After that in the `initState` method from `StatefulWidget` call the `addState`
/// to attached the state to the controller
///
/// {@endtemplate}

abstract class TKMController extends BaseControllerFunction {}

/// {@template tkm_base_controller}
/// Base class for implementing `TKMController` and give access to mixin to state
///
/// {@endtemplate}
abstract class BaseControllerFunction<S extends TKMControllerMixin> {
  S? _stateMixin;

  /// Attached the state to this controller
  set addState(S state) {
    _stateMixin = state;
  }

  /// Determine if the state with AnimationControllerMixin is attached to an instance
  bool get isAttached => _stateMixin != null;
}

/// {@template tkm_close_function}
/// Mixin to implementing the `close` function
///
/// {@endtemplate}
mixin CloseFunction implements BaseControllerFunction {
  /// Start animation to close
  /// Clossed is animationController.value == 1.0
  void closeFunction() {
    assert(isAttached, _message);
    _stateMixin!.close();
  }

  /// Returns whether or not the panel is 'closed'.
  /// Clossed is animationController.value == 0.0
  bool get isClosedFunction {
    assert(isAttached, _message);
    return _stateMixin!.isAnimationClosed;
  }
}

/// {@template tkm_open_function}
/// Mixin to implementing the `open` function
///
/// {@endtemplate}
mixin OpenFunction implements BaseControllerFunction {
  /// Start animation to open
  /// Clossed is animationController.value == 0.0
  void openFunction() {
    assert(isAttached, _message);
    _stateMixin!.open();
  }

  /// Returns whether or not the animation is 'open'.
  /// Clossed is animationController.value == 1.0
  bool get isOpenFunction {
    assert(isAttached, _message);
    return _stateMixin!.isAnimationOpen;
  }
}

/// {@template tkm_start_function}
/// Mixin to implementing the `start` function
///
/// {@endtemplate}
mixin StartFunction implements BaseControllerFunction {
  /// Run animation and decide if execute open or close
  void startFunction() {
    assert(isAttached, _message);
    _stateMixin!.start();
  }
}

/// {@template tkm_get_position_function}
/// Mixin to implementing the `getPosition` function
///
/// {@endtemplate}
mixin GetPositionFunction implements BaseControllerFunction {
  /// Gets the current animationController position.
  /// Decimal between 0.0 and 1.0
  double get getPositionFunction {
    assert(isAttached, _message);
    return _stateMixin!.getPosition;
  }
}

/// {@template tkm_set_position_function}
/// Mixin to implementing the `setPosition` function
///
/// {@endtemplate}
mixin SetPositionFunction implements BaseControllerFunction {
  /// Sets the animationController position (without animation).
  /// The value must between 0.0 and 1.0
  set setPositionFunction(double value) {
    assert(isAttached, _message);
    assert(0.0 <= value && value <= 1.0);
    _stateMixin!.setPosition = value;
  }
}

/// {@template tkm_animate_to_position_function}
/// Mixin to implementing the `animateToPositionFunction` function
///
/// {@endtemplate}
mixin AnimateToPositionFunction implements BaseControllerFunction {
  /// Animates the widget position to the value.
  /// The value must between 0.0 and 1.0
  /// (optional) duration specifies the time for the animation to complete
  /// (optional) curve specifies the easing behavior of the animation.
  void animateToPositionFunction(
    double value, {
    Duration? duration,
    Curve curve = Curves.linear,
  }) {
    assert(isAttached, _message);
    assert(0.0 <= value && value <= 1.0);
    _stateMixin!.animateToPosition(value, duration: duration, curve: curve);
  }
}

const _message =
    'TKMController must be attached to a Widget with AnimationControllerMixin';
