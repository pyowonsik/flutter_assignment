import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_event.dart';
import 'package:flutter_assignment/src/assignment/flutter_assignment/flutter_assignment_bloc/flutter_assignment_state.dart';

class FlutterAssignmentBloc
    extends Bloc<FlutterAssignmentEvent, FlutterAssignmentState> {
  FlutterAssignmentBloc() : super(const FlutterAssignmentState(numbers: [])) {
    Random randomSeed = Random();

    on<AddIndexEvent>(
      (AddIndexEvent event, emit) {
        int randomNumber = randomSeed.nextInt(100) + 1;
        return emit(state.copyWith(
            numbers: List.from(state.numbers)..add(randomNumber)));
      },
    );

    on<RemoveIndexEvent>(
      (RemoveIndexEvent event, emit) {
        return emit(state.copyWith(
            numbers: List.from(state.numbers)..removeAt(event.index)));
      },
    );
  }
}
