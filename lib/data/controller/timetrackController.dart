import 'package:clockify_project/data/controller/historyController.dart';
import 'package:clockify_project/data/controller/userController.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:clockify_project/data/models/timetrack/timetrack.dart';

class TimetrackController extends GetxController {
  late final Box<Timetrack> _timetrackBox;
  var timetracks = <Timetrack>[].obs;

  @override
  void onInit() {
    super.onInit();
    _timetrackBox = Hive.box<Timetrack>('timetracks');
    ever(UserController.instance.currentUser, (_) => _loadTimetracks());
    _loadTimetracks();
  }

  void _loadTimetracks() {
    print('Before load timetrack');
    timetracks.assignAll(_timetrackBox.values.toList());
  }

  void addTimetrack(Timetrack timetrack, String today) {
    print('before add timetrack');
    final HistoryController historyController = Get.find<HistoryController>();
    final historyToday = historyController.getHistoryToday(today);
    _timetrackBox.add(timetrack);
    timetracks.add(timetrack);
    historyToday!.timetracksKey.add(timetrack.id);

    print('before update history');
    historyController.updateHistory(historyToday);
    print('after update history');
    print('after add timetrack');
  }

  Timetrack? getTimetrackById(String id) {
    return timetracks.firstWhereOrNull((timetrack) => timetrack.id == id);
  }

  void removeTimetrackById(String id) {
    final timetrack = getTimetrackById(id);
    if (timetrack != null) {
      _timetrackBox.delete(timetrack.id);
      timetracks.remove(timetrack);
    }
  }

  void updateTimetrack(Timetrack updatedTimetrack) {
    final index = timetracks
        .indexWhere((timetrack) => timetrack.id == updatedTimetrack.id);
    if (index != -1) {
      _timetrackBox.put(updatedTimetrack.id, updatedTimetrack);
      timetracks[index] = updatedTimetrack;
    }
  }
}
