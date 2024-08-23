import 'package:clockify_project/data/controller/project/projectController.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/screens/tabs/project_properties/access.dart';
import 'package:clockify_project/screens/tabs/project_properties/note.dart';
import 'package:clockify_project/screens/tabs/project_properties/setting.dart';
import 'package:clockify_project/screens/tabs/project_properties/status.dart';
import 'package:clockify_project/screens/tabs/project_properties/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProjectTab { TASK, ACCESS, STATUS, NOTE, SETTING }

class ProjectProperty extends StatefulWidget {
  final String project_id;
  ProjectProperty({Key? key, required this.project_id}) : super(key: key);

  @override
  State<ProjectProperty> createState() => _ProjectPropertyState();
}

class _ProjectPropertyState extends State<ProjectProperty> {
  ProjectTab currentTab = ProjectTab.TASK;

  final ProjectController projectController = Get.put(ProjectController());
  late Rx<Project> _project;

  final Map<ProjectTab, Widget> _tabs = {};

  @override
  void initState() {
    super.initState();
    final project = projectController.getProjectById(widget.project_id);
    if (project != null) {
      _project = project.obs;
    }

    _tabs[ProjectTab.TASK] = TaskTab(project: _project.value);
    _tabs[ProjectTab.ACCESS] = AccessTab(project: _project.value);
    _tabs[ProjectTab.STATUS] = StatusTab(project: _project.value);
    _tabs[ProjectTab.NOTE] = NoteTab(project: _project.value);
    _tabs[ProjectTab.SETTING] = SettingTab(project: _project.value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _project.value.name,
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              children:
                  ProjectTab.values.map((tab) => _buildTabButton(tab)).toList(),
            ),
            Container(
              constraints: BoxConstraints(
                  minWidth: double.maxFinite,
                  minHeight: MediaQuery.of(context).size.height * 0.65),
              color: Colors.white,
              padding: const EdgeInsets.all(30),
              child: _tabs[currentTab],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(ProjectTab tab) {
    final tabName = tab.name;
    return GestureDetector(
      onTap: () => setState(() => currentTab = tab),
      child: Container(
        color: currentTab == tab ? Colors.white : Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Text(tabName),
      ),
    );
  }
}
