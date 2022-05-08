import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/blocs/create_task/bloc.dart';
import 'package:todo/blocs/delete_task/bloc.dart';
import 'package:todo/blocs/tasks_list/bloc.dart';
import 'package:todo/blocs/toggle_completed/bloc.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/todo_repository.dart';
// import 'package:test/expect.dart';

import 'mock_responses.dart';
import 'mocks.dart';

void main() {
  MockTodoRepository mockTodoRepository = MockTodoRepository();
  MockTodoFailRepository mockTodoFailRepository = MockTodoFailRepository();

  group('Test Blocs for successful uperation', () {
    blocTest(
      "Test TaskFetchStarted Event",
      build: () => TaskListBloc(todoRepository: mockTodoRepository),
      act: (TaskListBloc taskBloc) => taskBloc.add(TaskFetchStarted()),
      expect: () =>
          [TaskListLoadInProgress(), TaskListLoadSuccess(getAllTaskMock)],
    );

    blocTest(
      "Test CreateTaskStarted Event",
      build: () => CreateTaskBloc(todoRepository: mockTodoRepository),
      act: (CreateTaskBloc taskBloc) => taskBloc.add(
          CreateTaskStarted(TaskModel.createEmpty('title', 'description'))),
      expect: () => [CreateTaskInProgress(), CreateTaskSuccess()],
    );

    blocTest(
      "Test UpdateTaskStarted Event",
      build: () => CreateTaskBloc(todoRepository: mockTodoRepository),
      act: (CreateTaskBloc taskBloc) => taskBloc.add(
          UpdateTaskStarted(TaskModel.createEmpty('title', 'description'))),
      expect: () => [CreateTaskInProgress(), CreateTaskSuccess()],
    );

    blocTest(
      "Test ToggleCompletedEventStarted Event",
      build: () => ToggleCompletedBloc(todoRepository: mockTodoRepository),
      act: (ToggleCompletedBloc taskBloc) => taskBloc.add(
          ToggleCompletedEventStarted(
              TaskModel.createEmpty('title', 'description'))),
      expect: () => [ToggleCompletedInProgress(''), ToggleCompletedSuccess('')],
    );

    blocTest(
      "Test DeleteTaskLoadingStarted Event",
      build: () => DeleteTaskBloc(todoRepository: mockTodoRepository),
      act: (DeleteTaskBloc taskBloc) =>
          taskBloc.add(DeleteTaskLoadingStarted('id')),
      expect: () => [DeleteTaskInProgress(), DeleteTaskSuccess()],
    );
  });

  group('Test Blocs for failed uperation', () {
    blocTest(
      "Test Fetch faill state",
      build: () => TaskListBloc(todoRepository: mockTodoFailRepository),
      act: (TaskListBloc taskBloc) => taskBloc.add(TaskFetchStarted()),
      expect: () => [TaskListLoadInProgress(), TaskListLoadFailure()],
    );

    blocTest(
      "Test CreateTask fail state",
      build: () => CreateTaskBloc(todoRepository: mockTodoFailRepository),
      act: (CreateTaskBloc taskBloc) => taskBloc.add(
          CreateTaskStarted(TaskModel.createEmpty('title', 'description'))),
      expect: () => [CreateTaskInProgress(), CreateTaskFailure()],
    );

    blocTest(
      "Test UpdateTask fail state",
      build: () => CreateTaskBloc(todoRepository: mockTodoFailRepository),
      act: (CreateTaskBloc taskBloc) => taskBloc.add(
          UpdateTaskStarted(TaskModel.createEmpty('title', 'description'))),
      expect: () => [CreateTaskInProgress(), CreateTaskFailure()],
    );

    blocTest(
      "Test ToggleCompleted fail state",
      build: () => ToggleCompletedBloc(todoRepository: mockTodoFailRepository),
      act: (ToggleCompletedBloc taskBloc) => taskBloc.add(
          ToggleCompletedEventStarted(
              TaskModel.createEmpty('title', 'description'))),
      expect: () => [ToggleCompletedInProgress(''), ToggleCompletedFailure('')],
    );

    blocTest(
      "Test DeleteTask fail state",
      build: () => DeleteTaskBloc(todoRepository: mockTodoFailRepository),
      act: (DeleteTaskBloc taskBloc) =>
          taskBloc.add(DeleteTaskLoadingStarted('id')),
      expect: () => [DeleteTaskInProgress(), DeleteTaskFailure()],
    );
  });

  /// To run the below line,ensure you have internet connection

  group("Repository test with live Gragphqlendpoints", () {
    late TodoRepository repo;
    var id = '';
    
    test('Respository create', () {
      repo = TodoRepository.create('${DateTime.now()}');
      expect(repo.runtimeType, TodoRepository);
    });

    test('Respository add', () async {
      var r = await repo.insertTask(title: 'title', description: 'description');
      id = r['id'];
      expect(r['title'], 'title');
    });
    
    test('Respository get single task', () async {
      var r = await repo.getSingleTask('$id');
      expect(r['id'], id);
    });

    test('Respository update', () async {
      var u = await repo.updateTask(
          title: 'title',
          description: 'description',
          isCompleted: true,
          id: id);
      expect(u['id'], id);
      expect(u['isCompleted'], true);
    });
    
    test('Respository delete', () async {
      var u = await repo.deleteTask(id);
      var l = await repo.getAllTasks();
      expect(l, []);
    });
  });
}
