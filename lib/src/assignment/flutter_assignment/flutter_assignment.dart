import 'dart:math';

import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/data/draggable_lists.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/model/draggabl_list.dart';

// 과제 1.
// 1. 초기에 10개의 랜덤한 숫자를 생성해 card 형태로 보여준다.
// 2. 각 카드를 클릭하면 해당 숫자 값이 증가한다.
// 3. 카드의 위치는 drag and drop을 통해 변경이 가능하다.
// 4. 카드 상단에 삭제 버튼을 통해 카드를 제거할 수 있다.
// 5. 카드 추가 버튼을 통해 새로운 숫자 카드를 추가할 수 있다. 추가 시 카드 리스트의 최하단에 추가한다.

// git - pyowonsik branch에서 작업 하고 기능 단위 커밋 -> origin pyowonsik push -> github에서 PR 후 Merge 하기

import 'package:flutter/material.dart';

void main() => runApp(const ReorderableApp());

class ReorderableApp extends StatelessWidget {
  const ReorderableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ReorderableListView Sample')),
        body: const ReorderableExample(),
      ),
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ReorderableExample> {
  final List<int> _items = List<int>.generate(10, (int index) => index);

  List<int> arrNum = [];
  var randNum;

  // 화면 변화할때 사용.
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      arrNum.add(Random().nextInt(100) + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                randNum = Random().nextInt(100) + 1;
                arrNum.add(randNum);
              });
            },
            child: Text('추가')),
        SizedBox(
          height: 30,
        ),
        Expanded(
            child: ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          children: [
            for (int index = 0; index < arrNum.length; index += 1)
              ListTile(
                onTap: () {
                  setState(() {
                    arrNum[index]++;
                  });
                },
                key: Key('$index'),
                tileColor: arrNum[index].isOdd ? oddItemColor : evenItemColor,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${arrNum[index]}'),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              arrNum.remove(arrNum[index]);
                            });
                          },
                          child: Text('삭제')),
                    ]),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final int item = arrNum.removeAt(oldIndex);
              arrNum.insert(newIndex, item);
            });
          },
        )),
      ],
    ));
  }
}



















// class MainPage extends StatefulWidget {
//   const MainPage({super.key});
//   @override
//   _MainPage createState() => _MainPage();
// }

// class _MainPage extends State<MainPage> {
//   List<int> arrNum = [];
//   List<DragAndDropList> _contents = [];

//   @override
//   void initState() {
//     super.initState();

//     for (var i = 0; i < 10; i++) {
//       arrNum.add(Random().nextInt(100) + 1);
//     }

//     // Generate a list
//     _contents = List.generate(10, (index) {
//       return DragAndDropList(
//         children: <DragAndDropItem>[
//           DragAndDropItem(
//             child: InkWell(
//               onTap: (){
//                 setState(() {
//                    arrNum[index] += 1;
//                    print(arrNum[index]);
//                 });
//                },
//               child: SizedBox(
//                 height: 100,
//                 child: Row(
//                   children: [
//                     Card(
//                       child: Text(arrNum[index].toString()),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 setState(() {});
//               },
//               child: Text('추가')),
//           Expanded(
//             child: DragAndDropLists(

//             children: _contents,
//             // listDragHandle: buildDragHandle(isList: true),
//             itemDragHandle: buildDragHandle(),
//             onItemReorder: _onItemReorder,
//             onListReorder: _onListReorder,
//           )),
//         ],
//       ),
//     );
//   }

//   DragHandle buildDragHandle({bool isList = false}) {
//     final verticalAlignment = isList
//         ? DragHandleVerticalAlignment.top
//         : DragHandleVerticalAlignment.center;
//     final color = isList ? Colors.blueGrey : Colors.black26;

//     return DragHandle(
//       verticalAlignment: verticalAlignment,
//       child: Row(children: [
//         ElevatedButton(onPressed: () {}, child: Text('삭제')),
//         Icon(Icons.menu, color: color),
//       ]),
//     );
//   }

//   _onItemReorder(
//       int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
//     setState(() {
//       var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
//       _contents[newListIndex].children.insert(newItemIndex, movedItem);
//     });
//   }

//   _onListReorder(int oldListIndex, int newListIndex) {
//     setState(() {
//       var movedList = _contents.removeAt(oldListIndex);
//       _contents.insert(newListIndex, movedList);
//     });
//   }
// }

// class FlutterAssignment extends StatefulWidget {
//   const FlutterAssignment({Key? key}) : super(key: key);

//   @override
//   _FlutterAssignment createState() => _FlutterAssignment();
// }

// class _FlutterAssignment extends State<FlutterAssignment> {
//   List<int> arrNum = [];
//   var randNum;

//   // 화면 변화할때 사용.
//   void initState() {
//     super.initState();
//     for (var i = 0; i < 10; i++) {
//       arrNum.add(Random().nextInt(100) + 1);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   randNum = Random().nextInt(100) + 1;
//                   arrNum.add(randNum);
//                 });
//               },
//               child: Text('추가')),
//         ],
//       ),
//       Expanded(
//           child: ListView.builder(
//               itemCount: arrNum.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                           child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             arrNum[index] += 1;
//                           });
//                         },
//                         child: SizedBox(
//                           height: 100,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 arrNum[index].toString(),
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )),
//                       ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               arrNum.remove(arrNum[index]);
//                             });
//                           },
//                           child: Text('삭제')),
//                     ]);
//               })),
//     ]));
//   }
// }
