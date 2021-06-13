import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/tasks_bloc.dart';
import 'package:todo_app/models/task.dart';

class TodoItem extends StatelessWidget {
  final Task task;
  const TodoItem({this.task});

  @override
  Widget build(BuildContext context) {
    TasksBloc _taskBloc = BlocProvider.of<TasksBloc>(context);
    return ListTile(
      trailing: GestureDetector(
        onTap: () {
          _taskBloc.invertTask(task);
        },
        child: Container(
          height: double.infinity,
          child: task.isFinished ?? false ? Icon(Icons.check_circle_outline) : Icon(Icons.lens_outlined),
        ),
      ),
      title: Text(task.name),
      subtitle: Text(
        task.description,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
