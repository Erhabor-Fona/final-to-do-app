part of 'bloc.dart';



@immutable
abstract class DeleteTaskEvent extends Equatable {}

class DeleteTaskLoadingStarted extends DeleteTaskEvent {
   String id;
   DeleteTaskLoadingStarted(this.id);
  @override
  List<Object> get props => [];
}


