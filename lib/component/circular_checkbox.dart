import 'package:flutter/material.dart';

class CircularCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CircularCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CircularCheckboxState createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  void didUpdateWidget(CircularCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      isChecked = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged(isChecked);
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
