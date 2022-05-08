
part of 'bloc.dart';



@immutable
abstract class TaskListState extends Equatable{}

class TaskListLoadInProgress extends TaskListState {
  @override
  List<Object> get props => [];
}

class TaskListLoadSuccess extends TaskListState {
  TaskListLoadSuccess(this.tasks);

  List<TaskModel> tasks;
@override
  List<Object> get props => [tasks];
  
}

class TaskListLoadFailure extends TaskListState {
  @override
  List<Object> get props => [];
}