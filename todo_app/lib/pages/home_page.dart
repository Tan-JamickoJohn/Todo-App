import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/tasks_bloc.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/pages/widgets/create_task_modal.dart';
import 'package:todo_app/pages/widgets/todo_item.dart';
import 'package:todo_app/util/helpers/screen_manager.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  TasksBloc _tasksBloc;

  @override
  void initState() {
    super.initState();
    _tasksBloc = TasksBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
        create: (context) => _tasksBloc,
        child: SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(),
            bottomNavigationBar: _buildBottomNavBar(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _buildFAB(),
            body: _buildBody(),
          ),
        ));
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: ScreenManager.hp(7.55),
          )
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            routeSettings: RouteSettings(arguments: _tasksBloc),
            builder: (context) {
              return CreateTaskModal();
            });
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('My Tasks'),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenManager.wp(5), vertical: ScreenManager.hp(2.5)),
      child: StreamBuilder<Map<String, Task>>(
        stream: _tasksBloc.tasksController,
        initialData: {},
        builder: (context, snapshot) {
          if (snapshot?.data?.isNotEmpty ?? false) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  String key = snapshot.data.keys.elementAt(index);
                  return TodoItem(
                    task: snapshot.data[key],
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
