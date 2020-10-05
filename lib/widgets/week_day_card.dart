import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/utils/utils.dart';

class WeekDayCard extends StatelessWidget {
  WeekDayCard({
    Key key,
    @required this.startOfWeek,
    @required this.selectedDate,
    @required this.onDayPressed,
  }) : super(key: key);

  final DateTime startOfWeek;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDayPressed;
  final _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.15,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          DateTime date = startOfWeek.add(Duration(days: index));

          return GestureDetector(
            onTap: () => onDayPressed(date),
            child: Container(
              width: width / 7.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Format.weekName.format(date),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Format.dateFormat.format(selectedDate) ==
                                Format.dateFormat.format(date)
                            ? Color(0xFF3F3E3E).withOpacity(0.7)
                            : Color(0xFF3F3E3E),
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Text(
                            Format.dayMonthFormat.format(date),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: 8.0, color: textSecondaryColor),
                          ),
                          FutureBuilder<List<Task>>(
                            future: _dbHelper.getTasksByDate(date),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      Divider(color: Colors.white),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
