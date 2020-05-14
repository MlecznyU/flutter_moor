import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttermoor/bloc/list_of_task_with_tags/list_of_task_with_tags_bloc.dart';
import 'package:fluttermoor/bloc/list_of_task_with_tags/list_of_task_with_tags_event.dart';
import 'package:fluttermoor/bloc/list_of_task_with_tags/list_of_task_with_tags_state.dart';
import 'package:fluttermoor/data/task/model_task.dart';

import '../data/moor_database.dart';
import 'widget/new_tag_input_widget.dart';
import 'widget/new_task_input_widget.dart';

class ListOfTaskWithTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ListOfTaskWithTagsBloc>(context);
    return BlocBuilder<ListOfTaskWithTagsBloc, ListOfTaskWithTagsState>(
      builder: (BuildContext context, state) {
        if (state is InitialListOfTaskWithTagsState) {
          bloc.add(ListListenEvent());
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Tasks'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: (state is ListOfTaskWithTagsAvailableState)
                      ? _buildTaskList(state.list)
                      : Container()),
              NewTaskInput(),
              NewTagInput(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskList(List<TaskWithTag> list) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (_, index) {
        final item = list[index];
        return _buildListItem(item);
      },
    );
  }
}

Widget _buildListItem(TaskWithTag item) {
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        //onTap: () => ,
      )
    ],
    child: CheckboxListTile(
      title: Text(item.task.name),
      subtitle: Text(item.task.dueDate?.toString() ?? 'No date'),
      secondary: _buildTag(item.tag),
      value: item.task.completed,
      onChanged: (newValue) {
        //dao.updateTask(item.task.copyWith(completed: newValue));
      },
    ),
  );
}

Column _buildTag(Tag tag) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      if (tag != null) ...[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(tag.color),
          ),
        ),
        Text(
          tag.name,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    ],
  );
}
