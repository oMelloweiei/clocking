import 'package:flutter/material.dart';

class ColorDropdownButton extends StatefulWidget {
  @override
  _ColorDropdownButtonState createState() => _ColorDropdownButtonState();
}

class _ColorDropdownButtonState extends State<ColorDropdownButton> {
  String? _selectedColor;
  final List<Map<String, dynamic>> _dropdownItems = [
    {'color': Colors.green, 'label': 'Green'},
    {'color': Colors.red, 'label': 'Red'},
    {'color': Colors.blue, 'label': 'Blue'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        value: _selectedColor,
        hint: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedColor = newValue;
          });
        },
        items: _dropdownItems.map((item) {
          return DropdownMenuItem<String>(
            value: item['label'],
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: item['color'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // SizedBox(width: 10),
                // Text(item['label']),
              ],
            ),
          );
        }).toList(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        underline: SizedBox(),
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
