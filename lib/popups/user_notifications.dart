import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockify_project/data/controller/notiListController.dart';
import 'package:clockify_project/data/controller/user/userController.dart';

class UserNotificationsList extends StatelessWidget {
  UserNotificationsList({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController());
  final NotiListController notiController = Get.put(NotiListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentUser = userController.getCurrentUser();

      return IconButton(
        icon: _buildNotificationIcon(currentUser),
        onPressed: () => _showNotificationsDialog(context),
      );
    });
  }

  Widget _buildNotificationIcon(currentUser) {
    int unreadCount = notiController.getUnRead();

    return Stack(
      children: [
        const Icon(
          Icons.notifications_outlined,
          color: Colors.white,
          size: 30,
        ),
        if (unreadCount > 0)
          Positioned(
            top: 2,
            right: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showNotificationsDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(50),
          alignment: Alignment.topRight,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: _buildNotificationList(context)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return Obx(() {
      final notifications = notiController.notiLists;

      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: notifications.isNotEmpty
            ? ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  return ListTile(
                    title: Text(
                      notification.title,
                      style: TextStyle(
                          color:
                              notification.isRead ? Colors.grey : Colors.black),
                    ),
                    subtitle: Text(
                      notification.message,
                      style: TextStyle(
                          color:
                              notification.isRead ? Colors.grey : Colors.black),
                    ),
                    trailing: notification.isRead ? Text('Readed') : Text(''),
                    onTap: () {
                      notiController.updateNotiList(notification);
                    },
                  );
                })
            : const Center(child: Text('No notifications')),
      );
    });
  }
}
