import 'package:clockify_project/color.dart';
import 'package:flutter/material.dart';

class TimesheetScreen extends StatelessWidget {
  const TimesheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: screenBG,
      child: Center(
        child: Text('TimesheetScreen'),
      ),
    );
  }
}
