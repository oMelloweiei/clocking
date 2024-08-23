import 'package:clockify_project/color.dart';
import 'package:flutter/material.dart';
import 'package:clockify_project/data/mockup.dart';

class Sidebar extends StatelessWidget {
  final String selectedWidget;
  final ValueChanged<String> onWidgetSelected;

  Sidebar({required this.selectedWidget, required this.onWidgetSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: subcolor,
      width: 265,
      child: ListView(
        children: [
          _buildSectionHeader('TRACKER'),
          ..._buildSidebarItems('tracker'),
          _buildSectionHeader('MANAGE'),
          ..._buildSidebarItems('manage'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: maincolor,
        ),
      ),
    );
  }

  List<Widget> _buildSidebarItems(String type) {
    return content
        .where((item) => item['type'] == type)
        .map((item) => _buildSidebarItem(item['topic'] as String,
            item['icon'] as IconData, item['route'] as String))
        .toList();
  }

  Widget _buildSidebarItem(String topic, IconData icon, String route) {
    return InkWell(
      onTap: () {
        if (selectedWidget == route) return;
        onWidgetSelected(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        color: selectedWidget == route ? maincolor : Colors.transparent,
        child: Row(
          children: [
            Icon(icon,
                color: selectedWidget == route ? Colors.white : maincolor),
            const SizedBox(width: 8),
            Text(
              topic,
              style: TextStyle(
                fontSize: 18,
                color: selectedWidget == route ? Colors.white : maincolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
