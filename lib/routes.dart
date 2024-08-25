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

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage buildCustomPage(Widget child) {
  return CustomTransitionPage(
    transitionDuration: Duration(milliseconds: 300),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeIn).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 0.1), // Start position (slightly off-screen)
            end: Offset.zero, // End position (on-screen)
          ).animate(animation),
          child: child,
        ),
      );
    },
  );
}

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
              builder: (context, state) => TimeTrackerScreen(),
            ),
            GoRoute(
              path: '/calendar',
              parentNavigatorKey: _homeNavigatorKey,
              builder: (context, state) => CalendarScreen(),
            ),
            GoRoute(
              path: '/tag',
              parentNavigatorKey: _homeNavigatorKey,
              builder: (context, state) => TagsScreen(),
            ),
            GoRoute(
              path: '/client',
              parentNavigatorKey: _homeNavigatorKey,
              builder: (context, state) => ClientsScreen(),
            ),
            GoRoute(
                path: '/project',
                parentNavigatorKey: _homeNavigatorKey,
                builder: (context, state) => ProjectsScreen(),
                routes: [
                  GoRoute(
                    path: 'property_:name',
                    parentNavigatorKey: _homeNavigatorKey,
                    builder: (context, state) {
                      final project_id = state.extra as String;
                      return ProjectProperty(projectId: project_id);
                    },
                  )
                ]),
            GoRoute(
              path: '/kiosk',
              parentNavigatorKey: _homeNavigatorKey,
              builder: (context, state) => KiosksScreen(),
            ),
            GoRoute(
              path: '/timesheet',
              parentNavigatorKey: _homeNavigatorKey,
              builder: (context, state) => TimesheetScreen(),
            ),
            GoRoute(
              path: '/editprofile',
              parentNavigatorKey: _homeNavigatorKey,
              builder: (context, state) => ProfileScreen(),
            ),
            GoRoute(
              path: '/user_setting',
              parentNavigatorKey: _homeNavigatorKey,
              builder: (context, state) => SettingScreen(),
            ),
          ])
    ]);
