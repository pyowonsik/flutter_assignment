import 'package:equatable/equatable.dart';

class FlutterAssignmentState extends Equatable {
  final List<int> numbers;
  final bool isDragging;

  const FlutterAssignmentState({
    required this.numbers,
    required this.isDragging,
  });

  FlutterAssignmentState copyWith({
    List<int>? numbers,
    bool? isDragging,
  }) {
    return FlutterAssignmentState(
        numbers: numbers ?? this.numbers,
        isDragging: isDragging ?? this.isDragging);
  }

  @override
  List<Object> get props => [numbers, isDragging];
}
