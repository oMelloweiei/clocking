import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:clockify_project/color.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  late final TextEditingController nameInput;
  late final TextEditingController emailInput;
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final currentUser = userController.getCurrentUser()!;
    nameInput = TextEditingController(text: currentUser.name);
    emailInput = TextEditingController(text: currentUser.email);
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36, horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(fontSize: 36),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(30),
                child: _get(currentUser),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _get(User? currentUser) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Profile photo',
        style: TextStyle(fontSize: 20),
      ),
      Text('Formats: png, jpg, gif. Max size: 1 MB.'),
      SizedBox(height: 20),
      _getpic(currentUser),
      SizedBox(height: 20),
      Container(
        height: 1,
        color: Colors.grey,
      ),
      SizedBox(height: 20),
      Text(
        'Personal info',
        style: TextStyle(fontSize: 20),
      ),
      Text(
          'Your log-in credentials and the name that is displayed in reports.'),
      SizedBox(height: 20),
      Text('Name'),
      SizedBox(
        width: 275,
        height: 45,
        child: TextFormField(
          controller: nameInput,
          expands: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            hintText: 'Name',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      Text('Email'),
      SizedBox(
        width: 275,
        height: 45,
        child: TextFormField(
          controller: emailInput,
          expands: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            hintText: 'Email',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      Text('Email'),
      _buildresetButton()
    ]);
  }

  Widget _getpic(User? currentUser) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipOval(
              child: Image.network(
                currentUser!.profileImg.toString(),
                fit: BoxFit.cover,
                width: 140,
                height: 140,
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
            ),
          ),
          SizedBox(width: 40),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: Colors.white,
          backgroundColor: btncolor,
        ),
        onPressed: () {},
        child: Text(
          'Upload Image',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildresetButton() {
    return SizedBox(
      width: 275,
      height: 45,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey[700]!),
          ),
          foregroundColor: Colors.grey[700],
          backgroundColor: Colors.grey[200],
        ),
        onPressed: () {},
        child: Text(
          'Reset Password',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
