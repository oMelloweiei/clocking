import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/data/mockup.dart';

class ProfileCard extends StatelessWidget {
  final Function(String) onSelected;
  final UserController userController = Get.put(UserController());

  ProfileCard({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentUser = userController.getCurrentUser();

      if (currentUser == null) {
        return Icon(Icons.person, size: 40); // Default icon or any placeholder
      }

      return PopupMenuButton<String>(
        offset: Offset(0, 60),
        icon: _buildProfileImage(currentUser.profileImg!),
        itemBuilder: (BuildContext context) {
          return _buildMenuItems(currentUser);
        },
        onSelected: onSelected,
      );
    });
  }

  Widget _buildProfileImage(String profileImg) {
    return ClipOval(
      child: Image.network(
        profileImg,
        fit: BoxFit.cover,
        width: 40,
        height: 40,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error, size: 40);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(currentUser) {
    List<PopupMenuEntry<String>> menuItems = [
      PopupMenuItem<String>(
        enabled: false,
        child: _buildProfileInfo(currentUser),
      ),
      PopupMenuDivider(),
    ];

    for (var item in popProfileContent) {
      menuItems.add(
        PopupMenuItem<String>(
          value: item['route'],
          child: Container(
              alignment: Alignment.center, child: Text(item['topic']!)),
        ),
      );
      menuItems.add(PopupMenuDivider());
    }

    return menuItems;
  }

  Widget _buildProfileInfo(currentUser) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey,
            child: ClipOval(
              child: Image.network(
                currentUser.profileImg,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 90);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            currentUser.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(currentUser.email),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
