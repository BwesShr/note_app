import 'package:flutter/material.dart';

class Reminder {
  int id;
  DateTime reminder;

  Reminder({
    @required this.id,
    @required this.reminder,
  });

  Reminder.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.reminder = map['reminder'];
  }

  Map<String, dynamic> toMap() => {
        'id': id == null ? null : id,
        'reminders': reminder,
      };
}
