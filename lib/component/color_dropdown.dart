import 'package:flutter/material.dart';

class ColorDropdownButton extends StatefulWidget {
  final Color initialColor;
  final Function(Color) onColorSelected;

  ColorDropdownButton({
    Key? key,
    required this.initialColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  _ColorDropdownButtonState createState() => _ColorDropdownButtonState();
}

class _ColorDropdownButtonState extends State<ColorDropdownButton> {
  late Color _selectedColor;

  late final List<Map<String, dynamic>> _dropdownItems;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;

    _dropdownItems = [
      {
        'color': _selectedColor,
        'label': 'Selected Color'
      }, // Default selected color
      {'color': Colors.green, 'label': 'Green'},
      {'color': Colors.red, 'label': 'Red'},
      {'color': Colors.blue, 'label': 'Blue'},
    ];
  }

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
        value: _dropdownItems.firstWhere(
          (item) => item['color'] == _selectedColor,
          orElse: () => _dropdownItems.first,
        )['label'],
        hint: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: _selectedColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedColor = _dropdownItems.firstWhere(
              (item) => item['label'] == newValue,
            )['color'];
            widget.onColorSelected(_selectedColor);
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
