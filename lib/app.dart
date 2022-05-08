import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/create_task/bloc.dart';
import 'package:todo/blocs/delete_task/bloc.dart';
import 'package:todo/blocs/tasks_list/bloc.dart';
import 'package:todo/blocs/toggle_completed/bloc.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/todo_repository.dart';
import 'package:todo/routes.dart';
import 'package:todo/theme.dart';
import 'package:todo/ui/pages/todo_detail/todo_detail_page.dart';
import 'package:todo/ui/pages/todo_list/todo_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoRepository = TodoRepository.create();
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskListBloc>(
          create: (_) => TaskListBloc(
            todoRepository: todoRepository,
          )..add(TaskFetchStarted()),
        ),
        BlocProvider<CreateTaskBloc>(
          create: (_) => CreateTaskBloc(
            todoRepository: todoRepository,
          ),
        ),
        BlocProvider<DeleteTaskBloc>(
          create: (_) => DeleteTaskBloc(
            todoRepository: todoRepository,
          ),
        ),
        BlocProvider<ToggleCompletedBloc>(
          create: (_) => ToggleCompletedBloc(
            todoRepository: todoRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: generateMaterialColor(
            const Color.fromRGBO(116, 45, 221, 1),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        routes: Routes.routes,
        initialRoute: TodoListPage.name,
      ),
    );
  }
}
