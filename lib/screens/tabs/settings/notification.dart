import 'package:clockify_project/data/controller/notiSettingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingsTab extends StatelessWidget {
  const NotificationSettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotiSettingController _notiSettingController =
        Get.put(NotiSettingController());

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
        Obx(() => buildNotificationOption(
              context,
              'Newsletter',
              'Receive a monthly email about new features in Clockify.',
              _notiSettingController.notisettings.value.newsletter,
              (value) => _notiSettingController.updateNewsletter(value!),
            )),
        SizedBox(height: 10),
        Obx(() => buildNotificationOption(
              context,
              'Onboarding',
              'Receive an email series about key features and activities upon joining Clockify.',
              _notiSettingController.notisettings.value.onboarding,
              (value) => _notiSettingController.updateOnboarding(value!),
            )),
        SizedBox(height: 10),
        Obx(() => buildNotificationOption(
              context,
              'Weekly report',
              'Receive a weekly email about your time tracking activities.',
              _notiSettingController.notisettings.value.weeklyReport,
              (value) => _notiSettingController.updateWeeklyReport(value!),
            )),
        SizedBox(height: 10),
        Obx(() => buildNotificationOption(
              context,
              'Long-running timer',
              'Receive an email when a time entry is running more than 8 hours.',
              _notiSettingController.notisettings.value.longRunningTimer,
              (value) => _notiSettingController.updateLongRunningTimer(value!),
            )),
        SizedBox(height: 10),
        Obx(() => buildNotificationOption(
              context,
              'Alerts',
              'Receive an email when a project or task reaches a certain percentage of its estimated time or budget.',
              _notiSettingController.notisettings.value.alerts,
              (value) => _notiSettingController.updateAlerts(value!),
            )),
        SizedBox(height: 10),
        Obx(() => buildNotificationOption(
              context,
              'Reminders',
              'Receive an email when you or your teammates miss or go over time tracking targets or forget to submit / approve timesheets & expenses.',
              _notiSettingController.notisettings.value.reminder,
              (value) => _notiSettingController.updateReminders(value!),
            )),
        SizedBox(height: 10),
        Obx(() => buildNotificationOption(
              context,
              'Schedule',
              'Receive an email about your scheduled assignments.',
              _notiSettingController.notisettings.value.schedule,
              (value) => _notiSettingController.updateSchedule(value!),
            )),
      ],
    );
  }

  Widget buildNotificationOption(BuildContext context, String title,
      String description, bool value, Function(bool?)? onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
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
