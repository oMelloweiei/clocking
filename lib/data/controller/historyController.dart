import 'package:clockify_project/data/controller/timetrackController.dart';
import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/timetrack/timetrack.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:clockify_project/data/models/history/history.dart';

class HistoryController extends GetxController {
  late final Box<History> _historyBox;
  var histories = <History>[].obs;

  @override
  void onInit() {
    super.onInit();
    _historyBox = Hive.box<History>('histories');
    ever(UserController.instance.currentUser, (_) => _loadHistories());
    _loadHistories();
  }

  void _loadHistories() {
    final UserController userController = UserController.instance;
    final currentUser = userController.getCurrentUser();

    if (currentUser != null) {
      final historyIds = currentUser.historiesKey;
      final userHistories = historyIds
          .map((id) => _historyBox.get(id))
          .whereType<History>()
          .toList();

      histories.assignAll(userHistories);
    } else {
      // tags.assignAll(_tagBox.values.toList());

      print(
          'No current user, loading all tags: ${_historyBox.values.toList()}');
    }
  }

  void addHistory(History history, {Timetrack? timetrack, String? today}) {
    print('before add history');
    final UserController userController = UserController.instance;
    final currentUser = userController.getCurrentUser();
    final TimetrackController timetrackController =
        Get.find<TimetrackController>();

    _historyBox.add(history);
    histories.add(history);

    if (currentUser != null) {
      currentUser.historiesKey.add(history.id);
      userController.updateUser(currentUser);
    }

    if (timetrack != null && today != null) {
      timetrackController.addTimetrack(timetrack, today);
    }
  }

  History? getHistoryById(String id) {
    return histories.firstWhereOrNull((history) => history.id == id);
  }

  History? getHistoryToday(String today) {
    return histories.firstWhereOrNull((history) => history.date == today);
  }

  void removeHistoryById(String id) {
    final history = getHistoryById(id);
    if (history != null) {
      _historyBox.delete(history.id);
      histories.remove(history);
    }
  }

  void updateHistory(History updatedHistory) {
    final index =
        histories.indexWhere((history) => history.id == updatedHistory.id);
    if (index != -1) {
      _historyBox.put(updatedHistory.id, updatedHistory);
      histories[index] = updatedHistory;
    }
  }
}
