import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_event.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_state.dart';

class FlutterAssignmentBloc
    extends Bloc<FlutterAssignmentEvent, FlutterAssignmentState> {
  FlutterAssignmentBloc()
      : super(const FlutterAssignmentState(numbers: [], isDragging: false)) {
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
    on<DraggingEvent>(
      (event, emit) {
        print(state.isDragging);
        return (state.isDragging)
            ? emit(state.copyWith(isDragging: false))
            : emit(state.copyWith(isDragging: true));
      },
    );
  }
}
