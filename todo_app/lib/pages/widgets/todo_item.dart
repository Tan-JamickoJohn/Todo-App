import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/tasks_bloc.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/pages/task_page.dart';
import 'package:todo_app/util/helpers/screen_manager.dart';

class TodoItem extends StatelessWidget {
  final Task task;
  const TodoItem({this.task});

  @override
  Widget build(BuildContext context) {
    TasksBloc _taskBloc = BlocProvider.of<TasksBloc>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenManager.hp(0.75)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(ScreenManager.hp(1.25))),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskPage(
                        task: task,
                      ),
                  settings: RouteSettings(arguments: _taskBloc)),
            );
          },
          tileColor: Theme.of(context).primaryColor,
          trailing: GestureDetector(
            onTap: () {
              _taskBloc.invertTask(task);
            },
            child: Container(
              height: double.infinity,
              child: task.isFinished ?? false
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).accentColor,
                    )
                  : Icon(
                      Icons.lens_outlined,
                      color: Theme.of(context).accentColor,
                    ),
            ),
          ),
          title: Text(task.name),
          subtitle: Text(
            task.description,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
