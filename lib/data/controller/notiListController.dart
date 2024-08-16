import 'package:clockify_project/data/models/notifications/notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:clockify_project/data/controller/user/userController.dart';

class NotiListController extends GetxController {
  late final Box<NotificationList> _notiListBox;
  RxList<NotificationList> notiLists = <NotificationList>[].obs;

  @override
  void onInit() {
    super.onInit();
    _notiListBox = Hive.box<NotificationList>('notifications');

    ever(UserController.instance.currentUser, (_) => _loadNotiList());
    _loadNotiList();
  }

  Future<void> _loadNotiList() async {
    try {
      final currentUser = UserController.instance.getCurrentUser();

      if (currentUser != null) {
        final notiKeys = currentUser.notificationsKey;
        final userNotiList = notiKeys
            .map((id) => _notiListBox.get(id))
            .whereType<NotificationList>()
            .toList();
        notiLists.assignAll(userNotiList);
      } else {
        notiLists.clear();
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try again $e");
    }
  }

  Future<void> saveNotiListRecord(NotificationList noti) async {
    try {
      await _notiListBox.put(noti.id, noti);
      notiLists.add(noti);

      final currentUser = UserController.instance.getCurrentUser();

      if (currentUser != null) {
        currentUser.notificationsKey.add(noti.id);
        UserController.instance.updateUser(currentUser);
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try again $e");
    }
  }

  NotificationList? getNotiListById(String id) {
    return notiLists.firstWhereOrNull((noti) => noti.id == id);
  }

  void removeNotiListById(String id) {
    final noti = getNotiListById(id);
    if (noti != null) {
      _notiListBox.delete(id);
      notiLists.remove(noti);

      final currentUser = UserController.instance.getCurrentUser();

      if (currentUser != null) {
        currentUser.notificationsKey.remove(id);
        UserController.instance.updateUser(currentUser);
      }
    }
  }

  void updateNotiList(NotificationList updatedNoti) {
    final index = notiLists.indexWhere((noti) => noti.id == updatedNoti.id);
    if (index != -1) {
      _notiListBox.put(updatedNoti.id, updatedNoti);
      notiLists[index] = updatedNoti;
    }
  }

  int getUnRead() {
    return notiLists.where((notification) => !notification.isRead).length;
  }
}
