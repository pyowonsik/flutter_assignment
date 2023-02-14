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

class FlutterAssignment extends StatefulWidget {
  const FlutterAssignment({Key? key}) : super(key: key);

  @override
  _FlutterAssignment createState() => _FlutterAssignment();
}

class _FlutterAssignment extends State<FlutterAssignment> {
  
  
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
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    randNum = Random().nextInt(100) + 1;
                    arrNum.add(randNum);
                  });
                },
                child: Text('추가')),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: arrNum.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            arrNum[index] += 1;
                          });
                        },
                        child: SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  child: Text(
                                    arrNum[index].toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            arrNum.remove(arrNum[index]);
                          });
                        },
                        child: Text('삭제')),
                  ],
                );
              }),
        ),
      ],
    ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();

    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.fromARGB(255, 243, 242, 248);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
      ),
      body: DragAndDropLists(
        // lastItemTargetHeight: 50,
        // addLastItemTargetHeightToTop: true,
        // lastListTargetSize: 30,
        listPadding: EdgeInsets.all(16),
        listInnerDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        children: lists,
        itemDivider: Divider(thickness: 2, height: 2, color: backgroundColor),
        itemDecorationWhileDragging: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        listDragHandle: buildDragHandle(isList: true),
        itemDragHandle: buildDragHandle(),
        onItemReorder: onReorderListItem,
        onListReorder: onReorderList,
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
        header: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            list.header,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        children: list.items
            .map((item) => DragAndDropItem(
                  child: ListTile(
                    leading: Image.network(
                      item.urlImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.title),
                  ),
                ))
            .toList(),
      );

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}
