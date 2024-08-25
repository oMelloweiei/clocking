import 'package:clockify_project/data/models/client/client.dart';
import 'package:clockify_project/data/models/entry/entry.dart';
import 'package:clockify_project/data/models/general_setting/general_setting.dart';
import 'package:clockify_project/data/models/history/history.dart';
import 'package:clockify_project/data/models/notification_setting/user_notification_setting.dart';
import 'package:clockify_project/data/models/notifications/notifications.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/data/models/tag/tag.dart';
import 'package:clockify_project/data/models/timetrack/timetrack.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:hive/hive.dart';

var list_user = [
  {
    'name': 'Ambartukam',
    'email': 'ambartukam@mail.com',
    'profileImg':
        'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    'tagsKey': <String>[],
    'projectsKey': <String>[],
    'historiesKey': <String>[],
    'clientsKey': <String>[],
    'kiosksKey': <String>[]
  },
  {
    'name': 'YatumDekkk',
    'email': 'yatumdekk@mail.com',
    'profileImg':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYI2MGC6vKYICI8CxiqL1ryKmIJaVQESKiJA&s',
    'tagsKey': <String>[],
    'projectsKey': <String>[],
    'historiesKey': <String>[],
    'clientsKey': <String>[],
    'kiosksKey': <String>[]
  },
  {
    'name': 'Bunrengnuay',
    'email': 'bunrengnuay@mail.com',
    'profileImg':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqK2X2VIxksVcPkLeJww5fpdfuw5UxcCxSwA&s',
    'tagsKey': <String>[],
    'projectsKey': <String>[],
    'historiesKey': <String>[],
    'clientsKey': <String>[],
    'kiosksKey': <String>[]
  },
];

var clients = [
  {
    'name': 'Mr.Somchai(init)',
    'address': '4/59 Soi Vachirathamsathit Sukhumvit Nong Bon Prawet',
    'currency': 'BAHT',
    'note':
        'ขอโทษนะอาบาไน ตอนนี้ฉันไม่ได้ โกรธเพราะเธอ ไม่ได้แค้นใครทั้งนั้น ตอนนี้เพียง แต่...รู้สึกว่าโลกนี่ช่างสบายสะ เหลือเกินเหนือฟ้าใต้ล่า ข้าประเสริฐที่สุด'
  },
  {
    'name': 'Julia Sandip(init)',
    'address': '47 St Andrews Lane, Cwmaman',
    'currency': 'USD',
    'note': ''
  },
  {'name': 'Karel Ane(init)', 'address': '', 'currency': 'USD', 'note': ''},
];

var kiosks = [
  {
    'name': 'Healworld(init)',
    'assign': 'Everyone',
    'url': 'www.google.com',
    'projectKey': ''
  },
  {
    'name': 'Healworld(init)',
    'assign': 'Everyone',
    'url': 'www.google.com',
    'projectKey': ''
  },
];

var noti = [
  {
    'title': 'Title1',
    'message': 'Message1',
    'timestamp': DateTime.now(),
    'isRead': false,
  },
  {
    'title': 'Title2',
    'message': 'Message2',
    'timestamp': DateTime.now(),
    'isRead': true,
  },
  {
    'title': 'Title3',
    'message': 'Message3',
    'timestamp': DateTime.now(),
    'isRead': false,
  },
];

Future<void> initializeSampleData() async {
  var userBox = Hive.box<User>('users');
  var projectBox = Hive.box<Project>('projects');
  var tagBox = Hive.box<Tag>('tags');
  var clientBox = Hive.box<Client>('clients');
  var kioskBox = Hive.box<Kiosk>('kiosks');
  var notificationBox = Hive.box<NotificationList>('notifications');
  var notificationSettingBox =
      Hive.box<UserNotificationSetting>('notificationSettings');
  var historyBox = Hive.box<History>('histories');
  var timetrackBox = Hive.box<Timetrack>('timetracks');
  var generalSettingBox = Hive.box<UserGeneralSetting>('generalSettings');

  // Check if the data is already initialized
  if (userBox.isNotEmpty) {
    return;
  }

  // Create clients and store their IDs
  for (var clientData in clients) {
    var client = Client.create(
        name: clientData['name'],
        address: clientData['address'],
        currency: clientData['currency'],
        note: clientData['note']);
    clientBox.put(client.id, client);
  }

  // Create kiosks and store their IDs
  for (var kioskData in kiosks) {
    var kiosk = Kiosk.create(
        projectKey: kioskData['projectKey'],
        name: kioskData['name'],
        assign: kioskData['assign'],
        url: kioskData['url']);
    kioskBox.put(kiosk.id, kiosk);
  }

  // Create notifications and store their IDs
  for (var notificationData in noti) {
    var userNotification = NotificationList.create(
        title: notificationData['title'].toString(),
        message: notificationData['message'].toString(),
        timestamp: notificationData['timestamp'] as DateTime,
        isRead: notificationData['isRead'] as bool);
    notificationBox.put(userNotification.id, userNotification);
  }

  // Create a sample project
  Project project = Project.create(
      name: "New Project(init)",
      clientKey: "test",
      trackedKey: "test",
      access: "private");

  // Create a sample tag
  Tag tag = Tag.create(name: 'InitTest');

  // Put sample data into boxes
  tagBox.put(tag.id, tag);
  projectBox.put(project.id, project);

  // Add users to the userBox
  for (var userData in list_user) {
    var user = User.create(
      name: userData['name'].toString(),
      email: userData['email'].toString(),
      profileImg: userData['profileImg'].toString(),
      tagsKey: userData['tagsKey'] as List<String>?,
      projectsKey: userData['projectsKey'] as List<String>?,
      historiesKey: userData['historiesKey'] as List<String>?,
      clientsKey: userData['clientsKey'] as List<String>?,
      kiosksKey: userData['kiosksKey'] as List<String>?,
      notificationsKey: userData['notificationsKey'] as List<String>?,
    );

    final notisetting = UserNotificationSetting.create(
        id: user.id,
        newsletter: false,
        onboarding: false,
        weeklyReport: false,
        longRunningTimer: false,
        alerts: false,
        reminder: false,
        schedule: false);

    notificationSettingBox.put(notisetting.id, notisetting);

    final generalsetting = UserGeneralSetting.create(
      id: user.id,
      isDarkTheme: false,
      language: "",
      timeZone: "",
      dateFormat: "",
      weekStart: "",
      timeFormat: "",
    );

    generalSettingBox.put(generalsetting.id, generalsetting);

    // Check if user is Ambartukam and update their keys
    if (user.name == 'Ambartukam') {
      // Add client IDs
      for (var client in clientBox.values) {
        user.clientsKey.add(client.id);
      }

      // Add kiosk IDs
      for (var kiosk in kioskBox.values) {
        user.kiosksKey.add(kiosk.id);
      }

      // Add project ID
      user.projectsKey.add(project.id);

      // Add tag ID
      user.tagsKey.add(tag.id);

      // Add notification IDs
      for (var notification in notificationBox.values) {
        user.notificationsKey.add(notification.id);
      }

      // Create history and time tracks for testing
      var timeTrack1 = Timetrack.create(
        tagKey: tag.id,
        projectKey: project.id,
        time: '02:00:00',
        timeStart: '08:00',
        timeEnd: '10:00',
      );

      var timeTrack2 = Timetrack.create(
        tagKey: tag.id,
        projectKey: project.id,
        time: '01:30:00',
        timeStart: '10:30',
        timeEnd: '12:00',
      );

      // Put time tracks into the box
      timetrackBox.put(timeTrack1.id, timeTrack1);
      timetrackBox.put(timeTrack2.id, timeTrack2);

      var history = History.create(
        date: 'For Test(Init)',
        timetracksKey: [timeTrack1.id, timeTrack2.id],
      );

      // Put history into the box
      historyBox.put(history.id, history);

      // Add history ID to the user
      user.historiesKey.add(history.id);
    }

    userBox.put(user.id, user);
  }
}
