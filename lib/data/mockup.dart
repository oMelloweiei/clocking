/* ----- Content ------ */
import 'package:flutter/material.dart';

var content = [
  {
    'topic': 'TimeTracker',
    'type': 'tracker',
    'icon': Icons.access_time_outlined,
    'route': '/timetracker'
  },
  {
    'topic': 'Calendar',
    'type': 'tracker',
    'icon': Icons.calendar_today_outlined,
    'route': '/calendar'
  },
  {
    'topic': 'Tags',
    'type': 'manage',
    'icon': Icons.access_time_outlined,
    'route': '/tag'
  },
  {
    'topic': 'Clients',
    'type': 'manage',
    'icon': Icons.person_outline,
    'route': '/client'
  },
  {
    'topic': 'Projects',
    'type': 'manage',
    'icon': Icons.access_time_outlined,
    'route': '/project'
  },
  {
    'topic': 'Kiosks',
    'type': 'manage',
    'icon': Icons.access_time_outlined,
    'route': '/kiosk'
  },
  {
    'topic': 'Timesheets',
    'type': 'manage',
    'icon': Icons.access_time_outlined,
    'route': '/timesheet'
  },
];

var popProfileContent = [
  {'topic': 'Profile', 'route': '/editprofile'},
  {'topic': 'Setting', 'route': '/user_setting'},
  {'topic': 'Log out', 'route': '/login'},
];
