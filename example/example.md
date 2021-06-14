## DragHelper

Basic Use:
```dart
TKMDragHelper(
  animationController: animationController,
  maxSlide: 255,
  maxDragStartEdge: MediaQuery.of(context).size.width - 255,
  minDragStartEdge: 60,
  dissableDrag: true,
  orientation: DragOrientation.RigthtToLeft
);
 ```

 After define the `TKMDragHelper`
 ```dart
GestureDetector(
  onHorizontalDragStart: dragHelper.onDragStart,
  onHorizontalDragUpdate: dragHelper.onDragUpdate,
  onHorizontalDragEnd: dragHelper.onDragEnd,
  child: ...,
);
```


## TKMController

Basic Use:

Wrap the mixin functions in the CustomController functions
```dart
class CustomController extends TKMController with ForwardFunction, ReverseFunction {
  
  void close() => reverseFunction();

  void open() {
    print('Show me a custom open print');  
    forwardFunction();
  }
}
 ```

 After define the `CustomController`
 Initialize animationController from `Mixin` and attached the state

 ```dart
class _CustomState extends State<CustomWidget>
    with SingleTickerProviderStateMixin, AnimationControllerMixin {
  @override
    void initState() {
      super.initState();

      animationController = AnimationController(
        vsync: this,
        duration: settings.duration,
      );

      widget.controller?.addState = this;
    }
}
```