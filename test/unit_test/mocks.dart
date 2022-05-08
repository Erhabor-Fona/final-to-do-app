import 'package:mockito/mockito.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/todo_repository.dart';

import 'mock_responses.dart';

class MockTodoRepository extends Mock implements TodoRepository {
  @override
  Future<List<TaskModel>> getAllTasks() async {
    return getAllTaskMock;
  }

  @override
  Future deleteTask(id) async {
    return '';
  }

 

  @override
  Future updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    return '';
  }

  @override
  Future insertTask(
      {required String title, required String description}) async {
    return 'ee-ee';
  }
  }

class MockTodoFailRepository extends Mock implements MockTodoRepository {
  @override
  Future<List<TaskModel>> getAllTasks() async {
    throw Exception;
  }

  @override
  Future deleteTask(id) async {
    throw Exception;
  }

 

  @override
  Future updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
  throw Exception;
  }

  @override
  Future insertTask(
      {required String title, required String description}) async {
    throw Exception;
  }
  }

