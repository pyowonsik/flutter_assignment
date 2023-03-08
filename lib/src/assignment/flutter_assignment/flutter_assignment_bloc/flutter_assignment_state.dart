import 'package:equatable/equatable.dart';

class FlutterAssignmentState extends Equatable {
  final List<int> numbers;

  const FlutterAssignmentState({
    required this.numbers,
  });

  FlutterAssignmentState copyWith({
    List<int>? numbers,
  }) {
    return FlutterAssignmentState(numbers: numbers ?? this.numbers);
  }

  @override
  List<Object> get props => [numbers];
}
