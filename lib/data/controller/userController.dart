import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:clockify_project/data/models/user/user.dart';

class UserController extends GetxController {
  late final Box<User> _userBox;
  var users = <User>[].obs;
  var currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    _userBox = Hive.box<User>('users');
    _loadUsers();
  }

  List<String> getuserslist() {
    return users.map((user) => user.name).toList();
  }

  void _loadUsers() {
    users.assignAll(_userBox.values.toList());
  }

  void loginUser(User user) {
    currentUser.value = user;
  }

  void logoutUser() {
    currentUser.value = null;
  }

  User? getCurrentUser() {
    return currentUser.value;
  }

  void updateUser(User updatedUser) {
    final index = users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _userBox.put(updatedUser.id, updatedUser);
      users[index] = updatedUser;
    }
  }

  static UserController get instance => Get.find<UserController>();
}
