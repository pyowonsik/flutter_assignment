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

  @override
  Widget build(BuildContext context) {
    return Row(children: [
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
          return Container(
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
