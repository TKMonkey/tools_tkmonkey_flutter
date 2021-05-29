## DragHelper

Basic Use:
```dart
DragUtils(
    animationController: animationController,
    maxSlide: 255,
    maxDragStartEdge: MediaQuery.of(context).size.width - 255,
    minDragStartEdge: 60,
    dissableDrag: true,
    orientation: DragOrientation.RigthtToLeft
  );
 ```

 After define the `DragUtils`
 ```dart
GestureDetector(
  onHorizontalDragStart: dragUtils.onDragStart,
  onHorizontalDragUpdate: dragUtils.onDragUpdate,
  onHorizontalDragEnd: dragUtils.onDragEnd,
  child: ...,
);
```