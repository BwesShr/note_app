import 'package:flutter/material.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class AddTask extends StatefulWidget {
  AddTask({
    Key key,
    this.dueDate,
  }) : super(key: key);

  final DateTime dueDate;

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  String _repeat;
  final _dbHelper = DBHelper();

  @override
  void initState() {
    _repeat = Strings.repeatList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.addTaskTitle,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: textSecondaryColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        children: [
          Text(
            Strings.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          TextFormField(
            controller: _titleController,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0.0),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            Strings.note,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: 5.0),
          TextFormField(
            controller: _noteController,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 15,
            minLines: 15,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            Strings.dueDate,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          DateTimePicker(
            date: widget.dueDate,
          ),
          SizedBox(height: 10.0),
          Text(
            Strings.repeat,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          DropdownButton(
            value: _repeat,
            isExpanded: true,
            underline: Offstage(),
            items: Strings.repeatList.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                );
              },
            ).toList(),
            onChanged: (item) {
              setState(() {
                _repeat = item;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PrimaryButton(
                width: width * 0.45,
                color: Theme.of(context).accentColor,
                text: Strings.btnCancel,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 5.0),
              PrimaryButton(
                width: width * 0.45,
                color: Theme.of(context).primaryColor,
                text: Strings.btnSave,
                onPressed: saveTask,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void saveTask() async {
    Task task = new Task(
      title: _titleController.text,
      note: _noteController.text,
      dateTime: Format.dateTimeFormat.format(widget.dueDate),
      completed: false,
      repeat: _repeat,
    );
    await _dbHelper.addTask(task);
    Navigator.of(context).pop();
  }
}
