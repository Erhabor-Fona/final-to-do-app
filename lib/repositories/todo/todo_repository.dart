// import 'package:graphql/client.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/queries/queries.dart';
import 'package:todo/utils/debug_print.dart';

class TodoRepositoryException implements Exception {}

class TodoRepository {
  final GraphQLClient _graphQLClient;

  final String developerId ;

  const TodoRepository({required GraphQLClient graphQLClient,this.developerId="We fly to thy patronage"})
      : _graphQLClient = graphQLClient;

  factory TodoRepository.create([developerId="We fly to thy patronage"]) {
    final httpLink = HttpLink(
        'https://todolistassessment.hasura.app/v1/graphql',
        defaultHeaders: {
          "x-hasura-admin-secret":
              "JG7vDm15n1fVT2QhwYNyDFJJmm5iQKIea3H0tVpYnNV735Wa2ms3msthBGquM2sm",
          "content-type": "application/json",
        });
    final link = Link.from([httpLink]);
    return TodoRepository(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),developerId: developerId,
    );
  }

  Future<List<TaskModel>> getAllTasks() async {
    final result = await _graphQLClient.query(
      QueryOptions(
        document: gql(TodoQueries.getAllTasks),
        variables: {
          "developer_id": developerId,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    out(result.data);
    if (result.hasException) throw TodoRepositoryException;

    List tasks = result.data?['tasks'];
    List<TaskModel> taskModels = [];
    for (var task in tasks) {
      taskModels.add(TaskModel.fromJson(task));
    }
    return taskModels;
  }

  Future getSingleTask(String id) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        document: gql(TodoQueries.getSingleTask),
        variables: {"id": id},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return result.data?['tasks_by_pk'];
  }

  Future deleteTask(String id) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        document: gql(TodoQueries.deleteTask),
        variables: {"id": id},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    out(result.data);
    if (result.hasException) throw TodoRepositoryException;
    return result.data?['delete_tasks_by_pk'];
  }

  Future insertTask(
      {required String title, required String description}) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        document: gql(TodoQueries.insertTask),
        variables: {
          "developer_id": developerId,
          "title": title,
          "description": description,
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    out(result.data);
    if (result.hasException) throw TodoRepositoryException;
    return result.data?['insert_tasks_one'];
  }

  Future updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        document: gql(TodoQueries.updateTask),
        variables: {
          "id": id,
          "payload": {
            "isCompleted": isCompleted,
            "title": title,
            "description": description
          }
        },
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    out(result.data);
    if (result.hasException) throw TodoRepositoryException;
    return result.data?['update_tasks_by_pk'];
  }
}
