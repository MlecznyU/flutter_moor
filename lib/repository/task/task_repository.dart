import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/tag/tags_dao.dart';
import 'package:fluttermoor/data/task/model_task.dart';
import 'package:fluttermoor/data/task/task_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

class TaskRepository {
  final TaskDao _taskDao;

  TaskRepository(this._taskDao);

  Future<List<Task>> getAllTasksOnce() async => await _taskDao.getAllTasks();

  Stream<List<Task>> observeAllTasks() => _taskDao.watchSimpleAllTasks();

  Stream<List<TaskWithTag>> observeAllCompletedTasksOrdered() =>
      _taskDao.watchAllCompletedTasks();

  Stream<List<TaskWithTag>> observeAllTasksOrdered() =>
      _taskDao.watchAllTasks();

  Future<void> addNewTask({
    String tagName,
    String taskName,
    DateTime dateTime,
    bool isCompleted,
  }) async {
    return await _taskDao.insertTask(TasksCompanion(
      tagName: Value(tagName),
      name: Value(taskName),
      dueDate: Value(dateTime),
      completed: Value(isCompleted),
    ));
  }

  Future<int> addNewTaskAndGetId({
    String tagName,
    String taskName,
    DateTime dateTime,
    bool isCompleted,
  }) async {
    return await _taskDao.insertTaskAndGetId(TasksCompanion(
      tagName: Value(tagName),
      name: Value(taskName),
      dueDate: Value(dateTime),
      completed: Value(isCompleted),
    ));
  }

  Future<void> updateTask(Insertable<Task> task) async =>
      await _taskDao.updateTask(task);

  Future deleteTask(Insertable<Task> task) async =>
      await _taskDao.deleteTask(task);
}
