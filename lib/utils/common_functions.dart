import 'package:flutter/material.dart';

class CommonFunctions {
  List<String> monthName = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];

  String getMonth(int index) => monthName[index];

  TimeOfDay parseTimeOfDay(String startTime) {
    return TimeOfDay(
      hour: int.parse(startTime.split(":")[0]),
      minute: int.parse(startTime.split(":")[1]),
    );
  }
}
