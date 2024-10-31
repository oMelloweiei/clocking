import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clockify_project/data/models/user/user.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var currentUser = Rxn<User>();
  final String baseUrl = 'http://localhost:3000';

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/users'));

      if (response.statusCode == 200) {
        List<dynamic> userList = json.decode(response.body);
        users.assignAll(userList.map((json) => User.fromJson(json)).toList());
      } else {
        Get.snackbar('Error', 'Failed to load users');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection failed: $e');
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        currentUser.value = User.fromJson(userData);
        Get.snackbar('Success', 'Login successful');
      } else {
        Get.snackbar('Error', 'Invalid email or password');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e');
    }
  }

  void logoutUser() {
    currentUser.value = null;
    Get.snackbar('Success', 'Logged out successfully');
  }

  Future<void> updateUser(User updatedUser) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/users/${updatedUser.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedUser.toJson()),
      );

      if (response.statusCode == 200) {
        final index = users.indexWhere((user) => user.id == updatedUser.id);
        if (index != -1) {
          users[index] = updatedUser;
          Get.snackbar('Success', 'User updated successfully');
        }
      } else {
        Get.snackbar('Error', 'Failed to update user');
      }
    } catch (e) {
      Get.snackbar('Error', 'Update failed: $e');
    }
  }

  User? getCurrentUser() {
    return currentUser.value;
  }

  static UserController get instance => Get.find<UserController>();
}
