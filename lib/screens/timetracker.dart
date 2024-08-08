import 'package:clockify_project/color.dart';
import 'package:clockify_project/component/headtablebox.dart';
import 'package:clockify_project/component/infoboxcolumn.dart';
import 'package:clockify_project/data/controller/historyController.dart';
import 'package:clockify_project/data/controller/timetrackController.dart';
import 'package:clockify_project/data/models/history/history.dart';
import 'package:clockify_project/data/models/timetrack/timetrack.dart';
import 'package:clockify_project/popups/projectselect.dart';
import 'package:clockify_project/popups/tagselect.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:clockify_project/timer.dart';
import 'package:clockify_project/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeTrackerScreen extends StatefulWidget {
  const TimeTrackerScreen({Key? key}) : super(key: key);

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
  TextEditingController descController = TextEditingController();
  bool activeborder = false;
  late DateTime now;
  late String today;
  final HistoryController historyController = Get.put(HistoryController());
  final TimetrackController timetrackController =
      Get.put(TimetrackController());
  late List<History> histories;
  late History? todayHistory;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    today = DateFormat.yMMMMEEEEd().format(now);
    _getHistory();
  }

  void _getHistory() {
    histories = historyController.histories;
    todayHistory = historyController.getHistoryToday(today);
    if (todayHistory == null) {
      todayHistory = History.create(date: today);
      historyController.createTodayHistory(todayHistory!);
    }
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final screenConfig = ScreenConfig.of(context);
    isMobile = screenConfig.isMobile;
    isPortrait = screenConfig.isPortrait;
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        child: Padding(
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
          isMobile && isPortrait ? _buildMobileBox() : _buildBox(),
          SizedBox(height: 20),
          Text('Today is $today'),
          Text('Now : $now'),
          SizedBox(height: 20),
          _buildHistories(),
        ],
      ),
    ));
  }

  Widget _buildButton(bool isRunning) {
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
            final History history = todayHistory!;
            final newTimetrack = Timetrack.create(
              tagKey: '',
              projectKey: '',
              time: timerUtils.formattedTime,
              timeStart: timeStart.text,
              timeEnd: timeEnd.text,
            );
            timetrackController.addTimetrack(newTimetrack, history);
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

  Widget _buildAddButton() {
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
          final History history = todayHistory!;
          if (_formKey.currentState?.validate() ?? false) {
            if (timeStart.text == timeEnd.text ||
                (timeStart.text == "00:00" && timeEnd.text == "00:00")) {
              return;
            }
            final newTimetrack = Timetrack.create(
              tagKey: '',
              projectKey: '',
              time: timerUtils.formattedTime,
              timeStart: timeStart.text,
              timeEnd: timeEnd.text,
            );
            timetrackController.addTimetrack(newTimetrack, history);
            setState(() {
              timeEnd.text = "00:00";
              timeStart.text = "00:00";
            });
          }
        },
        child: Text(
          'Add',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildAddTimeForm() {
    return Visibility(
      visible: onShow,
      child: Form(
          key: _formKey,
          child: Row(
            children: [
              IntrinsicWidth(
                child: TextFormField(
                  validator: (value) => Validator.validateTime('Time', value),
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
                  validator: (value) => Validator.validateTime('Time', value),
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
          )),
    );
  }

  Widget _buildBox() {
    final minutes = _twoDigits(timerUtils.duration.inMinutes.remainder(60));
    final seconds = _twoDigits(timerUtils.duration.inSeconds.remainder(60));
    final hours = _twoDigits(timerUtils.duration.inHours.remainder(60));
    final isRunning = timerUtils.isRunning;

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
                    activeborder = hasFocus;
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
            _buildAddTimeForm(),
            SizedBox(width: 20),
            Text(
              '$hours:$minutes:$seconds',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 20),
            onShow
                ? _buildAddButton()
                : _buildButton(isRunning), // this button will be one of form
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

  Widget _buildMobileBox() {
    final minutes = _twoDigits(timerUtils.duration.inMinutes.remainder(60));
    final seconds = _twoDigits(timerUtils.duration.inSeconds.remainder(60));
    final hours = _twoDigits(timerUtils.duration.inHours.remainder(60));
    final isRunning = timerUtils.isRunning;

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
          Row(
            children: [
              Expanded(child: _buildButton(isRunning)),
              SizedBox(width: 10),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.timer_10_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistories() {
    return Obx(() {
      final histories = historyController.histories;
      final timetracks = timetrackController.timetracks;

      final historyWidgets = histories.map<Widget>((history) {
        if (history.timetracksKey.isEmpty && history.date == today) {
          return const SizedBox();
        } else {
          return Column(
            children: [
              TopBox(
                child: Text(history.date),
              ),
              _buildTimetrack(history, timetracks)
            ],
          );
        }
      }).toList();

      final spacedHistoryWidgets = historyWidgets.expand((widget) {
        return [
          widget,
          const SizedBox(height: 20),
        ];
      }).toList();

      if (spacedHistoryWidgets.isNotEmpty) {
        spacedHistoryWidgets.removeLast();
      }

      return Column(children: spacedHistoryWidgets);
    });
  }

  Widget _buildTimetrack(History history, List<Timetrack> timetracks) {
    final trackWidgets = timetracks.map<Widget>((timetrack) {
      if (history.timetracksKey.contains(timetrack.id)) {
        return Infoboxcolumn(
          index: timetracks.indexOf(timetrack),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      activeborder = hasFocus;
                    });
                  },
                  child: TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                      hintText: 'Add Description',
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
              Text(timetrack.timeStart),
              SizedBox(width: 10),
              Text('-'),
              SizedBox(width: 10),
              Text(timetrack.timeEnd),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_month_outlined),
              ),
              SizedBox(width: 20),
              Text(timetrack.time),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.arrowtriangle_right_fill),
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.ellipsis_vertical),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    }).toList();

    return Column(
      children: trackWidgets,
    );
  }
}
