import 'package:clockify_project/data/controller/project/projectController.dart';
import 'package:clockify_project/data/controller/project/projectsettingController.dart';
import 'package:clockify_project/data/models/client/client.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/component/color_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> createProjectDialog({
  required BuildContext context,
  required List<Client> dropdownClient,
  required TextEditingController addProjectController,
}) async {
  final _formKey = GlobalKey<FormState>();
  final ProjectController projectController = Get.find<ProjectController>();
  final ProjectSettingController projectsetting =
      Get.find<ProjectSettingController>();

  final Rx<Client?> selectedDropdownValue =
      Rx<Client?>(dropdownClient.isNotEmpty ? dropdownClient.first : null);

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.black),
              const SizedBox(height: 10),
              _buildProjectNameField(
                addProjectController,
                dropdownClient,
                selectedDropdownValue,
              ),
              const SizedBox(height: 20),
              _buildColorDropdown(),
            ],
          ),
        ),
      ),
      actions: _buildActions(
        context,
        _formKey,
        addProjectController,
        projectController,
        projectsetting,
        selectedDropdownValue,
      ),
    ),
  );
}

Widget _buildTitle() {
  return const Text(
    'Create New Project',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  );
}

Widget _buildProjectNameField(TextEditingController controller,
    List<Client> dropdownClient, Rx<Client?> selectedDropdownValue) {
  return Row(children: [
    Expanded(
        child: TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: 'Enter project name',
        labelText: 'Project Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a project name';
        }
        return null;
      },
    )),
    SizedBox(width: 20),
    Expanded(
        child: _buildClientDropdown(
      dropdownClient,
      selectedDropdownValue,
    )),
  ]);
}

Widget _buildClientDropdown(
  List<Client> clients,
  Rx<Client?> selectedClient,
) {
  return Obx(() {
    return DropdownButtonFormField<Client?>(
      value: selectedClient.value,
      onChanged: (Client? newValue) {
        selectedClient.value = newValue;
      },
      decoration: InputDecoration(
        labelText: 'Select Client',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      isExpanded: true,
      items: clients.map<DropdownMenuItem<Client?>>((Client client) {
        return DropdownMenuItem<Client?>(
          value: client,
          child: Text(client.name),
        );
      }).toList(),
    );
  });
}

Widget _buildColorDropdown() {
  return ColorDropdownButton(
    initialColor: Colors.black,
    onColorSelected: (Color color) {
      // Handle color selection if needed
    },
  );
}

List<Widget> _buildActions(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController addProjectController,
  ProjectController projectController,
  ProjectSettingController projectSettingController,
  Rx<Client?> selectedClient,
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
          final String projectName = addProjectController.text;
          final selectedClientValue = selectedClient.value;

          if (selectedClientValue != null) {
            final newProject = Project.create(
              name: projectName,
              clientKey: selectedClientValue.id,
              trackedKey: '',
              access: '',
            );

            projectController.saveProjectRecord(newProject);
            projectSettingController.createSetting(newProject);

            addProjectController.clear();
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select an assignee')),
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
