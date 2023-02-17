import 'dart:math';
import 'package:flutter/material.dart';

class FlutterAssignment extends StatefulWidget {
  const FlutterAssignment({Key? key}) : super(key: key);

  @override
  _FlutterAssignment createState() => _FlutterAssignment();
}

Random randomSeed = Random();

class _FlutterAssignment extends State<FlutterAssignment> {
  List<int> numbers = [];
  bool _isDragging = false;
  int draggableNumber = 0;
  int draggableIndex = 0;
  int targetNumber = 0;
  int currentNumber = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      numbers.add(randomSeed.nextInt(100) + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        numbers.add(randomSeed.nextInt(100) + 1);
                      });
                    },
                    child: const Text('추가')),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: numbers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return !(_isDragging)
                        ? Draggable(
                            data: index,
                            onDragStarted: () {
                              draggableNumber = numbers[index];
                              draggableIndex = index;

                              setState(() {
                                _isDragging = true;
                              });
                            },
                            onDraggableCanceled: (_, __) {
                              setState(() {
                                _isDragging = false;
                              });
                            },
                            onDragCompleted: () {
                              setState(() {
                                _isDragging = false;
                              });
                            },
                            feedback: Material(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      numbers[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('삭제')),
                                  ],
                                ),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  numbers[index]++;
                                });
                              },
                              child: SizedBox(
                                height: 50,
                                child: Card(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          numbers[index].toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                numbers.remove(numbers[index]);
                                              });
                                            },
                                            child: const Text('삭제')),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : DragTarget(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return SizedBox(
                                height: 50,
                                child: Card(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          numbers[index].toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                numbers.remove(numbers[index]);
                                              });
                                            },
                                            child: const Text('삭제')),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },

                            onMove: (detail) {
                              setState(() {
                                if (draggableIndex < index) {
                                  draggableIndex++;

                                  targetNumber = numbers[index];
                                  numbers[index - 1] = numbers[index];
                                  numbers[index] = targetNumber;

                                  numbers[index] = draggableNumber;
                                }
                                if (draggableIndex > index) {
                                  draggableIndex--;
                                  targetNumber = numbers[index];
                                  numbers[index + 1] = numbers[index];
                                  numbers[index] = targetNumber;
                                  numbers[index] = draggableNumber;
                                }
                              });
                            },

                            onAccept: (int data) {
                              setState(() {
                                numbers[index] = draggableNumber;
                              });
                            },

                            //
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
