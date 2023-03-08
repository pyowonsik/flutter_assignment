import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_event.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_state.dart';

class FlutterAssignmentBloc
    extends Bloc<FlutterAssignmentEvent, FlutterAssignmentState> {
  FlutterAssignmentBloc()
      : super(const FlutterAssignmentState(
            numbers: [], isDragging: false, dragNumber: 0, dragIndex: 0)) {
    Random randomSeed = Random();

    on<AddNumberEvent>(
      (event, emit) {
        List<int> copyNumbers = [...state.numbers];
        copyNumbers[event.index]++;
        emit(state.copyWith(numbers: copyNumbers));
      },
    );

    on<AddIndexEvent>(
      (AddIndexEvent event, emit) {
        return emit(
          state.copyWith(
              numbers: [...state.numbers, randomSeed.nextInt(100) + 1]),
          // List.from(state.numbers)
          //   ..add(randomSeed.nextInt(100) + 1)
        );
      },
    );

    on<RemoveIndexEvent>(
      (RemoveIndexEvent event, emit) {
        // return emit(
        //   state.copyWith(
        //     numbers: state.numbers
        //         .whereIndexed((index, element) => index != event.index)
        //         .toList(),
        //   ),
        // );

        return emit(
          state.copyWith(
            numbers: List.from(state.numbers)..removeAt(event.index),
          ),
        );
      },
    );

    on<IsDraggingEvent>((IsDraggingEvent event, emit) =>
        emit(state.copyWith(isDragging: true)));
    on<IsNotDraggingEvent>((IsNotDraggingEvent event, emit) =>
        emit(state.copyWith(isDragging: false)));

    on<DragInfoEvent>(
      (DragInfoEvent event, emit) {
        // print('Dragg Number : ${state.numbers[event.index]}');
        // print('Dragg Index : ${event.index}');
        emit(
          state.copyWith(
            dragNumber: state.numbers[event.index],
            dragIndex: event.index,
          ),
        );
      },
    );

    on<DragEvent>(
      (DragEvent event, emit) {
        // print('현재 Number : ${state.numbers[event.index]}');
        // print('현재 Index : ${event.index}');
        List<int> copyNumbers = [...state.numbers];
        int copyIndex = state.dragIndex;

        if (isDragDown(event.index)) {
          copyIndex++;
          copyNumbers.insert(
              event.index, copyNumbers.removeAt(event.index - 1));
          emit(
            state.copyWith(dragIndex: copyIndex, numbers: copyNumbers),
          );
        }

        if (isDragUp(event.index)) {
          copyIndex--;
          copyNumbers.insert(
              event.index, copyNumbers.removeAt(event.index + 1));
          emit(
            state.copyWith(dragIndex: copyIndex, numbers: copyNumbers),
          );
        }
      },
    );
  }

  bool isDragDown(int index) {
    if (state.dragIndex < index) return true;
    return false;
  }

  bool isDragUp(int index) {
    if (state.dragIndex > index) return true;
    return false;
  }
}
