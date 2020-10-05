import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/utils/utils.dart';

class DBHelper {
  // Database Version
  static int DATABASE_VERSION = 1;

  // Database Name
  static String DATABASE_NAME = Strings.appName + '.db';

  static String TABLE_TASK = 'task';
  static String TABLE_TASK_REMINDERS = 'task_reminder';

  // Column names
  static String KEY_ID = 'id';
  static String KEY_TITLE = 'title';
  static String KEY_NOTE = 'note';
  static String KEY_DATE_TIME = 'date_time';
  static String KEY_COMPLETED = 'completed';
  static String KEY_REPEATS = 'repeats';
  static String KEY_REMINDERS = 'reminders';

  static String CREATE_TABLE_TASK = 'CREATE TABLE $TABLE_TASK (' +
      '$KEY_ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
      '$KEY_TITLE TEXT,' +
      '$KEY_NOTE TEXT,' +
      '$KEY_DATE_TIME TEXT,' +
      '$KEY_COMPLETED INTEGER,' +
      '$KEY_REPEATS TEXT)';

  static String CREATE_TABLE_TASK_REMINDERS =
      'CREATE TABLE $TABLE_TASK_REMINDERS (' +
          '$KEY_ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
          '$KEY_REMINDERS TEXT)';

  static DBHelper _dbHelper; // Singleton DBHelper
  static Database _db;

  DBHelper._createInstance(); // Named constructor to create instance of DBHelper

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _dbHelper;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  // Creating a database with name lfc_alarm.db in your directory
  Future<Database> initDb() async {
    // Get the directory for both android and ios to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DATABASE_NAME);

    // Open/Create the database at a given path
    _db = await openDatabase(path,
        version: DATABASE_VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return _db;
  }

  // UPGRADE DATABASE TABLES
  Future<int> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();

    batch.execute('DROP TABLE IF EXISTS $TABLE_TASK');

    batch.execute(CREATE_TABLE_TASK);
    List<dynamic> result = await batch.commit();
  }

  Future<int> _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(CREATE_TABLE_TASK);
  }

  ///Helper function method
  Future<int> deleteAllTasks() async {
    _db = await db;
    var taskResult = await _db.delete(TABLE_TASK);
    var result = await _db.delete(TABLE_TASK_REMINDERS);
    return taskResult;
  }

  Future<int> deleteTaskById(int id) async {
    _db = await db;
    var taskResult = await _db.delete(TABLE_TASK);
    var result = await _db
        .delete(TABLE_TASK_REMINDERS, where: '$KEY_ID = ?', whereArgs: [id]);
    return taskResult;
  }

  Future<int> addTask(Task task) async {
    _db = await db;
    var result = await _db.insert(TABLE_TASK, task.toMap());
    return result;
  }

  Future<int> addTaskReminders(Reminder reminder) async {
    _db = await db;
    var result = await _db.insert(TABLE_TASK_REMINDERS, reminder.toMap());
    return result;
  }

  Future<List<Reminder>> getTaskReminderss(int id) async {
    _db = await db;
    var result = await _db
        .query(TABLE_TASK_REMINDERS, where: '$KEY_ID = ?', whereArgs: [id]);

    List<Reminder> reminders = new List();
    for (var item in result) {
      reminders.add(Reminder.fromMap(item));
    }
    return reminders;
  }

  Future<List<Task>> getAllTasks() async {
    _db = await db;
    var result = await _db.query(TABLE_TASK);

    List<Task> tasks = new List();
    for (var item in result) {
      tasks.add(Task.fromMap(item));
    }
    return tasks;
  }

  Future<List<Task>> getTasksByDate(DateTime date) async {
    _db = await db;
    String formattedDate = Format.dateFormat.format(date);

    var result = await _db.query(TABLE_TASK,
        where: 'strftime(\'%Y-%m-%d\', $KEY_DATE_TIME) =?',
        whereArgs: [formattedDate]);
    // var result = await _db.rawQuery(
    //     'SELECT * FROM $TABLE_TASK WHERE strftime(\'%Y-%m-%d\', $KEY_DATE_TIME) = \'$formattedDate\'');

    List<Task> tasks = new List();
    for (var item in result) {
      tasks.add(Task.fromMap(item));
    }
    return tasks;
  }
}
