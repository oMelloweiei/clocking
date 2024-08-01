import 'package:clockify_project/popups/user_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:clockify_project/popups/profilecard.dart';
import 'package:clockify_project/color.dart';
import 'package:clockify_project/data/controller/userController.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isPortrait;
  final GlobalKey<NavigatorState> navigatorKey;
  final Function(String) onSelected;
  final UserController userController;

  MyAppBar({
    required this.isPortrait,
    required this.navigatorKey,
    required this.onSelected,
    required this.userController,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isPortrait
          ? Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            )
          : null,
      backgroundColor: maincolor,
      title: Text(
        'Clockify',
        style: GoogleFonts.righteous(
            textStyle: TextStyle(color: Colors.white, fontSize: 26)),
      ),
      actions: [
        UserNotificationsList(),
        const SizedBox(width: 10),
        ProfileCard(
          onSelected: (String selectedNav) {
            if (selectedNav == 'users') {
              userController.logoutUser();
              Get.offAndToNamed('/$selectedNav');
            }
            navigatorKey.currentState?.pushReplacementNamed('/$selectedNav');
            onSelected(selectedNav);
          },
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
