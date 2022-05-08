part of 'bloc.dart';

@immutable
abstract class DeleteTaskState extends Equatable {}

class DeleteTaskInProgress extends DeleteTaskState {
  @override
  List<Object> get props => [];
}

class DeleteTaskSuccess extends DeleteTaskState {
  @override
  List<Object> get props => [];
}

class DeleteTaskFailure extends DeleteTaskState {
  @override
  List<Object> get props => [];
}
class DeleteTaskUndefined extends DeleteTaskState {
  @override
  List<Object> get props => [];
}
