import 'package:equatable/equatable.dart';

class FlutterAssignmentState extends Equatable {
  final List<int> numbers;
  final bool isDragging;
  final int dragNumber;
  final int dragIndex;

  const FlutterAssignmentState({
    required this.numbers,
    required this.isDragging,
    required this.dragNumber,
    required this.dragIndex,
  });

  FlutterAssignmentState copyWith({
    List<int>? numbers,
    bool? isDragging,
    int? dragNumber,
    int? dragIndex,
  }) {
    return FlutterAssignmentState(
      numbers: numbers ?? this.numbers,
      isDragging: isDragging ?? this.isDragging,
      dragNumber: dragNumber ?? this.dragNumber,
      dragIndex: dragIndex ?? this.dragIndex,
    );
  }

  @override
  List<Object> get props => [numbers, isDragging, dragNumber, dragIndex];
}
