import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/data/models/notification_setting/user_notification_setting.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class NotiSettingController extends GetxController {
  late final Box<UserNotificationSetting> _notisettingBox;
  var notisettings = UserNotificationSetting(
    id: '',
    newsletter: false,
    onboarding: false,
    weeklyReport: false,
    longRunningTimer: false,
    alerts: false,
    reminder: false,
    schedule: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    _notisettingBox = Hive.box<UserNotificationSetting>('notificationSettings');
    ever(UserController.instance.currentUser, (_) => _loadNotiSetting());
    _loadNotiSetting();
  }

  void _loadNotiSetting() {
    final UserController userController = UserController.instance;
    final currentUser = userController.getCurrentUser();

    if (currentUser != null) {
      final notiSettingId = currentUser.id;
      final userNotiSetting = _notisettingBox.get(notiSettingId);

      if (userNotiSetting != null) {
        notisettings.value = userNotiSetting;
      }
    }
  }

  void updateNewsletter(bool value) {
    notisettings.update((settings) {
      settings?.newsletter = value;
      _saveNotiSetting();
    });
  }

  void updateOnboarding(bool value) {
    notisettings.update((settings) {
      settings?.onboarding = value;
      _saveNotiSetting();
    });
  }

  void updateWeeklyReport(bool value) {
    notisettings.update((settings) {
      settings?.weeklyReport = value;
      _saveNotiSetting();
    });
  }

  void updateLongRunningTimer(bool value) {
    notisettings.update((settings) {
      settings?.longRunningTimer = value;
      _saveNotiSetting();
    });
  }

  void updateAlerts(bool value) {
    notisettings.update((settings) {
      settings?.alerts = value;
      _saveNotiSetting();
    });
  }

  void updateReminders(bool value) {
    notisettings.update((settings) {
      settings?.reminder = value;
      _saveNotiSetting();
    });
  }

  void updateSchedule(bool value) {
    notisettings.update((settings) {
      settings?.schedule = value;
      _saveNotiSetting();
    });
  }

  void _saveNotiSetting() {
    if (notisettings.value.id.isNotEmpty) {
      _notisettingBox.put(notisettings.value.id, notisettings.value);
    }
  }
}
