import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/todo_repository.dart';

part 'events.dart';
part 'states.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  DeleteTaskBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(DeleteTaskSuccess()) {
    on<DeleteTaskLoadingStarted>(_onTaskFetchStarted);
  }

  final TodoRepository _todoRepository;

  void _onTaskFetchStarted(
    DeleteTaskLoadingStarted event,
    Emitter<DeleteTaskState> emit,
  ) async {
    emit(DeleteTaskInProgress());
    try {
      var tasks = await _todoRepository.deleteTask(
        event.id,
      );
      emit(DeleteTaskSuccess());
    } catch (_) {
      emit(DeleteTaskFailure());
    }
  }
}
