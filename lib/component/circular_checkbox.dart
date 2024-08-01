import 'package:flutter/material.dart';

class CircularCheckbox extends StatefulWidget {
  const CircularCheckbox({Key? key}) : super(key: key);

  @override
  _CircularCheckboxState createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: isChecked ? 5.0 : 2.0,
            color: isChecked ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}
