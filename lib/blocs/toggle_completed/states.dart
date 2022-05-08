part of 'bloc.dart';

@immutable
abstract class ToggleCompletedState extends Equatable {
  String id='';
}

class ToggleCompletedInProgress extends ToggleCompletedState {
  String id;
  ToggleCompletedInProgress(this.id);
  @override
  List<Object> get props => [];
}

class ToggleCompletedSuccess extends ToggleCompletedState {
  String id;
  ToggleCompletedSuccess(this.id);

  @override
  List<Object> get props => [];
}

class ToggleCompletedFailure extends ToggleCompletedState {
  String id;
  ToggleCompletedFailure(this.id);
  @override
  List<Object> get props => [];
}

class ToggleCompletedUndefined extends ToggleCompletedState {
  @override
  List<Object> get props => [];
}
