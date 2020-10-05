import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:todo_app/utils/utils.dart';

class WeekNumber extends StatefulWidget {
  WeekNumber({
    Key key,
    @required this.onWeekPressed,
  }) : super(key: key);

  final ValueChanged<int> onWeekPressed;

  @override
  _WeekNumberState createState() => _WeekNumberState();
}

class _WeekNumberState extends State<WeekNumber> {
  AutoScrollController _controller;
  int _selectedWeekNumber;
  final scrollDirection = Axis.horizontal;

  @override
  void initState() {
    _controller = AutoScrollController(axis: scrollDirection);
    _getWeekNumber(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: 120,
      child: ListView.builder(
        itemCount: 52,
        controller: _controller,
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          return AutoScrollTag(
            key: ValueKey(index),
            controller: _controller,
            index: index,
            child: GestureDetector(
              onTap: () {
                widget.onWeekPressed(index + 1);
                setState(() {
                  _selectedWeekNumber = index + 1;
                  _scrollToIndex();
                });
              },
              child: Container(
                width: width / 3,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Week',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      (index + 1).toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: width * 0.15,
                          color: (index + 1) == _selectedWeekNumber
                              ? textPrimaryColor
                              : textPrimaryColor.withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
            ),
            highlightColor: Colors.black.withOpacity(0.1),
          );
        },
      ),
    );
  }

  void _getWeekNumber(DateTime now) {
    // set it to feb 10th for testing
    //now = now.add(new Duration(days:7));
    int today = now.weekday;
    // ISO week date weeks start on monday
    // so correct the day number
    int dayNumber = (today + 6) % 7;

    // ISO 8601 states that week 1 is the week
    // with the first thursday of that year.
    // Set the target date to the thursday in the target week
    DateTime startOfWeek = now.subtract(new Duration(days: dayNumber));

    // Set the target to the first thursday of the year
    // First set the target to january first
    DateTime firstThursday = new DateTime(now.year, DateTime.january, 1);

    if (firstThursday.weekday != (DateTime.thursday)) {
      firstThursday = new DateTime(now.year, DateTime.january,
          1 + ((4 - firstThursday.weekday) + 7) % 7);
    }

    // The weeknumber is the number of weeks between the
    // first thursday of the year and the thursday in the target week
    int weekNumber =
        startOfWeek.add(new Duration(days: 3)).millisecondsSinceEpoch -
            firstThursday.millisecondsSinceEpoch;
    double weekCount =
        weekNumber.ceil() / 604800000; // 604800000 = 7 * 24 * 3600 * 1000

    // print("Todays date: ${now}");
    // print("Start of this week: ${thisMonday}");
    // print("End of this week: ${thisMonday.add(Duration(days: 6))}");

    _selectedWeekNumber = weekCount.ceil();
    _scrollToIndex();
  }

  Future _scrollToIndex() async {
    await _controller.scrollToIndex(_selectedWeekNumber - 2,
        preferPosition: AutoScrollPosition.begin);
  }
}
