import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/delete_task/bloc.dart';
import 'package:todo/blocs/tasks_list/bloc.dart';
import 'package:todo/const/strings.dart';
import 'package:todo/ui/widgets/disable_widget.dart';

class DeleteTaskButton extends StatelessWidget {
  final String id;
  const DeleteTaskButton({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteTaskBloc, DeleteTaskState>(
                    listener: (context, state) {
                      if (state is DeleteTaskSuccess) {
                        Navigator.of(context).pop();
                        BlocProvider.of<TaskListBloc>(context)
                            .add(TaskFetchStarted());
                      }
                      if (state is DeleteTaskFailure) {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title:
                                Text(Strings.somethingWentWrong),
                            content: Text(Strings.taskWasNotDeleted),


                          ),
                        );
                      }
                    },
      child: BlocBuilder<DeleteTaskBloc, DeleteTaskState>(
          builder: (context, state) {
        bool isLoading = state is DeleteTaskInProgress;
        return DisableWidget(
          disable: isLoading,
          opacity: isLoading ? 0.4 : 1,
          child: InkWell(
            onTap: () {
              context.read<DeleteTaskBloc>().add(
                    DeleteTaskLoadingStarted(id),
                  );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: const Icon(
                Icons.delete,
              ),
            ),
          ),
        );
      }),
    );
  }
}
