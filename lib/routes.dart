import 'package:clockify_project/screens/user_selection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

// class AppRoutes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => UserSelection());
//       case '/users':
//         return MaterialPageRoute(builder: (_) => UserSelection());
//       case '/home':
//         return MaterialPageRoute(builder: (_) => HomeScreen());
//       case '/profile':
//         return MaterialPageRoute(builder: (_) => ProfileScreen());
//       case '/project_property':
//         final project = settings.arguments as dynamic;
//         return MaterialPageRoute(
//             builder: (_) => ProjectProperty(project: project));
//       case '/setting':
//         return MaterialPageRoute(builder: (_) => SettingScreen());
//       case '/calendar':
//         return MaterialPageRoute(builder: (_) => const CalendarScreen());
//       case '/clients':
//         return MaterialPageRoute(builder: (_) => const ClientsScreen());
//       case '/kiosks':
//         return MaterialPageRoute(builder: (_) => const KiosksScreen());
//       case '/projects':
//         return MaterialPageRoute(builder: (_) => ProjectsScreen());
//       case '/tags':
//         return MaterialPageRoute(builder: (_) => const TagsScreen());
//       case '/timesheet':
//         return MaterialPageRoute(builder: (_) => const TimesheetScreen());
//       case '/timetracker':
//         return MaterialPageRoute(builder: (_) => const TimeTrackerScreen());
//       default:
//         return MaterialPageRoute(builder: (_) => HomeScreen());
//     }
//   }
// }

class AppRoutes {
  static const initialRoute = '/home';

  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      children: [
        GetPage(name: '/timetracker', page: () => TimeTrackerScreen()),
        GetPage(name: '/calendar', page: () => CalendarScreen()),
        GetPage(name: '/tags', page: () => TagsScreen()),
        GetPage(name: '/clients', page: () => ClientsScreen()),
        GetPage(name: '/projects', page: () => ProjectsScreen()),
        GetPage(name: '/kiosks', page: () => KiosksScreen()),
        GetPage(name: '/timesheets', page: () => TimesheetScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/setting', page: () => SettingScreen()),
        GetPage(
          name: '/project_property',
          page: () => ProjectProperty(project: Get.arguments),
        ),
      ],
    ),
  ];
}
