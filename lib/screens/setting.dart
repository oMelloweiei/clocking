import 'package:clockify_project/screens/tabs/settings/general.dart';
import 'package:clockify_project/screens/tabs/settings/notification.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Widget? showingtab;
  String? onshow;

  @override
  void initState() {
    super.initState();
    showingtab = GeneralSettingsTab();
    onshow = 'GENERAL';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 36, horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Setting',
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showingtab = GeneralSettingsTab();
                      onshow = 'GENERAL';
                    });
                  },
                  child: Container(
                    color:
                        onshow == 'GENERAL' ? Colors.white : Colors.grey[200],
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Text('GENERAL'),
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showingtab = NotificationSettingsTab();
                      onshow = 'NOTIFICATION';
                    });
                  },
                  child: Container(
                    color: onshow == 'NOTIFICATION'
                        ? Colors.white
                        : Colors.grey[200],
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Text('NOTIFICATION'),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(30),
              child: showingtab, // Display the selected tab content here
            ),
          ],
        ),
      ),
    ));
  }
}
