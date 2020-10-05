import 'package:flutter/material.dart';
import 'package:todo_app/utils/utils.dart';

import 'ui/main_screen.dart';
import 'ui/add_task.dart';
import 'ui/task_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        primaryColorDark: primaryDarkColor,
        accentColor: accentColor,
        backgroundColor: Colors.white,
        buttonColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: textPrimaryColor,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RouteName.initialRoute,
      onGenerateRoute: generatedRoutes,
    );
  }

  Route generatedRoutes(RouteSettings settings) {
    String routeName = settings.name;
    switch (routeName) {
      case RouteName.initialRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case RouteName.addTaskRoute:
        return MaterialPageRoute(
            builder: (_) => AddTask(
                  dueDate: settings.arguments,
                ));
      case RouteName.taskDetailRoute:
        return MaterialPageRoute(
            builder: (_) => TaskDetail(
                  task: settings.arguments,
                ));

      default:
        return MaterialPageRoute(builder: (_) => MainScreen());
    }
  }
}
