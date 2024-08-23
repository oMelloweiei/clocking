import 'package:clockify_project/data/controller/kioskController.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> createKioskDialog({
  required BuildContext context,
  required List<User> assigneesList,
  required List<Project> projectList,
  required TextEditingController addKioskController,
}) async {
  final _formKey = GlobalKey<FormState>();
  final KioskController kioskController = Get.find<KioskController>();

  final Rx<Project?> selectedProject =
      Rx<Project?>(projectList.isNotEmpty ? projectList.first : null);

  final Rx<User?> selectedAssignees =
      Rx<User?>(assigneesList.isNotEmpty ? assigneesList.first : null);

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 5),
              Divider(thickness: 1, color: Colors.black),
              const SizedBox(height: 10),
              Text('Name'),
              _buildNameField(addKioskController),
              const SizedBox(height: 5),
              Text('Assignees'),
              const SizedBox(height: 5),
              _buildAssigneesDropdown(
                assigneesList,
                selectedAssignees,
              ),
              const SizedBox(height: 5),
              Text('Project'),
              const SizedBox(height: 5),
              _buildProjectDropdown(
                projectList,
                selectedProject,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      actions: _buildActions(
        context,
        _formKey,
        addKioskController,
        selectedAssignees,
        selectedProject,
      ),
    ),
  );
}

Widget _buildTitle() {
  return const Text(
    'Create Kiosk',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  );
}

Widget _buildNameField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: const InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      hintText: 'Enter name',
      labelText: 'Name',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a kiosk name';
      }
      return null;
    },
  );
}

Widget _buildAssigneesDropdown(
  List<User> assigneesList,
  Rx<User?> selectedAssignees,
) {
  return Obx(() {
    return DropdownButtonFormField<User?>(
      value: selectedAssignees.value,
      onChanged: (User? newValue) {
        selectedAssignees.value = newValue;
      },
      decoration: InputDecoration(
        hintText: 'Select Assignee',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      isExpanded: true,
      items: assigneesList.map<DropdownMenuItem<User?>>((User user) {
        return DropdownMenuItem<User?>(
          value: user,
          child: Text(user.name),
        );
      }).toList(),
    );
  });
}

Widget _buildProjectDropdown(
  List<Project> projectList,
  Rx<Project?> selectedProject,
) {
  return Obx(() {
    return DropdownButtonFormField<Project?>(
      value: selectedProject.value,
      onChanged: (Project? newValue) {
        selectedProject.value = newValue;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      isExpanded: true,
      items: projectList.map<DropdownMenuItem<Project?>>((Project project) {
        return DropdownMenuItem<Project?>(
          value: project,
          child: Text(project.name),
        );
      }).toList(),
    );
  });
}

List<Widget> _buildActions(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController addKioskController,
  Rx<User?> selectedAssignees,
  Rx<Project?> selectedProject,
) {
  return [
    TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text(
        'Cancel',
        style: TextStyle(fontSize: 14),
      ),
    ),
    TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (selectedAssignees != null && selectedProject != null) {
            // Handle the creation logic here
            // Example:
            // final newKiosk = Kiosk(
            //   name: addKioskController.text,
            //   assignee: selectedAssignees,
            //   project: selectedProject,
            // );
            // kioskController.createKiosk(newKiosk);

            addKioskController.clear();
            Navigator.of(context).pop();
          } else {
            // Handle the case where assignee or project is null
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Please select an assignee and project')),
            );
          }
        }
      },
      child: const Text(
        'Create',
        style: TextStyle(fontSize: 14),
      ),
    ),
  ];
}
