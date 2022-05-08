part of 'bloc.dart';

@immutable
abstract class CreateTaskEvent extends Equatable {}

class CreateTaskStarted extends CreateTaskEvent {
  TaskModel task;
  CreateTaskStarted(this.task);
  @override
  List<Object> get props => [];
}

class UpdateTaskStarted extends CreateTaskEvent {
  TaskModel task;
  UpdateTaskStarted(this.task);
  @override
  List<Object> get props => [];
}
