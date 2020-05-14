import 'package:fluttermoor/data/task/model_task.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListOfTaskWithTagsState {}

class InitialListOfTaskWithTagsState extends ListOfTaskWithTagsState {}

class ListOfTaskWithTagsAvailableState extends ListOfTaskWithTagsState {
  final List<TaskWithTag> list;

  ListOfTaskWithTagsAvailableState(this.list);
}

class NoListOfTaskWithTagsState extends ListOfTaskWithTagsState {}
