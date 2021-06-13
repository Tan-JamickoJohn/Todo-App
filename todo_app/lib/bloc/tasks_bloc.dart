import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/util/constants/file_paths.dart';
import 'package:todo_app/util/helpers/json_helper.dart';

class TasksBloc extends BlocBase {
  TasksBloc() : super(null) {
    initMock();
  }

  final BehaviorSubject<Map<String, Task>> _tasksController = BehaviorSubject<Map<String, Task>>();

  BehaviorSubject<Map<String, Task>> get tasksController => _tasksController.stream;

  Map<String, Task> tasks = {};

  void dispose() {
    _tasksController.close();
  }

  static loadTasksFromJson(Map<String, dynamic> json) {
    Map<String, Task> loadedTasks = {};
    if (json['tasks'] != null) {
      json['tasks'].forEach((data) {
        loadedTasks[data["id"]] = Task.fromJson(data);
      });
    }
    return loadedTasks;
  }

  void initMock() async {
    Map<String, dynamic> data = await JSONHelper.parseJsonFromAsset(FilePaths.MOCKED_TASKS);
    tasks = loadTasksFromJson(data);
    _tasksController.add(tasks);
  }

  void invertTask(Task task) {
    task.isFinished = !task.isFinished;
    tasks[task.id] = task;
    _tasksController.add(tasks);
  }

  void deleteMock(Task task) {
    tasks.remove(task.id);
    _tasksController.add(tasks);
  }

  void updateMock(Task task, String newName, String newDescription) {
    task.name = newName ?? '';
    task.description = newDescription ?? '';
    tasks.update(task.id, (value) => task, ifAbsent: () => task);
    _tasksController.add(tasks);
  }

  String _generateMockId() {
    return (tasks.length + 1).toString();
  }

  void createMock(String name, String description) {
    Task task = Task(
      id: _generateMockId(),
      description: description ?? '',
      name: name ?? '',
      isFinished: false,
    );

    tasks[task.id] = task;
    _tasksController.add(tasks);
  }
}
