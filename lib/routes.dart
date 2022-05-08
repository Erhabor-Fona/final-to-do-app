


import 'package:flutter/material.dart';
import 'package:todo/ui/pages/todo_detail/todo_detail_page.dart';
import 'package:todo/ui/pages/todo_list/todo_list_page.dart';

class Routes{

 static Map<String, Widget Function(BuildContext)> routes ={
    TodoListPage.name: (_)=> const TodoListPage(),
  };


}