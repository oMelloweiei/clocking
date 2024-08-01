import 'package:clockify_project/color.dart';
import 'package:clockify_project/data/controller/historyController.dart';
import 'package:clockify_project/data/controller/timetrackController.dart';
import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/history/history.dart';
import 'package:clockify_project/data/models/timetrack/timetrack.dart';
import 'package:clockify_project/popups/projectselect.dart';
import 'package:clockify_project/popups/tagselect.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:clockify_project/timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeTrackerScreen extends StatefulWidget {
  const TimeTrackerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeTrackerScreen> createState() => _TimeTrackerScreenState();
}

class _TimeTrackerScreenState extends State<TimeTrackerScreen> {
  final TimerUtils timerUtils = TimerUtils();
  late double screenwidth;
  late double screenheight;
  late bool isMobile;
  bool onShow = false;
  late bool isPortrait;
  TextEditingController timeStart = TextEditingController(text: '00:00');
  TextEditingController timeEnd = TextEditingController(text: '00:00');
  TextEditingController detailController = TextEditingController();
  bool activeborder = false;
  late DateTime now;
  late String today;
  final HistoryController historyController = Get.put(HistoryController());
  final TimetrackController timetrackController =
      Get.put(TimetrackController());
  late List<History> histories;
  late var today_history;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    today = DateFormat.yMMMMEEEEd().format(now);
    getHistory();
  }

  void getHistory() {
    histories = historyController.histories;
    today_history = historyController.getHistoryToday(today);
    print(today_history);
    if (today_history == null) {
      today_history = History.create(date: today);
      historyController.createTodayHistory(today_history);
    }

    print(today_history);
  }

  @override
  Widget build(BuildContext context) {
    final screenConfig = ScreenConfig.of(context);
    isMobile = screenConfig.isMobile;
    isPortrait = screenConfig.isPortrait;
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: !isMobile
            ? screenheight * 0.06
            : !isPortrait
                ? (screenheight * 0.1)
                : screenheight * 0.03,
        horizontal: screenwidth * 0.04,
      ),
      child: Column(
        crossAxisAlignment: isMobile && isPortrait
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          isMobile && isPortrait ? _mobilebox() : _box(),
          SizedBox(height: 30),
          _buildHistories(),
          Text(today.toString()),
          Text(now.toString())
        ],
      ),
    );
  }

  Widget _buildButton() {
    final isRunning = timerUtils.isRunning;
    final isCompleted = timerUtils.duration.inSeconds == 0;

    return SizedBox(
      width: isMobile && isPortrait ? double.maxFinite : null,
      height: isMobile && isPortrait ? 50 : 40,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: Colors.white,
          backgroundColor: isRunning ? Colors.red : btncolor,
        ),
        onPressed: () async {
          if (isRunning) {
            final newTimetrack = Timetrack.create(
              tagKey: '',
              projectKey: '',
              time: timerUtils.formattedTime,
              timeStart: timeStart.text,
              timeEnd: timeEnd.text,
            );
            timetrackController.addTimetrack(newTimetrack, today);
            setState(() {
              timerUtils.stopTimer(resets: false);
              timerUtils.reset();
            });
          } else {
            setState(() {
              timerUtils.startTimer(() {
                setState(() {
                  timerUtils.addTime();
                });
              });
            });
          }
        },
        child: Text(
          isRunning ? 'STOP' : 'START',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildButton2() {
    return SizedBox(
      width: isMobile && isPortrait ? double.maxFinite : null,
      height: isMobile && isPortrait ? 50 : 40,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: Colors.white,
          backgroundColor: btncolor,
        ),
        onPressed: () {
          final newTimetrack = Timetrack.create(
            tagKey: '',
            projectKey: '',
            time: '',
            timeStart: timeStart.text,
            timeEnd: timeEnd.text,
          );
          timetrackController.addTimetrack(newTimetrack, today);
          setState(() {
            timeEnd.text = "00:00";
            timeStart.text = "00:00";
          });
        },
        child: Text(
          'Add',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _box() {
    // 9 --> 09 or 11 --> 11
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(timerUtils.duration.inMinutes.remainder(60));
    final seconds = twoDigits(timerUtils.duration.inSeconds.remainder(60));
    final hours = twoDigits(timerUtils.duration.inHours.remainder(60));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    activeborder = hasFocus ? true : false;
                  });
                },
                child: TextFormField(
                  controller: detailController,
                  decoration: InputDecoration(
                    hintText: 'Add detail',
                    border: activeborder
                        ? OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[200]!, width: 0.0),
                          )
                        : InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            ProjectPopup(),
            SizedBox(width: 20),
            TagPopUp(),
            SizedBox(width: 20),
            Visibility(
              visible: onShow,
              child: Row(
                children: [
                  IntrinsicWidth(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      controller: timeStart,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('-'),
                  SizedBox(width: 10),
                  IntrinsicWidth(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      controller: timeEnd,
                    ),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit_calendar_outlined),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Text(
              '$hours:$minutes:$seconds',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 20),
            onShow ? _buildButton2() : _buildButton(),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      onShow = false;
                    });
                  },
                  icon: Icon(Icons.timer,
                      color: !onShow ? Colors.blue : Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      onShow = true;
                    });
                  },
                  icon: Icon(Icons.menu,
                      color: onShow ? Colors.blue : Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobilebox() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(timerUtils.duration.inMinutes.remainder(60));
    final seconds = twoDigits(timerUtils.duration.inSeconds.remainder(60));
    final hours = twoDigits(timerUtils.duration.inHours.remainder(60));
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Add detail',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.dashboard),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.label),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '$hours:$minutes:$seconds',
            style: TextStyle(fontSize: 16),
          ),
          Row(children: [
            Expanded(child: _buildButton()),
            SizedBox(width: 10),
            Column(
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.timer_10_outlined)),
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildHistories() {
    return Expanded(
      child: Obx(() {
        final histories = historyController.histories;
        final timetracks = timetrackController.timetracks;
        return ListView.builder(
          itemCount: histories.length,
          itemBuilder: (context, index) {
            final history = histories[index];
            print('check error before map');
            print('${history.date} , ${history.timetracksKey}');
            if (history.timetracksKey.isEmpty && history.date == today) {
              return SizedBox();
            } else {
              return ListTile(
                title: Text(history.date),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: history.timetracksKey.map((timetrackKey) {
                    final timetrack = timetracks
                        .firstWhere((track) => track.id == timetrackKey);

                    return Text(
                      '${timetrack.projectKey} - ${timetrack.tagKey}: ${timetrack.timeStart} - ${timetrack.timeEnd} , ${timetrack.time}',
                    );
                  }).toList(),
                ),
              );
            }
          },
        );
      }),
    );
  }
}
