import 'package:clockify_project/data/controller/project/projectController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectPopup extends StatefulWidget {
  ProjectPopup({Key? key}) : super(key: key);

  @override
  _ProjectPopupState createState() => _ProjectPopupState();
}

class _ProjectPopupState extends State<ProjectPopup> {
  final List<int> dropdowntest = [1, 2, 3, 4];
  int? selectedDropdownValue;
  final ProjectController projectController = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(240, 45),
      icon: Icon(Icons.text_snippet_outlined),
      itemBuilder: (BuildContext context) {
        final projects = projectController.projects;
        List<PopupMenuEntry<String>> menuItems = [
          PopupMenuItem(
            enabled: false,
            child: Container(
              padding: EdgeInsets.all(4.0),
              width: 400,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_outlined),
                  hintText: 'Search project or client',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
        ];
        for (var project in projects) {
          menuItems.add(
            PopupMenuItem<String>(
              value: project.name,
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8),
                  SizedBox(width: 15),
                  Text(project.name),
                  Spacer(),
                  _getTask()
                ],
              ),
            ),
          );
        }

        return menuItems;
      },
    );
  }

  Widget _getTask() {
    return DropdownButton<int>(
      value: selectedDropdownValue,
      onChanged: (int? newValue) {
        setState(() {
          selectedDropdownValue = newValue;
        });
      },
      items: dropdowntest.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value task'),
        );
      }).toList(),
    );
  }
}
