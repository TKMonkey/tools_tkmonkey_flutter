import 'package:flutter/material.dart';

import 'drag_direction.dart';

/// {@template tkm_drag_helper}
/// Class to create a drag helper.
/// This class use flags to manipulate the drag in Widgets
///
/// The most important is define the [DragDirection] to understand the drag direction
/// in the widget (Where start and end)
///
/// ```dart
/// TKMDragHelper(
///   animationController: animationController,
///   maxSlide: 255,
///   maxDragStartEdge: MediaQuery.of(context).size.width - 255,
///   minDragStartEdge: 60,
///   dissableDrag: true,
///   orientation: DragOrientation.RigthtToLeft
/// );
/// ```
///
/// After define DragUtils use a `GestureDectector` to override
///  - onHorizontalDragStart: dragUtils.onDragStart,
///  - onHorizontalDragUpdate: dragUtils.onDragUpdate,
///  - onHorizontalDragEnd: dragUtils.onDragEnd,
///
/// {@endtemplate}

class TKMDragHelper {
  TKMDragHelper({
    required this.animationController,
    required this.maxSlide,
    required this.maxDragStartEdge,
    required this.minDragStartEdge,
    required this.direction,
    this.dissableDrag = false,
  });

  /// Maximum slide in the widget or screen
  final double maxSlide;

  /// Edge minimum to start the drag
  final double minDragStartEdge;

  /// Edge maximum to start the drag
  final double maxDragStartEdge;

  /// Animation controller to link animation with the drag
  final AnimationController animationController;

  /// If the user want to disable drag in some cases
  final bool dissableDrag;

  ///This argument is to indicate the drag direction where start tand end
  final DragDirection direction;

  /// Flag to indicate is possible to drag the widget
  bool canBeDragged = false;

  /// When drag is start, evaluate if limit and edge is true with animationStatus
  void onDragStart(DragStartDetails details) {
    if (dissableDrag) return;

    final bool dragStartFromLeft = animationStatusBySideLeft &&
        details.localPosition.dx < minDragStartEdge;

    final bool dragStartFromRight = animationStatusBySideRight &&
        details.localPosition.dx > maxDragStartEdge;

    canBeDragged = dragStartFromRight || dragStartFromLeft;
  }

  /// When drag is update, update the animationController value
  void onDragUpdate(DragUpdateDetails details) {
    if (dissableDrag) return;

    if (canBeDragged) {
      final double steps = (details.primaryDelta ?? 0) / maxSlide;
      animationController.value = animationController.value + delta * steps;
    }
  }

  /// When drag is end, if is necessary complete or dismiss the animation
  void onDragEnd(DragEndDetails details) {
    if (dissableDrag) return;

    if (animationController.isCompleted || animationController.isDismissed) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
      final double visualVelocity =
          details.velocity.pixelsPerSecond.dx / maxSlide;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  bool get animationStatusBySideLeft => direction == DragDirection.LeftToRight
      ? animationController.isDismissed
      : animationController.isCompleted;

  bool get animationStatusBySideRight => direction == DragDirection.LeftToRight
      ? animationController.isCompleted
      : animationController.isDismissed;

  void close() => animationController.reverse();

  void open() => animationController.forward();

  double get delta => direction == DragDirection.LeftToRight ? 1.0 : -1.0;
}
