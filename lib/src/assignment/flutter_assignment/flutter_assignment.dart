import 'dart:math';
import 'package:flutter/material.dart';

// 과제 1.
// 1. 초기에 10개의 랜덤한 숫자를 생성해 card 형태로 보여준다.
// 2. 각 카드를 클릭하면 해당 숫자 값이 증가한다.
// 3. 카드의 위치는 drag and drop을 통해 변경이 가능하다.
// 4. 카드 상단에 삭제 버튼을 통해 카드를 제거할 수 있다.
// 5. 카드 추가 버튼을 통해 새로운 숫자 카드를 추가할 수 있다. 추가 시 카드 리스트의 최하단에 추가한다.

// git - pyowonsik branch에서 작업 하고 기능 단위 커밋 -> origin pyowonsik push -> github에서 PR 후 Merge 하기

// draggable target 분류
// !(_isDragging) = true라 드래깅 가능 ,
// 드래깅이 끝나는 순간 부터 false가 되어 target위젯
// 다시 드래깅 true가 되면서 draggable 위젯
// ui 는 깔아두고 index 부분만 _isDragging 상태에따라 바꿔줌

class FlutterAssignment extends StatefulWidget {
  const FlutterAssignment({Key? key}) : super(key: key);

  @override
  _FlutterAssignment createState() => _FlutterAssignment();
}

Random randomSeed = Random();

class _FlutterAssignment extends State<FlutterAssignment> {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  bool _isDragging = false;
  int draggableNumber = 0;
  int draggableIndex = 0;
  int targetNumber = 0;
  int currentNumber = 0;

  @override
  void initState() {
    super.initState();
    // for (var i = 0; i < 10; i++) {
    //   numbers.add(randomSeed.nextInt(100) + 1);
    // }
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
                            // todo : 내려가는동안 한칸씩 위로 올려야함 값을 바꿔주는 것이 아님
                            onMove: (detail) {
                              // print('draggableNumber : $draggableNumber');
                              // print('draggableIndex : $draggableIndex');
                              // print(
                              //     'thisNumber : ' + numbers[index].toString());
                              // print('thisIndex : ' + index.toString());

                              setState(() {
                                if (draggableIndex == index) {
                                  // print('변화 없음');
                                }
                                if (draggableIndex < index) {
                                  // print('변화 필요');
                                  draggableIndex++;
                                  // print(draggableIndex);
                                  targetNumber = numbers[index];
                                  numbers[index - 1] = numbers[index];
                                  numbers[index] = targetNumber;
                                  print(numbers[index]);
                                  numbers[index] = draggableNumber;

                                  // if (index == numbers.length - 1) {
                                  //   print('변화 필요');
                                  //   print(draggableNumber);
                                  //   print(numbers[index]);
                                  //   numbers[index] = draggableIndex;
                                  // }
                                  // print(index);
                                  // print(numbers[index]);
                                  // print(index);
                                  // print(numbers[index]);
                                }
                                if (draggableIndex > index) {
                                  draggableIndex--;
                                  // print(draggableIndex);
                                  targetNumber = numbers[index];
                                  numbers[index + 1] = numbers[index];
                                  numbers[index] = targetNumber;
                                  numbers[index] = draggableNumber;
                                }
                              });
                            },

                            onAccept: (int data) {
                              setState(() {
                                // targetNumber = numbers[index];
                                // print('targetNumber : $targetNumber');
                                // print('targetIndex : $data');
                                // numbers[data] = targetNumber;
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
