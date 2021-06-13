import 'package:flutter/material.dart';
import 'package:todo_app/bloc/tasks_bloc.dart';
import 'package:todo_app/util/helpers/screen_manager.dart';

class CreateTaskModal extends StatefulWidget {
  CreateTaskModal();

  @override
  _CreateTaskModalState createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  TextEditingController _nameController, _descriptionController;
  TasksBloc _bloc;
  bool _isInputValid;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _isInputValid = false;
  }

  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context).settings.arguments;
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ScreenManager.wp(6)),
            )),
        padding: EdgeInsets.symmetric(horizontal: ScreenManager.wp(5), vertical: ScreenManager.hp(2.5)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenManager.wp(5), vertical: ScreenManager.hp(0)),
                child: TextField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  maxLines: 1,
                  onChanged: _validate,
                  decoration: InputDecoration(hintText: 'New Task', border: InputBorder.none),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenManager.wp(5), vertical: ScreenManager.hp(0)),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 1,
                  onChanged: _validate,
                  decoration: InputDecoration(hintText: 'Description', border: InputBorder.none),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: ScreenManager.wp(5)),
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isInputValid ? _dispatchCreateTask : null,
                  child: Text('Save',
                      style: _isInputValid
                          ? TextStyle(color: Theme.of(context).accentColor)
                          : TextStyle(color: Theme.of(context).disabledColor)),
                ),
              )
            ],
          ),
        ));
  }

  bool _validateInput() {
    bool _nameNotEmpty = _nameController?.text?.isNotEmpty ?? false;
    bool _descriptionNotEmpty = _descriptionController?.text?.isNotEmpty ?? false;

    return _nameNotEmpty && _descriptionNotEmpty;
  }

  void _validate(String val) {
    setState(() {
      this._isInputValid = _validateInput();
    });
  }

  void _dispatchCreateTask() {
    _bloc.createMock(_nameController?.text, _descriptionController?.text);
    Navigator.pop(context);
  }
}
