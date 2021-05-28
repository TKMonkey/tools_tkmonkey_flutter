import 'package:flutter/material.dart';

import 'drag_orientation.dart';

class DragUtils {
  DragUtils({
    required this.animationController,
    required this.maxSlide,
    required this.maxDragStartEdge,
    required this.minDragStartEdge,
    required this.orientation,
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

  ///This argument is to indicate the direction of start to end
  final DragOrientation orientation;

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

  bool get animationStatusBySideLeft =>
      orientation == DragOrientation.LeftToRight
          ? animationController.isDismissed
          : animationController.isCompleted;

  bool get animationStatusBySideRight =>
      orientation == DragOrientation.LeftToRight
          ? animationController.isCompleted
          : animationController.isDismissed;

  void close() => animationController.reverse();

  void open() => animationController.forward();

  double get delta => orientation == DragOrientation.LeftToRight ? 1.0 : -1.0;
}
