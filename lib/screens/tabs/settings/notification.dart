import 'package:flutter/material.dart';

class NotificationSettingsTab extends StatefulWidget {
  const NotificationSettingsTab({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsTab> createState() =>
      _NotificationSettingsTabState();
}

class _NotificationSettingsTabState extends State<NotificationSettingsTab> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage notifications',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Choose what types of email notifications you wish to receive.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 10),
        buildNotificationOption('Newsletter',
            'Receive a monthly email about new features in Clockify.'),
        SizedBox(height: 10),
        buildNotificationOption('Onboarding',
            'Receive an email series about key features and activities upon joining Clockify.'),
        SizedBox(height: 10),
        buildNotificationOption('Weekly report',
            'Receive a weekly email about your time tracking activities.'),
        SizedBox(height: 10),
        buildNotificationOption('Long-running timer',
            'Receive an email when a time entry is running more than 8 hours.'),
        SizedBox(height: 10),
        buildNotificationOption('Alerts',
            'Receive an email when a project or task reaches a certain percentage of its estimated time or budget.'),
        SizedBox(height: 10),
        buildNotificationOption('Reminders',
            'Receive an email when you or your teammates miss or go over time tracking targets or forget to submit / approve timesheets & expenses.'),
        SizedBox(height: 10),
        buildNotificationOption(
            'Schedule', 'Receive an email about your scheduled assignments.'),
      ],
    );
  }

  Widget buildNotificationOption(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
