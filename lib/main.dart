import 'package:flutter/material.dart';
import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/task_dao.dart';
import 'package:fluttermoor/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<TaskDao>(
      create: (_) => AppDatabase().taskDao,
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
