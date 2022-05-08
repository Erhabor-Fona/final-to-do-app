part of 'bloc.dart';

@immutable
abstract class CreateTaskState extends Equatable {}

class CreateTaskInProgress extends CreateTaskState {
  @override
  List<Object> get props => [];
}

class CreateTaskSuccess extends CreateTaskState {
  @override
  List<Object> get props => [];
}

class CreateTaskFailure extends CreateTaskState {
  @override
  List<Object> get props => [];
}
class CreateTaskUndefined extends CreateTaskState {
  @override
  List<Object> get props => [];
}
