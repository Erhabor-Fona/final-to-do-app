part of 'bloc.dart';

@immutable
abstract class ToggleCompletedEvent extends Equatable {}

class ToggleCompletedEventStarted extends ToggleCompletedEvent {
  TaskModel task;
  ToggleCompletedEventStarted(this.task);
  @override
  List<Object> get props => [];
}

