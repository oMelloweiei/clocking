// timer_utils.dart
import 'dart:async';

class TimerUtils {
  Duration duration = Duration();
  Timer? timer;

  void startTimer(Function addTime) {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = 1;
    duration = Duration(seconds: duration.inSeconds + addSeconds);
  }

  void reset() {
    duration = Duration();
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer?.cancel();
  }

  String get formattedTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  bool get isRunning => timer != null && timer!.isActive;
}
