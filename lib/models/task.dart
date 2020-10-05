import 'package:todo_app/models/models.dart';

class Task {
  int taskId;
  String title;
  String note;
  String dateTime;
  bool completed;
  String repeat;
  List<Reminder> reminders;

  Task({
    this.taskId,
    this.title,
    this.note,
    this.dateTime,
    this.completed,
    this.repeat,
    this.reminders,
  });

  Task.fromMap(Map<String, dynamic> map) {
    this.taskId = map['id'];
    this.title = map['title'];
    this.note = map['note'];
    this.dateTime = map['date_time'];
    this.completed = map['completed'] == 1 ? true : false;
    this.repeat = map['repeats'];
  }

  Map<String, dynamic> toMap() => {
        'id': taskId == null ? null : taskId,
        'title': title,
        'note': note,
        'date_time': dateTime,
        'completed': completed ? 1 : 0,
        'repeats': repeat,
      };
}
