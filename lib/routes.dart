import 'package:clockify_project/screens/user_selection.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/project_property.dart';
import 'screens/setting.dart';
import 'screens/calendar.dart';
import 'screens/clients.dart';
import 'screens/kiosks.dart';
import 'screens/projects.dart';
import 'screens/tags.dart';
import 'screens/timesheet.dart';
import 'screens/timetracker.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // สร้าง ชี้ไปที่ login
      case '/':
        return MaterialPageRoute(builder: (_) => UserSelection());
      case '/users':
        return MaterialPageRoute(builder: (_) => UserSelection());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/project_property':
        final project = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => ProjectProperty(project: project));
      case '/setting':
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => const CalendarScreen());
      case '/clients':
        return MaterialPageRoute(builder: (_) => const ClientsScreen());
      case '/kiosks':
        return MaterialPageRoute(builder: (_) => const KiosksScreen());
      case '/projects':
        return MaterialPageRoute(builder: (_) => ProjectsScreen());
      case '/tags':
        return MaterialPageRoute(builder: (_) => const TagsScreen());
      case '/timesheet':
        return MaterialPageRoute(builder: (_) => const TimesheetScreen());
      case '/timetracker':
        return MaterialPageRoute(builder: (_) => const TimeTrackerScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
