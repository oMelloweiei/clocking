import 'package:clockify_project/component/color_dropdown.dart';
import 'package:clockify_project/data/controller/project/projectsettingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  final TextEditingController _controller = TextEditingController();
  final ProjectSettingController _projectSettingController =
      Get.put(ProjectSettingController());

  bool active = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
              controller: _controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                hintText: 'Name',
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
            'Client',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            'Used for grouping similar projects together.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 10),
          _buildDropdownButton('HDG'),
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
          ColorDropdownButton(),
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
            value: active,
            activeColor: Colors.blue,
            onChanged: (bool value) {
              setState(() {
                active = value;
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
              controller: _controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                hintText: 'Name',
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
          _buildDropdownButton('No estimate'),
        ],
      ),
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
