part of 'bloc.dart';

@immutable
abstract class TaskListEvent extends Equatable {}

class TaskFetchStarted extends TaskListEvent {
  @override
  List<Object> get props => [];
}

class DidUpdateListEvent extends TaskListEvent {
   List<TaskModel> tasks;
   DidUpdateListEvent(this.tasks);
  @override
  List<Object> get props => [];
}

