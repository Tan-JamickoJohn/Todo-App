import 'package:flutter/material.dart';
import 'package:todo_app/bloc/tasks_bloc.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/util/helpers/screen_manager.dart';

class TaskPage extends StatefulWidget {
  Task task;
  TaskPage({this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TasksBloc _bloc;
  TextEditingController _nameController, _descriptionController;
  @override
  void initState() {
    super.initState();
    _initTextFields();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: _dispatchUpdateTask,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _dispatchDeleteTask,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenManager.wp(5),
          vertical: ScreenManager.hp(2.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: TextField(
                controller: _nameController,
                style: Theme.of(context).textTheme.headline5,
                decoration: InputDecoration(
                  hintText: "Task Name",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: _descriptionController,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _dispatchDeleteTask() {
    _bloc.deleteMock(widget.task);
    Navigator.pop(context);
  }

  void _dispatchUpdateTask() {
    _bloc.updateMock(
      widget.task,
      _nameController.text,
      _descriptionController.text,
    );
    Navigator.pop(context);
  }

  void _initTextFields() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _nameController.text = widget.task.name;
    _descriptionController.text = widget.task.description;
  }
}
