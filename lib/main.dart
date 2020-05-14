import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoor/bloc/list_of_task_with_tags/list_of_task_with_tags_bloc.dart';
import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/task/task_dao.dart';
import 'package:fluttermoor/repository/task/task_repository.dart';
import 'package:fluttermoor/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    final _taskDao = TaskDao(db);
    final _taskRepository = TaskRepository(_taskDao);
    return BlocProvider(
      create: (context) => ListOfTaskWithTagsBloc(_taskRepository),
      child: MaterialApp(
        title: 'Material App',
        home: ListOfTaskWithTags(),
      ),
    );
  }
}
