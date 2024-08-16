import 'package:clockify_project/data/controller/loginController.dart';
import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSelection extends StatefulWidget {
  UserSelection({super.key});

  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {
  final UserController userController = Get.put(UserController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('3 User(For Test)',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800)),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getUser().toList(),
          ),
        ]),
      ),
    );
  }

  List<Widget> _getUser() {
    final users = userController.users;
    return users
        .map((user) => GestureDetector(
              onTap: () {
                _loginUser(user);
              },
              child: Card(
                color: Color.fromARGB(255, 89, 84, 235),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 70, horizontal: 50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: ClipOval(
                            child: Image.network(
                              user.profileImg.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 4, color: Colors.white),
                        SizedBox(height: 10),
                        Text(user.name, style: TextStyle(color: Colors.white)),
                        SizedBox(height: 10),
                        Text(user.email, style: TextStyle(color: Colors.white)),
                      ],
                    )),
              ),
            ))
        .toList();
  }

  void _loginUser(User user) {
    userController.loginUser(user);
    Get.offAndToNamed('/home');
  }
}
