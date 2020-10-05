import 'package:flutter/material.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/utils/utils.dart';

class TaskDetail extends StatefulWidget {
  TaskDetail({
    Key key,
    @required this.task,
  }) : super(key: key);

  final Task task;

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.taskTitle,
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
            widget.task.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    TextSpan(
                      text: Strings.date,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(text: ': '),
                    TextSpan(
                        text: Format.displayDateFormat
                            .format(DateTime.parse(widget.task.dateTime))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: textSecondaryColor),
                    children: [
                      TextSpan(
                        text: Strings.status,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textSecondaryColor),
                      ),
                      TextSpan(text: ': '),
                      TextSpan(
                          text: (widget.task.completed)
                              ? Strings.completed
                              : Strings.ongoing),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              children: [
                TextSpan(
                  text: Strings.repeat,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextSpan(text: ': '),
                TextSpan(text: widget.task.repeat),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            Strings.note,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            widget.task.note,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
