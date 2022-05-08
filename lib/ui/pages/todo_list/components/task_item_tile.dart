import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/blocs/create_task/bloc.dart';
import 'package:todo/blocs/delete_task/bloc.dart';
import 'package:todo/blocs/tasks_list/bloc.dart';
import 'package:todo/blocs/toggle_completed/bloc.dart';
import 'package:todo/const/strings.dart';
import 'package:todo/repositories/todo/models/task_model.dart';
import 'package:todo/repositories/todo/todo_repository.dart';
import 'package:todo/ui/pages/todo_detail/todo_detail_page.dart';
import 'package:todo/ui/pages/todo_list/components/checkboxes.dart';
import 'package:todo/ui/widgets/default_spinners.dart';
import 'package:todo/ui/widgets/disable_widget.dart';
import 'package:todo/ui/widgets/task_form.dart';
import 'package:todo/utils/debug_print.dart';

class TaskItemTile extends StatelessWidget {
  final TaskModel task;
  final int index;

  TaskItemTile({Key? key, required this.task, required this.index})
      : super(key: key);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var borderColor = task.isCompleted
        ? const Color.fromRGBO(0, 145, 32, 1)
        : const Color.fromRGBO(237, 178, 0, 1);
    var bgColor = task.isCompleted
        ? const Color.fromRGBO(238, 255, 244, 1)
        : const Color.fromRGBO(255, 249, 231, 1);
    var textColor = borderColor;
    String tagText = task.isCompleted ? task.title.substring(0, 1) : '$index';
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
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
                          title: Text(Strings.somethingWentWrong),
                          content: Text(Strings.taskNotSaved),
                        ),
                      );
                    }
                  },
                  child: TodoDetailPage(
                    type: TodoDetailPageType.update,
                    description: task.description,
                    title: task.title,
                    id: task.id,
                    onSave: () async {
                      task
                        ..description = TaskForm.formData[Strings.description]
                        ..title = TaskForm.formData[Strings.title];
                      context.read<CreateTaskBloc>().add(
                            UpdateTaskStarted(task),
                          );
                    },
                  ),
                ),
              ),
            );
          },
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgColor,
                    border: Border.all(
                      width: 1,
                      color: borderColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tagText,
                      style: TextStyle(
                          fontFamily: 'hel', color: textColor, fontSize: 14),
                    ),
                  ),
                ),
               const SizedBox(
                  width: 14,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'hel',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color.fromRGBO(6, 5, 27, 1),
                        decoration: (task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                      ),
                    ),
                    const SizedBox(height:7),
                    Text(
                      task.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontFamily: 'hel',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(167, 166, 180, 1),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  width: 14,
                ),
                BlocListener<ToggleCompletedBloc, ToggleCompletedState>(
                  listener: (context, state) {
                    if (state.id != task.id) {
                      return;
                    }
                    if (state is ToggleCompletedSuccess) {
                      if (BlocProvider.of<TaskListBloc>(
                        context,
                      ).state is TaskListLoadSuccess) {
                        var taskListState = BlocProvider.of<TaskListBloc>(
                          context,
                        ).state as TaskListLoadSuccess;
                        var taskList = taskListState.tasks;

                        for (var element in taskList) {
                          if (element.id == state.id) {
                            element.isCompleted = !task.isCompleted;
                          }
                        }
                        BlocProvider.of<TaskListBloc>(context)
                            .add(DidUpdateListEvent(taskList));
                      }
                    }
                    if (state is ToggleCompletedFailure) {
                      showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                          title:
                              Text(Strings.somethingWentWrong),
                              content: Text(Strings.couldNotUpdate),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ToggleCompletedBloc, ToggleCompletedState>(
                      builder: (context, state) {
                    if (state.id == task.id) {
                      out('here');
                      isLoading = state is ToggleCompletedInProgress;
                    }

                    return DisableWidget(
                      disable: isLoading,
                      opacity:  1,
                      child: InkWell(
                        onTap: () {
                          context.read<ToggleCompletedBloc>().add(
                                ToggleCompletedEventStarted(task),
                              );
                        },
                        child: Container(
                          
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 16, 16, 10),
                            child:isLoading?const Icon(Icons.refresh): (task.isCompleted)
                                ? const CheckBoxGood()
                                : const CheckBoxEmpty(),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
