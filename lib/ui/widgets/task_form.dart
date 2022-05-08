// ignore_for_file: prefer_const_constructors
// prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/create_task/bloc.dart';
import 'package:todo/ui/widgets/default_spinners.dart';
import 'package:todo/ui/widgets/disable_widget.dart';
import 'package:todo/utils/keyboard.dart';

class TaskForm extends StatefulWidget {
  TaskForm({Key? key, this.onSave, this.description = '', this.title = ''})
      : super(key: key);

  Function? onSave;
  String title;
  String description;
  static Map formData = {};

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var commonStyle = TextStyle(
      fontFamily: 'hel',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Color.fromRGBO(6, 5, 27, 1),
    );
    return Form(
      key: taskFormKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              children: const [
                Text(
                  'Title',
                  style: TextStyle(
                    fontFamily: 'hel',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(6, 5, 27, 1),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: widget.title,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'This field is required';
                }
              },
              onChanged: (String v) {
                setState(() {
                  widget.title = v;
                });
              },textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'What do you want to do?',
                hintStyle: commonStyle.copyWith(
                  color: Color.fromRGBO(167, 166, 180, 1),
                ),
                fillColor: Color.fromRGBO(245, 245, 245, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: const [
                Text(
                  'Description',
                  style: TextStyle(
                    fontFamily: 'hel',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(6, 5, 27, 1),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: widget.description,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'This field is required';
                }
              },
              onChanged: (String v) {
                setState(() {
                  widget.description = v;
                });
              },
              maxLines: 4,
              decoration: InputDecoration(
                hintStyle: commonStyle.copyWith(
                  color: Color.fromRGBO(167, 166, 180, 1),
                ),
                hintText: 'Describe your task',
                fillColor: Color.fromRGBO(245, 245, 245, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            BlocBuilder<CreateTaskBloc, CreateTaskState>(
                builder: (context, state) {
              bool isLoading = state is CreateTaskInProgress;
              return DisableWidget(
                disable: isLoading,
                child: Opacity(
                  opacity: (widget.title.trim().isEmpty ||
                          widget.description.trim().isEmpty)
                      ? 0.5
                      : 1,
                  child: Material(
                    color: Color.fromRGBO(116, 45, 221, 1),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () async {
                        if (taskFormKey.currentState?.validate() ?? false) {
                          TaskForm.formData = {
                            "title": widget.title,
                            "description": widget.description,
                          };
                          KeyboardUtil.hideKeyboard(context);
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await widget.onSave!();
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: isLoading
                              ? buildDefaultSpinner()
                              : Text(
                                  'Save',
                                  style: commonStyle.copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
