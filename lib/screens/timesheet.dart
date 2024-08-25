import 'package:clockify_project/color.dart';
import 'package:flutter/material.dart';

class TimesheetScreen extends StatelessWidget {
  const TimesheetScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add Date Picker functionality
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text("This week"),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle previous week
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle next week
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Project Time Table
            Expanded(
              child: Column(
                children: [
                  // Table Headers
                  _buildTableHeader(),
                  // Project Rows
                  Expanded(
                    child: ListView(
                      children: [
                        _buildProjectRow("HealWorld", [12, 8, 0, 0, 0, 0, 0]),
                        _buildProjectRow("NightLife", [0, 10, 22, 0, 0, 0, 0]),
                      ],
                    ),
                  ),
                  // Total Row
                  _buildTotalRow([12, 18, 22, 0, 0, 0, 0]),
                ],
              ),
            ),
            // Add New Row Button
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle adding new row
                },
                icon: Icon(Icons.add),
                label: Text("Add new row"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the table header
  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2, child: Text("Projects", textAlign: TextAlign.center)),
          _buildDayHeader("Mon, Feb 5"),
          _buildDayHeader("Tue, Feb 6"),
          _buildDayHeader("Wed, Feb 7"),
          _buildDayHeader("Thu, Feb 8"),
          _buildDayHeader("Fri, Feb 9"),
          _buildDayHeader("Sat, Feb 10"),
          _buildDayHeader("Sun, Feb 11"),
          Expanded(flex: 1, child: Text("Total", textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String day) {
    return Expanded(
      flex: 1,
      child: Text(day, textAlign: TextAlign.center),
    );
  }

  // Builds a project row
  Widget _buildProjectRow(String projectName, List<int> hours) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              flex: 2, child: Text(projectName, textAlign: TextAlign.center)),
          ...hours.map((hour) => _buildTimeBox(hour)),
          Expanded(
              flex: 1,
              child: Text(_formatTotal(hours), textAlign: TextAlign.center)),
          IconButton(
            onPressed: () {
              // Handle row removal
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  // Builds the time box for each day
  Widget _buildTimeBox(int hour) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        textAlign: TextAlign.center,
        initialValue: _formatHour(hour),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  // Builds the total row
  Widget _buildTotalRow(List<int> totals) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.grey[300],
      child: Row(
        children: [
          Expanded(flex: 2, child: Text("Total", textAlign: TextAlign.center)),
          ...totals.map((total) => Expanded(
                flex: 1,
                child: Text(_formatHour(total), textAlign: TextAlign.center),
              )),
          Expanded(
              flex: 1,
              child: Text(_formatTotal(totals), textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  // Format the hour into HH:MM:SS
  String _formatHour(int hour) {
    final duration = Duration(hours: hour);
    return duration.toString().split('.').first.padLeft(8, "0");
  }

  // Format total hours for a row
  String _formatTotal(List<int> hours) {
    final total = hours.reduce((a, b) => a + b);
    return _formatHour(total);
  }
}
