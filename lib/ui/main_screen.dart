import 'package:flutter/material.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _startOfWeek;
  DateTime _selectedDate;
  final _dbHelper = DBHelper();

  @override
  void initState() {
    _getWeekStartDate(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.appName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: textSecondaryColor),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                          RouteName.addTaskRoute,
                          arguments: _selectedDate),
                      icon: Icon(
                        Icons.add,
                        size: height * 0.05,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                ),
                child: ListView(
                  children: [
                    WeekNumber(
                      onWeekPressed: (weekNumber) {
                        DateTime date = DateTime(DateTime.now().year, 1, 1);
                        date = date.add(Duration(days: (weekNumber - 1) * 7));
                        _getWeekStartDate(date);
                      },
                    ),
                    WeekDayCard(
                      startOfWeek: _startOfWeek,
                      selectedDate: _selectedDate,
                      onDayPressed: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    DateNotesWidget(
                      date: _selectedDate,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getWeekStartDate(DateTime today) {
    // ISO week date weeks start on monday
    // so correct the day number
    int dayNumber = (today.weekday + 6) % 7;

    // ISO 8601 states that week 1 is the week
    // with the first thursday of that year.
    // Set the target date to the thursday in the target week
    setState(() {
      _selectedDate = today;
      _startOfWeek = today.subtract(new Duration(days: dayNumber));
    });
  }
}
