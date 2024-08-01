import 'package:clockify_project/data/controller/historyController.dart';
import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/history/history.dart';
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
    _loadTimetracks();
  }

  void _loadTimetracks() {
    print('Before load timetrack');
    timetracks.assignAll(_timetrackBox.values.toList());
  }

  void addTimetrack(Timetrack timetrack, String today) {
    final HistoryController historyController = Get.put(HistoryController());
    final history = historyController.getHistoryToday(today)!;
    history.timetracksKey.add(timetrack.id);
    historyController.updateHistory(history);
    _timetrackBox.add(timetrack);
    timetracks.add(timetrack);
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
