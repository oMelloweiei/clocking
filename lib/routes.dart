import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import 'screens/user_selection.dart';
import 'data/models/project/project.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _projectNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
          path: '/login',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => UserSelection()),
      ShellRoute(
          parentNavigatorKey: _rootNavigatorKey,
          navigatorKey: _homeNavigatorKey,
          builder: (context, state, child) => SidebarScaffold(child: child),
          routes: [
            GoRoute(
                path: '/timetracker',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => TimeTrackerScreen()),
            GoRoute(
                path: '/calendar',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => CalendarScreen()),
            GoRoute(
                path: '/tag',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => TagsScreen()),
            GoRoute(
                path: '/client',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => ClientsScreen()),
            GoRoute(
                path: '/project',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => ProjectsScreen()),
            GoRoute(
                path: '/kiosk',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => KiosksScreen()),
            GoRoute(
                path: '/timesheet',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => TimesheetScreen()),
          ])
    ]);
