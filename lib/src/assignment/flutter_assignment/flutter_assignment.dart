import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_bloc.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_event.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class FlutterAssignment extends StatefulWidget {
//   const FlutterAssignment({Key? key}) : super(key: key);

//   @override
//   _FlutterAssignment createState() => _FlutterAssignment();
// }

// Random randomSeed = Random();

// class _FlutterAssignment extends State<FlutterAssignment> {
//   List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
//   bool _isDragging = false;
//   int dragNumber = 0;
//   int dragIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     // for (var i = 0; i < 10; i++) {
//     //   numbers.add(randomSeed.nextInt(100) + 1);
//     // }
//   }

//   bool isDragDown(int index) {
//     if (dragIndex < index) return true;
//     return false;
//   }

//   bool isDragUp(int index) {
//     if (dragIndex > index) return true;
//     return false;
//   }

//   void insertOldNumber(int index) {
//     if (isDragDown(index)) {
//       dragIndex++;
//       // numbers[index - 1] = numbers[index];
//       // numbers[index] = dragNumber;
//       numbers.insert(index, numbers.removeAt(index - 1));
//     }
//     if (isDragUp(index)) {
//       dragIndex--;
//       // numbers[index + 1] = numbers[index];
//       // numbers[index] = dragNumber;
//       numbers.insert(index, numbers.removeAt(index + 1));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         numbers.add(randomSeed.nextInt(100) + 1);
//                       });
//                     },
//                     child: const Text('추가')),
//               ],
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: numbers.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Draggable(
//                       data: index,
//                       onDragStarted: () {
//                         dragNumber = numbers[index];
//                         dragIndex = index;

//                         setState(() {
//                           _isDragging = true;
//                         });
//                       },
//                       onDraggableCanceled: (_, __) {
//                         setState(() {
//                           _isDragging = false;
//                         });
//                       },
//                       onDragCompleted: () {
//                         setState(() {
//                           _isDragging = false;
//                         });
//                       },
//                       feedback: Material(
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                               maxWidth: MediaQuery.of(context).size.width),
//                           child: SizedBox(
//                             height: 50,
//                             child: Card(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       numbers[index].toString(),
//                                       style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     ElevatedButton(
//                                         onPressed: () {
//                                           setState(() {});
//                                         },
//                                         child: const Text('삭제')),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               numbers[index]++;
//                             });
//                           },
//                           child: DragTarget(
//                             builder: (
//                               BuildContext context,
//                               List<dynamic> accepted,
//                               List<dynamic> rejected,
//                             ) {
//                               return SizedBox(
//                                 height: 50,
//                                 child: Card(
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           numbers[index].toString(),
//                                           style: const TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         ElevatedButton(
//                                             onPressed: () {
//                                               setState(() {
//                                                 numbers.remove(numbers[index]);
//                                               });
//                                             },
//                                             child: const Text('삭제')),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             onMove: (detail) {
//                               setState(() {
//                                 if (_isDragging) insertOldNumber(index);
//                               });
//                             },
//                           )),
//                     );
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class FlutterAssignment extends StatelessWidget {
  const FlutterAssignment({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              context.read<FlutterAssignmentBloc>().add(AddIndexEvent());
            },
            child: const Text('추가')),
        const SizedBox(height: 30),
        BlocBuilder<FlutterAssignmentBloc, FlutterAssignmentState>(
          builder: (context, state) {
            return Expanded(
                child: ListView.builder(
              itemCount: state.numbers.length,
              itemBuilder: (BuildContext context, int index) {
                return Draggable(
                    onDragStarted: () {
                      // dragNumber = numbers[index];
                      // dragIndex = index;
                      context
                          .read<FlutterAssignmentBloc>()
                          .add(DraggingEvent());
                    },
                    onDraggableCanceled: (_, __) {
                      context
                          .read<FlutterAssignmentBloc>()
                          .add(DraggingEvent());
                    },
                    onDragCompleted: () {
                      context
                          .read<FlutterAssignmentBloc>()
                          .add(DraggingEvent());
                    },
                    feedback: Material(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.numbers[index].toString(),
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
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<FlutterAssignmentBloc>()
                            .add(AddNumberEvent(index: index));
                      },
                      child: DragTarget(
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
                                        state.numbers[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<FlutterAssignmentBloc>()
                                                .add(RemoveIndexEvent(
                                                    index: index));
                                          },
                                          child: const Text('삭제')),
                                    ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ));
              },
            ));
          },
        ),
      ],
    );
  }
}
