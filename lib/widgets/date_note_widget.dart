import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/utils/utils.dart';

class DateNotesWidget extends StatelessWidget {
  DateNotesWidget({
    Key key,
    @required this.date,
  }) : super(key: key);

  final DateTime date;

  final _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _dbHelper.getTasksByDate(date),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5.0,
              childAspectRatio: 10 / 20,
            ),
            itemBuilder: (context, index) {
              Task task = snapshot.data[index];

              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(RouteName.taskDetailRoute, arguments: task),
                child: Card(
                  margin: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          task.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 12.0),
                        ),
                        SizedBox(height: 10.0),
                        task.completed
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  FontAwesomeIcons.checkCircle,
                                  color: Theme.of(context).accentColor,
                                ),
                              )
                            : Offstage(),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 12.0),
                              children: [
                                TextSpan(
                                  text: Strings.note,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(fontSize: 12.0),
                                ),
                                TextSpan(text: ':\n'),
                                TextSpan(text: task.note),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Format.displayDateFormat
                                  .format(DateTime.parse(task.dateTime)),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 6.0),
                            ),
                            Text(
                              Format.timeStampFormat
                                  .format(DateTime.parse(task.dateTime)),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 6.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
