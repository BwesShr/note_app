import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:todo_app/utils/utils.dart';

class MonthName extends StatefulWidget {
  MonthName({
    Key key,
    @required this.onMonthPressed,
  }) : super(key: key);

  final ValueChanged<int> onMonthPressed;

  @override
  _MonthNameState createState() => _MonthNameState();
}

class _MonthNameState extends State<MonthName> {
  AutoScrollController _controller;
  int _selectedMonth;
  final scrollDirection = Axis.horizontal;
  final _functions = CommonFunctions();

  @override
  void initState() {
    _controller = AutoScrollController(axis: scrollDirection);
    _selectedMonth = DateTime.now().month;
    _scrollToIndex();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print('month: $_selectedMonth');
    return Container(
      height: height * 0.08,
      child: ListView.builder(
        itemCount: 12,
        controller: _controller,
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          return AutoScrollTag(
            key: ValueKey(index),
            controller: _controller,
            index: index,
            child: GestureDetector(
              onTap: () {
                widget.onMonthPressed(index + 1);
                setState(() {
                  _selectedMonth = index + 1;
                  _scrollToIndex();
                });
              },
              child: Container(
                width: width / 6,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  _functions.getMonth(index),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                      color: (index + 1) == _selectedMonth
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.2)),
                ),
              ),
            ),
            highlightColor: Colors.black.withOpacity(0.1),
          );
        },
      ),
    );
  }

  Future _scrollToIndex() async {
    await _controller.scrollToIndex(_selectedMonth - 3,
        preferPosition: AutoScrollPosition.begin);
  }
}
