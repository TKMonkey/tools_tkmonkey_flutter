import 'package:flutter/material.dart';
import 'tkm_controller_mixin.dart';

/// {@template tkm_controller}
///
/// Class to create a controller to handle some encapsulated custom animation widget
/// With this class, the custom widget has a way to handle some behavior for animationController
/// without exposing the animationController to public
///
/// The basic use is `extends` this class to your custom controller
/// This class need the custom widget implements the `Mixin` [AnimationControllerMixin]
/// After that in the `initState` method from `StatefulWidget` call the `addState`
/// to attached the state to the controller
///
/// {@endtemplate}
abstract class TKMController<S extends TKMControllerMixin> {
  S? _stateMixin;

  /// Attached the state to this controller
  set addState(S state) {
    _stateMixin = state;
  }

  /// Determine if the state with AnimationControllerMixin is attached to an instance
  bool get isAttached => _stateMixin != null;

  /// Start animation to close
  /// Clossed is animationController.value == 1.0
  void close() {
    assert(isAttached, _message);
    _stateMixin!.open();
  }

  /// Start animation to close
  /// Clossed is animationController.value == 0.0
  void open() {
    assert(isAttached, _message);
    _stateMixin!.open();
  }

  /// Run animation and decide if execute open or close
  void start() {
    assert(isAttached, _message);
    _stateMixin!.start();
  }

  /// Returns whether or not the animation is 'open'.
  /// Clossed is animationController.value == 1.0
  bool get isOpen {
    assert(isAttached, _message);
    return _stateMixin!.isAnimationOpen;
  }

  /// Returns whether or not the panel is 'closed'.
  /// Clossed is animationController.value == 0.0
  bool get isClosed {
    assert(isAttached, _message);
    return _stateMixin!.isAnimationClosed;
  }

  /// Gets the current animationController position.
  /// Decimal between 0.0 and 1.0
  double get getPosition {
    assert(isAttached, _message);
    return _stateMixin!.getPosition;
  }

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
    _stateMixin!.animateToPosition(value, duration: duration, curve: curve);
  }

  /// Sets the animationController position (without animation).
  /// The value must between 0.0 and 1.0
  set setPosition(double value) {
    assert(isAttached, _message);
    assert(0.0 <= value && value <= 1.0);
    _stateMixin!.setPosition = value;
  }

  static const _message =
      'TKMController must be attached to a Widget with AnimationControllerMixin';
}
