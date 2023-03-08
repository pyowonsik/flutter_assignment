import 'package:equatable/equatable.dart';

abstract class FlutterAssignmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddIndexEvent extends FlutterAssignmentEvent {
  @override
  List<Object> get props => [];
}

class RemoveIndexEvent extends FlutterAssignmentEvent {
  final int index;
  RemoveIndexEvent({required this.index});
  @override
  List<Object> get props => [index];
}
