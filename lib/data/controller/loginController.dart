import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final UserController userController = Get.find<UserController>();

  void loginUser(User user) {
    userController.loginUser(user);
  }
}
