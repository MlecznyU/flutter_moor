import 'package:moor_flutter/moor_flutter.dart';

import 'moor_database.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tagName =>
      text().nullable().customConstraint('NULL REFERENCES tags(name)')();

  TextColumn get name => text().withLength(min: 1, max: 15)();

  DateTimeColumn get dueDate => dateTime().nullable()();

  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

class TaskWithTag {
  final Task task;
  final Tag tag;

  TaskWithTag({
    @required this.task,
    @required this.tag,
  });
}
