import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/create_task/bloc.dart';
import 'package:todo/blocs/tasks_list/bloc.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/ui/pages/todo_detail/todo_detail_page.dart';
import 'package:todo/ui/pages/todo_list/components/task_item_tile.dart';
import 'package:todo/ui/widgets/black_safe_area.dart';
import 'package:todo/ui/widgets/retry_widget.dart';
import 'package:todo/ui/widgets/task_form.dart';

class TodoListPage extends StatelessWidget {
  static const name = '/todo_list';

  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlackSafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Todo List',
            style: TextStyle(
                fontFamily: 'circular',
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BlocListener<CreateTaskBloc, CreateTaskState>(
                  listener: (context, state) {
                    if (state is CreateTaskSuccess) {
                      Navigator.of(context).pop();
                      BlocProvider.of<TaskListBloc>(context)
                          .add(TaskFetchStarted());
                    }
                    if (state is CreateTaskFailure) {
                      showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                          title:
                              Text("Something went wrong"),
                              content: Text("Couldn't update task"),
                        ),
                      );
                    }
                  },
                  child: TodoDetailPage(
                    type: TodoDetailPageType.create,
                    onSave: () async {
                      context.read<CreateTaskBloc>().add(
                            CreateTaskStarted(
                              TaskModel.createEmpty(
                                TaskForm.formData['title'],
                                TaskForm.formData['description'],
                              ),
                            ),
                          );
                    },
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body:
            BlocBuilder<TaskListBloc, TaskListState>(builder: (context, state) {
          if (state is TaskListLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskListLoadSuccess) {
            return (state.tasks.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Todo List is empty',
                            style: TextStyle(
                                fontFamily: 'circular',
                                fontSize: 24,
                                fontWeight: FontWeight.w400,),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Create a task',
                            style: TextStyle(
                                color: Color.fromRGBO(119, 119, 119, 1),
                                fontFamily: 'circular',
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom:
                                (index == (state.tasks.length - 1)) ? 100 : 0),
                        child: TaskItemTile(
                          key: ValueKey(state.tasks[index].id),
                            task: state.tasks[index], index: 1 + index),
                      );
                    });
          }
          return RetryWidget(retryPress: () {
            context.read<TaskListBloc>().add(
                  TaskFetchStarted(),
                );
          });
        }),
      ),
    );
  
  }
}

