import 'package:clockify_project/component/box.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/mixin.dart';
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pie_chart/pie_chart.dart';

class _ChartData {
  _ChartData(this.category, this.hours);
  final String category;
  final double hours;
}

class StatusTab extends StatefulWidget {
  final Project project;
  const StatusTab({Key? key, required this.project}) : super(key: key);

  @override
  State<StatusTab> createState() => _StatusTabState();
}

class _StatusTabState extends State<StatusTab> with ScrollableMixin<StatusTab> {
  final List<Map<String, dynamic>> _tasks = [
    {'name': 'Mobile App', 'assign': 'Anyone', 'tracked': 200, 'amount': 0},
    {'name': 'Marketing', 'assign': 'Anyone', 'tracked': 146, 'amount': 0},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
  }

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height * 0.15;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBoardRow(),
          const SizedBox(height: 20),
          _buildTaskList(),
        ],
      ),
    );
  }

  Widget _buildBoardRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildLeftColumn()),
        const SizedBox(width: 15),
        Expanded(flex: 3, child: _buildPieChart()),
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      children: [
        _buildTrackedBox(),
        const SizedBox(height: 10),
        _buildAmountBox(),
      ],
    );
  }

  Widget _buildTrackedBox() {
    return InfoBox(
      child: Column(
        children: [
          _buildInfoRow('TRACKED', '346 h'),
          const Divider(),
          _buildInfoRow('BILLABLE', '346 h'),
          _buildInfoRow('NON-BILLABLE', '0 h'),
        ],
      ),
    );
  }

  Widget _buildAmountBox() {
    return InfoBox(
      child: _buildInfoRow('AMOUNT', '0 USD'),
    );
  }

  Widget _buildPieChart() {
    return InfoBox(
      child: Center(
        child: PieChart(
          dataMap: _createDataMap(),
          animationDuration: Duration(milliseconds: 800),
          chartType: ChartType.ring,
          ringStrokeWidth: 42,
          chartRadius: MediaQuery.of(context).size.width * 0.15,
          centerText: "346 h",
          colorList: [Colors.green[300]!, Colors.green[100]!],
          legendOptions: LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
          ),
        ),
      ),
    );
  }

  List<_ChartData> _getChartData() {
    double totalTracked = _tasks.fold(0, (sum, item) => sum + item['tracked']);
    return [
      _ChartData('Billable', totalTracked),
      _ChartData('Non-Billable', 0),
    ];
  }

  Map<String, double> _createDataMap() {
    double totalTracked = _tasks.fold(0, (sum, item) => sum + item['tracked']);
    return {
      'Billable': totalTracked,
      'Non-Billable': 0,
    };
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTaskList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              border: const Border(bottom: BorderSide(color: Colors.grey)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
            child: const Text(
              'Tasks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildTaskListHeader(),
          ConstrainedBox(
            key: constrainedBoxKey,
            constraints: BoxConstraints(
              maxHeight: maxHeight,
            ),
            child: ListView.builder(
              physics: scrollable
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return _buildTaskListItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Expanded(
              flex: 3,
              child:
                  Text('NAME', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text('ASSIGNEES',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text('TRACKED',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text('AMOUNT',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildTaskListItem(int index) {
    final task = _tasks[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Text(task['name'].toString())),
          Expanded(
              flex: 3, child: _buildDropdownButton(task['assign'].toString())),
          Expanded(flex: 3, child: Text('${task['tracked']} h')),
          Expanded(flex: 3, child: Text('${task['amount']} USD')),
          const Expanded(flex: 1, child: Icon(Icons.more_vert)),
        ],
      ),
    );
  }

  Widget _buildDropdownButton(String currentValue) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: (String? newValue) {
        // Handle assignment change
      },
      items: <String>['Anyone', 'User1', 'User2']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
      style: TextStyle(color: Colors.blue),
    );
  }
}
