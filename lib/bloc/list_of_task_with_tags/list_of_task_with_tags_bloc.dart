import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttermoor/repository/task/task_repository.dart';

import 'list_of_task_with_tags_event.dart';
import 'list_of_task_with_tags_state.dart';

class ListOfTaskWithTagsBloc
    extends Bloc<ListOfTaskWithTagsEvent, ListOfTaskWithTagsState> {
  final TaskRepository _repository;

  ListOfTaskWithTagsBloc(this._repository);

  @override
  ListOfTaskWithTagsState get initialState => InitialListOfTaskWithTagsState();

  @override
  Stream<ListOfTaskWithTagsState> mapEventToState(
    ListOfTaskWithTagsEvent event,
  ) async* {
    if (event is ListListenEvent) {
      _repository.observeAllTasksOrdered().listen((newList) {
        this.add(ListRequestEvent(newList));
      });
    } else if (event is AddNewTaskEvent) {
      _repository.addNewTask(
        taskName: event.taskName,
        tagName: event.tagName,
        dateTime: event.dateTime,
        isCompleted: false,
      );
    } else if (event is ListRequestEvent) {
      yield ListOfTaskWithTagsAvailableState(event.list);
    }
  }
}
