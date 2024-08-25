import 'package:clockify_project/data/controller/tagController.dart';
import 'package:clockify_project/data/models/tag/tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> editTagDialog({
  required BuildContext context,
  required Tag tag,
}) async {
  final _formKey = GlobalKey<FormState>();
  final tagController = Get.find<TagController>();
  final nameController = TextEditingController(text: tag.name);

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle('Edit Client'),
              const SizedBox(height: 5),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              _buildTextField('Name', nameController, 'Enter name'),
            ],
          ),
        ),
      ),
      actions: _buildDialogActions(
        tag: tag,
        context: context,
        formKey: _formKey,
        tagController: tagController,
        nameController: nameController,
      ),
    ),
  );
}

Widget _buildTitle(String title) {
  return Text(
    title,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  );
}

Widget _buildTextField(
    String label, TextEditingController controller, String hintText,
    {int maxLines = 1}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      labelText: label,
      hintText: hintText,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $label.toLowerCase()';
      }
      return null;
    },
  );
}

List<Widget> _buildDialogActions({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TagController tagController,
  required Tag tag,
  required TextEditingController nameController,
}) {
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
          final upadatetag = Tag(
            id: tag.id,
            name: nameController.text,
          );

          tagController.updateTag(upadatetag);

          Navigator.of(context).pop();
        }
      },
      child: const Text(
        'Save',
        style: TextStyle(fontSize: 14),
      ),
    ),
  ];
}
