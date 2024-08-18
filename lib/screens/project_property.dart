import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/screens/tabs/project_properties/access.dart';
import 'package:clockify_project/screens/tabs/project_properties/note.dart';
import 'package:clockify_project/screens/tabs/project_properties/setting.dart';
import 'package:clockify_project/screens/tabs/project_properties/status.dart';
import 'package:clockify_project/screens/tabs/project_properties/task.dart';
import 'package:flutter/material.dart';

class ProjectProperty extends StatefulWidget {
  final Project project;
  ProjectProperty({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectProperty> createState() => _ProjectPropertyState();
}

class _ProjectPropertyState extends State<ProjectProperty> {
  Widget? showingtab;
  String? onshow;

  @override
  void initState() {
    super.initState();
    // showingtab = TaskTab();
    onshow = 'TASK';
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //       child: Center(
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 36, horizontal: 36),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             widget.project.name,
  //             style: TextStyle(fontSize: 36),
  //           ),
  //           SizedBox(height: 30),
  //           Row(
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     showingtab = TaskTab();
  //                     onshow = 'TASK';
  //                   });
  //                 },
  //                 child: Container(
  //                   color: onshow == 'TASK' ? Colors.white : Colors.grey[200],
  //                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
  //                   child: Text('TASK'),
  //                 ),
  //               ),
  //               SizedBox(width: 15),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     showingtab = AccessTab();
  //                     onshow = 'ACCESS';
  //                   });
  //                 },
  //                 child: Container(
  //                   color: onshow == 'ACCESS' ? Colors.white : Colors.grey[200],
  //                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
  //                   child: Text('ACCESS'),
  //                 ),
  //               ),
  //               SizedBox(width: 15),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     showingtab = StatusTab();
  //                     onshow = 'STATUS';
  //                   });
  //                 },
  //                 child: Container(
  //                   color: onshow == 'STATUS' ? Colors.white : Colors.grey[200],
  //                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
  //                   child: Text('STATUS'),
  //                 ),
  //               ),
  //               SizedBox(width: 15),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     showingtab = NoteTab();
  //                     onshow = 'NOTE';
  //                   });
  //                 },
  //                 child: Container(
  //                   color: onshow == 'NOTE' ? Colors.white : Colors.grey[200],
  //                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
  //                   child: Text('NOTE'),
  //                 ),
  //               ),
  //               SizedBox(width: 15),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     showingtab = SettingTab();
  //                     onshow = 'SETTING';
  //                   });
  //                 },
  //                 child: Container(
  //                   color:
  //                       onshow == 'SETTING' ? Colors.white : Colors.grey[200],
  //                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
  //                   child: Text('SETTING'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             color: Colors.white,
  //             padding: EdgeInsets.all(30),
  //             child: showingtab, // Display the selected tab content here
  //           ),
  //         ],
  //       ),
  //     ),
  //   ));
  // }
}
