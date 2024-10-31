/* import 'package:clockify_project/data/controller/loginController.dart';
import 'package:clockify_project/data/controller/userController.dart';
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
 */

import 'package:clockify_project/data/controller/loginController.dart';
import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockify_project/loginPage/screens/login_screen.dart'; // Import LoginScreen

class UserSelection extends StatefulWidget {
  UserSelection({super.key});

  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection> {
  final UserController userController = Get.put(UserController());
  final LoginController loginController = Get.put(LoginController());

  bool _showUserSelection = true; // State variable to toggle views

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 8, 65),
      appBar: AppBar(
        title: Text('Select User or Login'),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              setState(() {
                _showUserSelection = !_showUserSelection; // Toggle the state
              });
            },
          ),
        ],
      ),
      body: Center(
        child: _showUserSelection
            ? _buildUserSelection()
            : LoginScreen(), // Use LoginScreen instead of LoginPage
      ),
    );
  }

  Widget _buildUserSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('3 Users (For Test)',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800)),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getUser().toList(),
        ),
      ],
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

/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clockify_project/data/controller/loginController.dart';
import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:clockify_project/loginPage/screens/login_screen.dart';

class UserSelection extends StatefulWidget {
  const UserSelection({super.key});

  @override
  State<UserSelection> createState() => _UserSelectionState();
}

class _UserSelectionState extends State<UserSelection>
    with SingleTickerProviderStateMixin {
  final UserController userController = Get.find<UserController>();
  final LoginController loginController = Get.find<LoginController>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _showUserSelection = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              _showUserSelection ? _buildUserSelection() : const LoginScreen(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        _showUserSelection ? 'Select User' : 'Login',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Tooltip(
          message:
              '${_showUserSelection ? "Switch to Login" : "Switch to User Selection"}',
          child: IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animationController,
            ),
            onPressed: _toggleView,
          ),
        ),
      ],
    );
  }

  void _toggleView() {
    setState(() {
      _showUserSelection = !_showUserSelection;
      if (_showUserSelection) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  Widget _buildUserSelection() {
    return Obx(() => FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Choose Your Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.count(
                          crossAxisCount: _calculateCrossAxisCount(context),
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          children: _buildUserCards(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  int _calculateCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }

  List<Widget> _buildUserCards() {
    return userController.users.map((user) => _buildUserCard(user)).toList();
  }

  Widget _buildUserCard(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _loginUser(user),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(user),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              _buildUserInfo(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(User user) {
    return Hero(
      tag: 'profile-${user.email}',
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.profileImg.toString(),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _loginUser(User user) {
    try {
      // Show loading indicator
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      // Perform login
      userController.loginUser(user);

      // Close loading indicator
      Get.back();

      // Navigate to home
      Get.offAllNamed('/home');
    } catch (e) {
      // Close loading indicator if it's still showing
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        duration: const Duration(seconds: 3),
      );
    }
  }
} */
