import 'package:fluttermoor/data/tag/model_tags.dart';
import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/task/model_task.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'task_dao.g.dart';
@UseDao(tables: [Tasks, Tags])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  // this is getter for our tasks
  Future<List<Task>> getAllTasks() => select(tasks).get();

  // a this is how we can observe them
  Stream<List<Task>> watchSimpleAllTasks() => select(tasks).watch();

  Stream<List<TaskWithTag>> watchAllTasks() {
    return (select(tasks)
          ..orderBy([
            (_) => OrderingTerm(expression: _.dueDate, mode: OrderingMode.desc),
            (_) => OrderingTerm(expression: _.name),
          ]))
        .join(
          [
            leftOuterJoin(tags, tags.name.equalsExp(tasks.tagName)),
          ],
        )
        .watch()
        .map(
          (rows) => rows.map(
            (row) {
              return TaskWithTag(
                task: row.readTable(tasks),
                tag: row.readTable(tags),
              );
            },
          ).toList(),
        );
  }

  Stream<List<TaskWithTag>> watchAllCompletedTasks() {
    return (select(tasks)
          ..orderBy([
            (_) => OrderingTerm(expression: _.dueDate, mode: OrderingMode.desc),
            (_) => OrderingTerm(expression: _.name),
          ])
          ..where((_) => _.completed.equals(true)))
        .join(
          [
            leftOuterJoin(tags, tags.name.equalsExp(tasks.tagName)),
          ],
        )
        .watch()
        .map(
          (rows) => rows.map(
            (row) {
              return TaskWithTag(
                task: row.readTable(tasks),
                tag: row.readTable(tags),
              );
            },
          ).toList(),
        );
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
