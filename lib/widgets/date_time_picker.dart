import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class DateTimePicker extends StatefulWidget {
  DateTimePicker({
    Key key,
    @required this.date,
  }) : super(key: key);

  DateTime date;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final _functions = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            DateTime today = await selectDate(context, widget.date);
            if (today != null) {
              setState(() {
                widget.date = DateTime(today.year, today.month, today.day);
              });
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: DisableTextField(
                  text: Format.dayDateFormat.format(widget.date),
                ),
              ),
              SizedBox(width: 10.0),
              Icon(
                FontAwesomeIcons.solidCalendarAlt,
                size: 25.0,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        InkWell(
          onTap: () async {
            TimeOfDay time = await selectTime(
                context,
                _functions
                    .parseTimeOfDay(widget.date.toString().split(' ')[1]));
            if (time != null) {
              setState(() {
                widget.date = DateTime(widget.date.year, widget.date.month,
                    widget.date.day, time.hour, time.minute);
              });
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: DisableTextField(
                  text: Format.timeStampFormat.format(widget.date),
                ),
              ),
              SizedBox(width: 10.0),
              Icon(
                FontAwesomeIcons.clock,
                size: 25.0,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<DateTime> selectDate(context, DateTime initialDate) async {
  return await showDatePicker(
    initialDatePickerMode: DatePickerMode.day,
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
    builder: (BuildContext context, Widget child) => Theme(
      data: ThemeData(
        primaryColor: Theme.of(context).primaryColor,
        selectedRowColor: Theme.of(context).primaryColor,
        textSelectionColor: Theme.of(context).primaryColor,
      ),
      child: child,
    ),
  );
}

Future<TimeOfDay> selectTime(context, TimeOfDay time) async {
  return await showTimePicker(
    context: context,
    initialTime: time,
    builder: (BuildContext context, Widget child) => Theme(
      data: ThemeData(
        primaryColor: Theme.of(context).primaryColor,
        selectedRowColor: Theme.of(context).primaryColor,
        textSelectionColor: Theme.of(context).primaryColor,
      ),
      child: child,
    ),
  );
}
