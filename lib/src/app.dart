import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _indexOfDroppedItem = 0;
  bool _isDragging = false;
  // var number = 6;
  var result = [
    0,
    1,
    2,
    3,
    4,
    5,
  ];

  @override
  void _acceptDraggedItem(int index) {
    setState(() {
      _indexOfDroppedItem = index;
    });
  }

  void _setIsDragging() {
    setState(() {
      _isDragging = true;
    });
  }

  void _resetIsDragging() {
    setState(() {
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return Padding(
              padding: const EdgeInsets.all(44.0),
              child: index == _indexOfDroppedItem
                  ? Draggable<int>(
                      data: result[index],
                      childWhenDragging: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              // color: Colors.blue,
                              ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(result[index].toString()),
                      ),
                      onDragStarted: () {
                        _setIsDragging();
                      },
                      onDraggableCanceled: (_, __) {
                        _resetIsDragging();
                      },
                      onDragCompleted: () {
                        _resetIsDragging();
                      },
                      feedback: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          border: Border.all(
                              // color: Colors.blue,
                              ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(result[index].toString()),
                      ),
                    )
                  : DragTarget<int>(
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                // color: Colors.blue,
                                ),
                            borderRadius: BorderRadius.all(_isDragging
                                ? const Radius.circular(20)
                                : const Radius.circular(10)),
                          ),
                          child: Text(result[index].toString()),
                        );
                      },
                      onAccept: (int data) {
                        setState(() {
                          result[index] = data;
                        });
                      },
                    ),
            );
          }),
        ),
      ),
    );
  }
}
