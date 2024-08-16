import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/data/models/general_setting/general_setting.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class GeneralSettingController extends GetxController {
  late final Box<UserGeneralSetting> _generalsettingBox;
  var generalsettings = UserGeneralSetting(
          id: '',
          isDarkTheme: false,
          language: "",
          timeZone: "",
          timeFormat: "",
          dateFormat: "",
          weekStart: "")
      .obs;

  @override
  void onInit() {
    super.onInit();
    _generalsettingBox = Hive.box<UserGeneralSetting>('generalSettings');
    ever(UserController.instance.currentUser, (_) => _loadGeneralSetting());
    _loadGeneralSetting();
  }

  void _loadGeneralSetting() {
    final UserController userController = UserController.instance;
    final currentUser = userController.getCurrentUser();

    if (currentUser != null) {
      final generalSettingId = currentUser.id;
      final usergeneralSetting = _generalsettingBox.get(generalSettingId);

      if (usergeneralSetting != null) {
        generalsettings.value = usergeneralSetting;
      }
    }
  }

  void _saveGeneralSetting() {
    if (generalsettings.value.id.isNotEmpty) {
      _generalsettingBox.put(generalsettings.value.id, generalsettings.value);
    }
  }

  void updateLanguage(String newLanguage) {
    generalsettings.update((val) {
      val?.language = newLanguage;
    });
    _saveGeneralSetting();
  }

  void updateTimeZone(String newTimeZone) {
    generalsettings.update((val) {
      val?.timeZone = newTimeZone;
    });
    _saveGeneralSetting();
  }

  void updateDateFormat(String newDateFormat) {
    generalsettings.update((val) {
      val?.dateFormat = newDateFormat;
    });
    _saveGeneralSetting();
  }

  void updateTimeFormat(String newTimeFormat) {
    generalsettings.update((val) {
      val?.timeFormat = newTimeFormat;
    });
    _saveGeneralSetting();
  }

  void updateWeekStart(String newWeekStart) {
    generalsettings.update((val) {
      val?.weekStart = newWeekStart;
    });
    _saveGeneralSetting();
  }

  void toggleTheme() {
    generalsettings.update((val) {
      val?.isDarkTheme = !(val.isDarkTheme);
    });
    _saveGeneralSetting();
  }
}
