import 'package:clockify_project/color.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: screenBG,
      child: Center(
        child: Text('CalendarScreen'),
      ),
    );
  }
}
