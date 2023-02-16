import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  const DraggableWidget({Key? key}) : super(key: key);

  @override
  _DraggableWidget createState() => _DraggableWidget();
}

class _DraggableWidget extends State<DraggableWidget> {
  @override
  void initState() {
    super.initState();
  }

  var result = 0;
  List<int> numbers = [1, 2, 3, 4, 5];
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //

      for (var i = 0; i < numbers.length; i++)
        Draggable(
          // Data is the value this Draggable stores.
          data: numbers[i],
          feedback: Container(
            color: Colors.blue,
            height: 100,
            width: 100,
            child: const Icon(Icons.directions_run),
          ),

          child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.lightGreenAccent,
            child: Center(
              child: Text(
                numbers[i].toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

          onDragStarted: () {
            _isDragging = true;
            print('dragg start ' + _isDragging.toString());
          },
          onDragEnd: (details) {
            _isDragging = false;
            print('dragg end ' + _isDragging.toString());
          },
        ),

      //

      const Spacer(),

      //

      DragTarget(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return (_isDragging)
              ? Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                )
              : Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text(
                      'Re:  ${result}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
        },
        onAccept: (int data) {
          print('test');
          setState(() {
            result = data;
          });
        },
      ),

      //
    ]);
  }
}

// class ScrollableDraggable extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _ScrollingDragger();
// }

// class _ScrollingDragger extends State<ScrollableDraggable> {
//   final _listViewKey = GlobalKey();
//   final ScrollController _scroller = ScrollController();
//   bool _isDragging = false;

//   @override
//   void dispose() {
//     _scroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Scrollable Draggable sample"),
//         ),
//         body: _createContents(),
//       ),
//     );
//   }

//   Widget _createContents() {
//     final itemCount = 20;
//     final listView = ListView.builder(
//       key: _listViewKey,
//       controller: _scroller,
//       itemCount: itemCount + 1,
//       itemBuilder: (context, index) {
//         final data = ListTile(title: Text("data-$index"));

//         final draggable = Draggable(
//           child: _decorate(data),
//           feedback: Material(
//             child: ConstrainedBox(
//               constraints:
//                   BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
//               child: _decorate(data, color: Colors.red),
//             ),
//           ),
//           onDragStarted: () => _isDragging = true,
//           onDragEnd: (details) => _isDragging = false,
//           onDraggableCanceled: (velocity, offset) => _isDragging = false,
//         );

//         if (index != itemCount) {
//           return draggable;
//         }
//         return const SizedBox(height: 250);
//       },
//     );

//     return _createListener(listView);
//   }

//   Widget _createListener(Widget child) {
//     return Listener(
//       child: child,
//       onPointerMove: (PointerMoveEvent event) {
//         print("x: ${event.position.dx}, y: ${event.position.dy}");

//         if (!_isDragging) {
//           return;
//         }
//         RenderBox render =
//             _listViewKey.currentContext?.findRenderObject() as RenderBox;
//         Offset position = render.localToGlobal(Offset.zero);
//         double topY = position.dy;
//         double bottomY = topY + render.size.height;

//         print("x: ${position.dy}, "
//             "y: ${position.dy}, "
//             "height: ${render.size.width}, "
//             "width: ${render.size.height}");

//         const detectedRange = 100;
//         const moveDistance = 3;

//         if (event.position.dy < topY + detectedRange) {
//           var to = _scroller.offset - moveDistance;
//           to = (to < 0) ? 0 : to;
//           _scroller.jumpTo(to);
//         }
//         if (event.position.dy > bottomY - detectedRange) {
//           _scroller.jumpTo(_scroller.offset + moveDistance);
//         }
//       },
//     );
//   }

//   Widget _decorate(Widget child, {Color color = Colors.black}) {
//     return Container(
//       child: child,
//       decoration: BoxDecoration(border: Border.all(color: color, width: 1)),
//     );
//   }
// }
