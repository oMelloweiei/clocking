import 'package:clockify_project/component/color_dropdown.dart';
import 'package:clockify_project/data/controller/project/projectsettingController.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingTab extends StatefulWidget {
  final Project project;
  const SettingTab({Key? key, required this.project}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final ProjectSettingController _projectSettingController =
      Get.put(ProjectSettingController());

  @override
  void initState() {
    super.initState();
    _projectSettingController.loadProjectSetting(widget.project.id);

    _nameController.text = widget.project.name;
    _rateController.text =
        '${_projectSettingController.projectSetting.value.billablerate}';
  }

  bool active = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final projectSetting = _projectSettingController.projectSetting.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  hintText: 'Change project name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty || value == widget.project.name) {
                    _projectSettingController.updatename(
                        widget.project.id, value);
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Client',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Used for grouping similar projects together.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 10),
            _buildDropdownButton(widget.project.clientKey),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Color',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Use color to visually differentiate projects.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 10),
            ColorDropdownButton(
              initialColor: projectSetting.color,
              onColorSelected: (Color color) {
                _projectSettingController.updateColor(color);
              },
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Billable by default',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'All new entries on this project will be initially set as billable.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 10),
            Switch(
              value: projectSetting.onBillable,
              activeColor: Colors.blue,
              onChanged: (bool value) {
                setState(() {
                  projectSetting.onBillable = value;
                });
              },
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Project billable rate',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Billable rate used for calculating billable amount for this project.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 10),
            Text(
              'Hourly rate (USD)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _rateController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  hintText: _rateController.text,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Project estimate',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Choose how you wish to track project progress (time or fixed fee budget).',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 10),
            _buildDropdownButton(projectSetting.estimate),
          ],
        );
      }),
    );
  }

  Widget _buildDropdownButton(String currentValue) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: (String? newValue) {
        // Handle assignment change
      },
      items: <String>[currentValue, 'User1', 'User2']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
      style: TextStyle(color: Colors.blue),
    );
  }
}
