import 'package:clockify_project/color.dart';
import 'package:clockify_project/component/appbar.dart';
import 'package:clockify_project/component/sidebar.dart';
import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:clockify_project/screens/calendar.dart';
import 'package:clockify_project/screens/clients.dart';
import 'package:clockify_project/screens/kiosks.dart';
import 'package:clockify_project/screens/profile.dart';
import 'package:clockify_project/screens/project_property.dart';
import 'package:clockify_project/screens/projects.dart';
import 'package:clockify_project/screens/setting.dart';
import 'package:clockify_project/screens/tags.dart';
import 'package:clockify_project/screens/timesheet.dart';
import 'package:clockify_project/screens/timetracker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String _selectedWidget = 'TimeTracker';
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final screenConfig = ScreenConfig.of(context);
    final isPortrait = screenConfig.isPortrait;
    final isMobile = screenConfig.isMobile;
    return Scaffold(
      appBar: MyAppBar(
        isPortrait: isPortrait,
        navigatorKey: _navigatorKey,
        onSelected: (String selectedNav) {
          setState(() {
            _selectedWidget = selectedNav;
          });
        },
        userController: userController,
      ),
      drawer: isMobile
          ? Sidebar(
              selectedWidget: _selectedWidget,
              onWidgetSelected: _onWidgetSelected)
          : null,
      body: Row(
        children: [
          if (!isPortrait && !isMobile)
            Sidebar(
                selectedWidget: _selectedWidget,
                onWidgetSelected: _onWidgetSelected),
          Expanded(
            child: Container(
              color: screenBG,
              child: Navigator(
                key: _navigatorKey,
                onGenerateRoute: (routeSettings) {
                  return _buildPageRoute(routeSettings);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onWidgetSelected(String topic) {
    // print(topic);
    setState(() {
      _selectedWidget = topic;
    });

    _navigatorKey.currentState?.pushReplacementNamed('/$topic');
  }

  PageRouteBuilder _buildPageRoute(RouteSettings routeSettings) {
    Widget widget;

    switch (routeSettings.name!.toLowerCase()) {
      case '/timetracker':
        widget = const TimeTrackerScreen();
        break;
      case '/calendar':
        widget = const CalendarScreen();
        break;
      case '/tags':
        widget = const TagsScreen();
        break;
      case '/clients':
        widget = const ClientsScreen();
        break;
      case '/projects':
        widget = ProjectsScreen();
        break;
      case '/kiosks':
        widget = const KiosksScreen();
        break;
      case '/timesheets':
        widget = const TimesheetScreen();
        break;
      case '/profile':
        widget = ProfileScreen();
        break;
      case '/setting':
        widget = SettingScreen();
        break;
      case '/project_property':
        final project = routeSettings.arguments as dynamic;
        widget = ProjectProperty(project: project);
        break;
      default:
        widget = const TimeTrackerScreen();
        break;
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.05);
        const end = Offset.zero;
        var slideTween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeInOut));
        var fadeInAnimation =
            animation.drive(Tween<double>(begin: 0.0, end: 1.0));
        var fadeOutAnimation =
            secondaryAnimation.drive(Tween<double>(begin: 1.0, end: 0.0));

        return SlideTransition(
          position: slideTween.animate(animation),
          child: FadeTransition(
            opacity: fadeInAnimation,
            child: FadeTransition(
              opacity: fadeOutAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
