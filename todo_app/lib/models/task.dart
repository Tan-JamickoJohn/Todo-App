class Task {
  String name;
  String description;
  String id;
  bool isFinished;

  Task({this.id, this.name, this.description, this.isFinished});

  Task.fromJson(Map<String, dynamic> json) {
    id = json[TaskFields.ID] ?? '';
    name = json[TaskFields.NAME] ?? '';
    description = json[TaskFields.DESCRIPTION] ?? '';
    isFinished = json[TaskFields.IS_FINISHED] ?? false;
  }

  Task.toJson() {
    Map<String, dynamic> json = {};
    json[TaskFields.NAME] = name ?? '';
    json[TaskFields.DESCRIPTION] = description ?? '';
    json[TaskFields.ID] = id ?? '';
    json[TaskFields.IS_FINISHED] = isFinished ?? false;
  }
}

class TaskFields {
  static const String NAME = "name";
  static const String DESCRIPTION = "description";
  static const String ID = "id";
  static const String IS_FINISHED = "isFinished";
}
