import 'package:intl/intl.dart';

class Strings {
  static const appName = 'Todo App';

  static const btnSave = 'Save';
  static const btnCancel = 'Cancel';
  static const taskTitle = 'Task';
  static const addTaskTitle = 'Add Task';
  static const title = 'Title';
  static const note = 'Note';
  static String date = 'Date';
  static String dueDate = 'Due date';
  static String repeat = 'Repeat';
  static String status = 'Status';
  static String completed = 'Completed';

  static String ongoing = 'Ongoing';

  static List<String> repeatList = [
    'Do not Repeat',
    'Once a day',
    'Once a week',
    'Once a month',
    'Once a month'
  ];
}

class RouteName {
  static const initialRoute = '/';
  static const addTaskRoute = '/task';
  static const taskDetailRoute = '/task/detail';
}

class Format {
  static final dayMonthFormat = DateFormat('d, MMM');
  static final dateFormat = DateFormat('yyyy-MM-dd');
  static final dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:00');
  static final displayDateFormat = DateFormat('dd, MMM yyyy');
  static final dayDateFormat = DateFormat('EEE dd, MMM yyyy');
  static final weekName = DateFormat('E');
  static final timeStampFormat = DateFormat('h:mm a');
}
