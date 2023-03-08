import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

abstract class FlutterAssignmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddNumberEvent extends FlutterAssignmentEvent {
  final int index;
  AddNumberEvent({required this.index});
  @override
  List<Object> get props => [index];
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

class IsDraggingEvent extends FlutterAssignmentEvent {
  @override
  List<Object> get props => [];
}

class DragInfoEvent extends FlutterAssignmentEvent {
  final int index;
  DragInfoEvent({required this.index});

  @override
  List<Object> get props => [index];
}
