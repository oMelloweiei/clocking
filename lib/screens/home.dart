import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockify_project/color.dart';
import 'package:clockify_project/component/appbar.dart';
import 'package:clockify_project/component/sidebar.dart';
import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/routes.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:clockify_project/screens/calendar.dart';
import 'package:clockify_project/screens/clients.dart';
import 'package:clockify_project/screens/kiosks.dart';
import 'package:clockify_project/screens/profile.dart';
import 'package:clockify_project/screens/projects.dart';
import 'package:clockify_project/screens/setting.dart';
import 'package:clockify_project/screens/tags.dart';
import 'package:clockify_project/screens/timesheet.dart';
import 'package:clockify_project/screens/timetracker.dart';
import 'package:go_router/go_router.dart';

class SidebarScaffold extends StatefulWidget {
  final Widget child;
  SidebarScaffold({required this.child});

  @override
  _SidebarScaffoldState createState() => _SidebarScaffoldState();
}

class _SidebarScaffoldState extends State<SidebarScaffold> {
  String _currentRoute = '/timetracker';
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final screenConfig = ScreenConfig.of(context);
    final isPortrait = screenConfig.isPortrait;
    final isMobile = screenConfig.isMobile;

    return Scaffold(
      appBar: MyAppBar(
        isPortrait: isPortrait,
        onSelected: _onWidgetSelected,
        userController: userController,
      ),
      drawer: isMobile
          ? Sidebar(
              selectedWidget: _currentRoute,
              onWidgetSelected: _onWidgetSelected,
            )
          : null,
      body: Row(
        children: [
          if (!isPortrait && !isMobile)
            Sidebar(
              selectedWidget: _currentRoute,
              onWidgetSelected: _onWidgetSelected,
            ),
          Expanded(
            child: Container(color: screenBG, child: widget.child),
          ),
        ],
      ),
    );
  }

  // Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  //   return PageRouteBuilder(
  //     pageBuilder: (_, __, ___) => _getPage(settings.name!),
  //     transitionDuration: const Duration(milliseconds: 500),
  //     transitionsBuilder: (_, animation, __, child) {
  //       return FadeTransition(
  //         opacity: animation,
  //         child: child,
  //       );
  //     },
  //   );
  // }

  void _onWidgetSelected(String route) {
    context.go(route);
    setState(() {
      _currentRoute = route;
    });
  }
}
