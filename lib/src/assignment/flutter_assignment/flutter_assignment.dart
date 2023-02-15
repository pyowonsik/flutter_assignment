import 'dart:math';

// import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
// import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
// import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
// import 'package:draggable_fab/draggable_fab.dart';
// import 'package:flutter_assignment/src/assignment/flutter_assignment/data/draggable_lists.dart';
// import 'package:flutter_assignment/src/assignment/flutter_assignment/model/draggabl_list.dart';
import 'package:flutter/material.dart';

// 과제 1.
// 1. 초기에 10개의 랜덤한 숫자를 생성해 card 형태로 보여준다.
// 2. 각 카드를 클릭하면 해당 숫자 값이 증가한다.
// 3. 카드의 위치는 drag and drop을 통해 변경이 가능하다.
// 4. 카드 상단에 삭제 버튼을 통해 카드를 제거할 수 있다.
// 5. 카드 추가 버튼을 통해 새로운 숫자 카드를 추가할 수 있다. 추가 시 카드 리스트의 최하단에 추가한다.

// git - pyowonsik branch에서 작업 하고 기능 단위 커밋 -> origin pyowonsik push -> github에서 PR 후 Merge 하기

class FlutterAssignment extends StatefulWidget {
  const FlutterAssignment({Key? key}) : super(key: key);

  @override
  _FlutterAssignment createState() => _FlutterAssignment();
}

Random randomSeed = Random();

class _FlutterAssignment extends State<FlutterAssignment> {
  List<int> numbers = [];
  var changeNumber;
  var resultNumber = 0;

  var result = 0;

  // int? randNum;
  // 화면 변화할때 사용.
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      numbers.add(randomSeed.nextInt(100) + 1);
                    });
                  },
                  child: const Text('추가')),
            ],
          ),
          // feedback = cur index.toString
          // child = list
          // dragtarget = pre index.toString

          Expanded(
            child: ListView.builder(
                itemCount: numbers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      //

                      Draggable(
                        data: numbers[index],

                        //feedback
                        feedback: GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: SizedBox(
                            height: 100,
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
                                        onPressed: () {},
                                        child: const Text('삭제')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // child
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              numbers[index]++;
                            });
                          },
                          child: SizedBox(
                            height: 100,
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

                        // onDragStarted: () {
                        //   print(index);

                        //   // 드래그 타겟을 다른 리스트의 인덱스로 바꿔줌
                        //   DragTarget(
                        //     builder: (
                        //       BuildContext context,
                        //       List<dynamic> accepted,
                        //       List<dynamic> rejected,
                        //     ) {
                        //       return Container();
                        //     },
                        //     onAccept: (data) {
                        //       setState(() {
                        //         data:
                        //         result;
                        //       });
                        //     },
                        //   );
                        // },
                      ),

                      // Sample Target
                      DragTarget(
                        builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return SizedBox(
                            height: 100,
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      result.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        child: const Text('삭제')),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        onAccept: (int data) {
                          setState(() {
                            changeNumber = result;
                            result = numbers[index];
                            numbers[index] = changeNumber;
                          });
                        },
                      ),
                      // Sample Target
                    ],
                  );
                }),
          ),
          // Sample Target
          // DragTarget(
          //   builder: (
          //     BuildContext context,
          //     List<dynamic> accepted,
          //     List<dynamic> rejected,
          //   ) {
          //     return Container(
          //       height: 100.0,
          //       width: 100.0,
          //       color: Colors.cyan,
          //       child: Center(
          //         child: Text(
          //           'Re:  ${result}',
          //           style: TextStyle(fontSize: 20),
          //         ),
          //       ),
          //     );
          //   },
          //   onAccept: (int data) {
          //     setState(() {
          //       result = data;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}

// // Reorderable
// import 'package:flutter/material.dart';

// class FlutterAssignment extends StatefulWidget {
//   const FlutterAssignment({Key? key}) : super(key: key);

//   @override
//   _FlutterAssignment createState() => _FlutterAssignment();
// }

// Random randomSeed = Random();

// class _FlutterAssignment extends State<FlutterAssignment> {
//   // final List<int> _items = List<int>.generate(10, (int index) => index);
//   // int? randomNumber;
//   List<int> numbers = [];

//   // 화면 변화할때 사용.
//   @override
//   void initState() {
//     super.initState();
//     for (var i = 0; i < 10; i++) {
//       numbers.add(randomSeed.nextInt(100) + 1);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     // final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
//     // final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

//     return Scaffold(
//         body: Column(
//       children: [
//         const SizedBox(
//           height: 30,
//         ),
//         ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 // randomNumber = randomSeed.nextInt(100) + 1;
//                 numbers.add(randomSeed.nextInt(100) + 1);
//               });
//             },
//             child: const Text('추가')),
//         const SizedBox(
//           height: 30,
//         ),
//         Expanded(
//             child: ReorderableListView(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           children: [
//             for (int index = 0; index < numbers.length; index += 1)
//               ListTile(
//                 onTap: () {
//                   setState(() {
//                     numbers[index]++;
//                   });
//                 },
//                 key: Key('$index'),
//                 // tileColor: arrNum[index].isOdd ? oddItemColor : evenItemColor,
//                 title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('${numbers[index]}'),
//                       ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               numbers.remove(numbers[index]);
//                             });
//                           },
//                           child: const Text('삭제')),
//                     ]),
//                 trailing: const Icon(Icons.menu),
//               ),
//           ],
//           onReorder: (int oldIndex, int newIndex) {
//             setState(() {
//               if (oldIndex < newIndex) {
//                 newIndex -= 1;
//               }
//               // final int item = numbers.removeAt(oldIndex);
//               numbers.insert(newIndex, numbers.removeAt(oldIndex));
//             });
//           },
//         )),
//       ],
//     ));
//   }
// }
