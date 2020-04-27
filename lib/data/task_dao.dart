import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/model_task.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'task_dao.g.dart';

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  // this is getter for our tasks
  Future<List<Task>> getAllTasks() => select(tasks).get();

  // a this is how we can observe them
  Stream<List<Task>> watchSimpleAllTasks() => select(tasks).watch();

  Stream<List<Task>> watchAllTasks() {
    return (select(tasks)
          ..orderBy([
            (_) => OrderingTerm(expression: _.dueDate, mode: OrderingMode.desc),
            (_) => OrderingTerm(expression: _.name),
          ]))
        .watch();
  }

  Stream<List<Task>> watchAllCompletedTasks() {
    return (select(tasks)
          ..orderBy([
            (_) => OrderingTerm(expression: _.dueDate, mode: OrderingMode.desc),
            (_) => OrderingTerm(expression: _.name),
          ])
          ..where((_) => _.completed.equals(true)))
        .watch();
  }

  // this is how we can insert
  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);

  // this is how we can insert and get id
  Future<int> insertTaskAndGetId(Insertable<Task> task) =>
      into(tasks).insert(task);

  // this is how we can insert and get id
  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);

  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);
}
