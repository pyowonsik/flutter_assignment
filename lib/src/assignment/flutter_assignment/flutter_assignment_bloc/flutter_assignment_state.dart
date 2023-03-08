import 'package:equatable/equatable.dart';

class FlutterAssignmentState extends Equatable {
  final List<int> numbers;
  final bool isDragging;
  final int dragNumber;
  final int dragIndex;
  // final bool isDown;
  // final bool isUp;

  const FlutterAssignmentState({
    required this.numbers,
    required this.isDragging,
    required this.dragNumber,
    required this.dragIndex,
    // required this.isDown,
    // required this.isUp,
  });

  FlutterAssignmentState copyWith({
    List<int>? numbers,
    bool? isDragging,
    int? dragNumber,
    int? dragIndex,
    // bool? isDown,
    // bool? isUp,
  }) {
    return FlutterAssignmentState(
      numbers: numbers ?? this.numbers,
      isDragging: isDragging ?? this.isDragging,
      dragNumber: dragNumber ?? this.dragNumber,
      dragIndex: dragIndex ?? this.dragIndex,
      // isDown: isDown ?? this.isDown,
      // isUp: isUp ?? this.isUp,
    );
  }

  @override
  List<Object> get props => [numbers, isDragging, dragNumber, dragIndex];
}
