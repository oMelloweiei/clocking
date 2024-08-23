import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clockify_project/data/controller/clientController.dart';
import 'package:clockify_project/data/models/client/client.dart';

Future<void> editClientDialog({
  required BuildContext context,
  required Client client,
}) async {
  final _formKey = GlobalKey<FormState>();
  final clientController = Get.find<ClientController>();
  final nameController = TextEditingController(text: client.name);
  final addressController = TextEditingController(text: client.address);
  final noteController = TextEditingController(text: client.note);
  final selectedCurrency = client.currency.obs;

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
              const SizedBox(height: 20),
              _buildTextField('Name', nameController, 'Enter name'),
              const SizedBox(height: 15),
              _buildTextField('Address', addressController, 'Enter address',
                  maxLines: 3),
              const SizedBox(height: 15),
              _buildTextField('Note', noteController, 'Enter note',
                  maxLines: 5),
              const SizedBox(height: 15),
              _buildCurrencyDropdown(selectedCurrency),
            ],
          ),
        ),
      ),
      actions: _buildDialogActions(
        context: context,
        formKey: _formKey,
        clientController: clientController,
        client: client,
        nameController: nameController,
        addressController: addressController,
        noteController: noteController,
        selectedCurrency: selectedCurrency,
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

Widget _buildCurrencyDropdown(Rx<String> selectedCurrency) {
  final currencies = ['USD', 'EUR', 'GBP', 'BAHT'];
  return Obx(() {
    if (!currencies.contains(selectedCurrency.value)) {
      selectedCurrency.value = currencies.first;
    }

    return DropdownButtonFormField<String>(
      value: selectedCurrency.value,
      onChanged: (newCurrency) {
        selectedCurrency.value = newCurrency!;
      },
      decoration: const InputDecoration(
        labelText: 'Select Currency',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      items: currencies.map((currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
    );
  });
}

List<Widget> _buildDialogActions({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required ClientController clientController,
  required Client client,
  required TextEditingController nameController,
  required TextEditingController addressController,
  required TextEditingController noteController,
  required Rx<String> selectedCurrency,
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
          final upadateclient = Client(
            id: client.id,
            name: nameController.text,
            address: addressController.text,
            note: noteController.text,
            currency: selectedCurrency.value,
          );

          clientController.updateClient(upadateclient);

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
