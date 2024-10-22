import 'package:clockify_project/data/models/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:clockify_project/data/models/client/client.dart';
import 'package:clockify_project/data/models/history/history.dart';
import 'package:clockify_project/data/models/entry/entry.dart';
import 'package:clockify_project/data/models/notification_setting/user_notification_setting.dart';

import 'package:clockify_project/data/models/user/user.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/data/models/tag/tag.dart';
import 'package:clockify_project/data/models/timetrack/timetrack.dart';
import 'package:clockify_project/fortest.dart';
import 'package:get/get.dart';
import 'package:clockify_project/routes.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:clockify_project/texttheme.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import the Hive setup

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(TimetrackAdapter());
  Hive.registerAdapter(HistoryAdapter());
  Hive.registerAdapter(ClientAdapter());
  Hive.registerAdapter(KioskAdapter());
  Hive.registerAdapter(NotificationListAdapter());
  Hive.registerAdapter(UserNotificationAdapter());

  // Open boxes
  await Hive.openBox<User>('users');
  await Hive.openBox<Project>('projects');
  await Hive.openBox<Tag>('tags');
  await Hive.openBox<Timetrack>('timetracks');
  await Hive.openBox<History>('histories');
  await Hive.openBox<Client>('clients');
  await Hive.openBox<Kiosk>('kiosks');
  await Hive.openBox<NotificationList>('notifications');
  await Hive.openBox<UserNotification>('notificationSettings');

  // Initialize sample data (optional)
  await initializeSampleData();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        final isMobile = MediaQuery.of(context).size.shortestSide < 600;
        return ScreenConfig(
          isMobile: isMobile,
          isPortrait: isPortrait,
          child: GetMaterialApp(
            theme: ThemeData(
              textTheme: AppTextTheme.lightTextTheme,
            ),
            initialRoute: '/',
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
