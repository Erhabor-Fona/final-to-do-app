import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/todo_repository.dart';

part 'events.dart';
part 'states.dart';

class ToggleCompletedBloc extends Bloc<ToggleCompletedEvent, ToggleCompletedState> {
  ToggleCompletedBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(ToggleCompletedUndefined()) {
    on<ToggleCompletedEventStarted>(_onToggleCompletedEventStarted);}

  final TodoRepository _todoRepository;

  void _onToggleCompletedEventStarted(
    ToggleCompletedEventStarted event,
    Emitter<ToggleCompletedState> emit,
  ) async {
    emit(ToggleCompletedInProgress(event.task.id));
    try {
       var tasks = await _todoRepository.updateTask(
          title: event.task.title,
          description: event.task.description,
          id: event.task.id,
          isCompleted: !(event.task.isCompleted));
          
      emit(ToggleCompletedSuccess(event.task.id));
    } catch (_) {
      emit(ToggleCompletedFailure(event.task.id));
    }
  }


}
