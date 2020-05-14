import 'package:fluttermoor/data/task/model_task.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListOfTaskWithTagsEvent {
  const ListOfTaskWithTagsEvent();
}

class ListListenEvent extends ListOfTaskWithTagsEvent {
  const ListListenEvent();
}

class ListRequestEvent extends ListOfTaskWithTagsEvent {
  final List<TaskWithTag> list;

  const ListRequestEvent(this.list);
}

class AddNewTaskEvent extends ListOfTaskWithTagsEvent {
  final String taskName;
  final DateTime dateTime;
  final String tagName;

  const AddNewTaskEvent(this.taskName, this.dateTime, this.tagName);
}

class DeleteTaskEvent extends ListOfTaskWithTagsEvent {
  final int taskId;
  final String taskName;
  final DateTime dateTime;
  final String tagName;

  const DeleteTaskEvent(
      this.taskName, this.dateTime, this.tagName, this.taskId);
}
