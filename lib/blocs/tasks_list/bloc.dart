import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/todo_repository.dart';

part 'states.dart';
part 'events.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(TaskListLoadInProgress()) {
    on<TaskFetchStarted>(_onTaskFetchStarted);
     on<DidUpdateListEvent>(_onDidUpdateListEvent);
  }

  final TodoRepository _todoRepository;

  void _onTaskFetchStarted(
    TaskFetchStarted event,
    Emitter<TaskListState> emit,
  ) async {
    emit(TaskListLoadInProgress());
    try {
      var tasks = await _todoRepository.getAllTasks();
      tasks = _sortTasks(tasks);
      emit(TaskListLoadSuccess(tasks));
    } catch (_) {
      emit(TaskListLoadFailure());
    }
  }
void _onDidUpdateListEvent(
    DidUpdateListEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(TaskListLoadInProgress());
    try {
      
      var tasks = _sortTasks(event.tasks);
      emit(TaskListLoadSuccess(tasks));
    } catch (_) {
      emit(TaskListLoadFailure());
    }
  }

 List<TaskModel> _sortTasks(List<TaskModel> tasks) {
    List<TaskModel> completedTasks = [];
    List<TaskModel> inCompletedTasks = [];
    while (tasks.isNotEmpty) {
      var task = tasks.removeAt(0);
      if (task.isCompleted) {
        completedTasks.add(task);
      } else {
        inCompletedTasks.add(task);
      }
    }
    tasks.addAll(inCompletedTasks);
    tasks.addAll(completedTasks);
    return tasks;
  }
}
