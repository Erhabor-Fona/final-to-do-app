import 'package:flutter/material.dart';
import 'package:todo/ui/pages/todo_detail/components/delete_task_button.dart';
import 'package:todo/ui/widgets/black_safe_area.dart';
import 'package:todo/ui/widgets/close_keyboard.dart';
import 'package:todo/ui/widgets/task_form.dart';

enum TodoDetailPageType { create, update }

class TodoDetailPage extends StatelessWidget {
  TodoDetailPage(
      {Key? key,
      this.onSave,
      this.description = '',
      this.title = '',
      this.id = '',
      required this.type})
      : super(key: key);

  TodoDetailPageType type;
  Function? onSave;
  String title;
  String description;
  String id;

  @override
  Widget build(BuildContext context) {
    return CloseKeyboard(
      child: BlackSafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            actions: (type != TodoDetailPageType.create)
                ? [
                    DeleteTaskButton(id: id),
                  ]
                : [],
            title: Text(
              (type == TodoDetailPageType.create)
                  ? 'Create Task'
                  : 'Task details',
              style: TextStyle(
                  fontFamily: 'circular',
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TaskForm(
                  description: description,
                  title: title,
                  onSave: onSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
