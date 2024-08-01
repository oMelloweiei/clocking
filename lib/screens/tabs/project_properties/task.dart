import 'package:clockify_project/mixin.dart';
import 'package:flutter/material.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> with ScrollableMixin<TaskTab> {
  String dropdownValue = 'Show active';
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addNewTaskController = TextEditingController();

  var tasks = [
    {'name': 'Mobile App', 'assign': 'Anyone'},
    {'name': 'Marketing', 'assign': 'Anyone'},
    {'name': 'Mobile App', 'assign': 'Anyone'},
    {'name': 'Mobile App', 'assign': 'Anyone'},
    {'name': 'Marketing', 'assign': 'Anyone'},
    {'name': 'Mobile App', 'assign': 'Anyone'},

    // Add more tasks if needed
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
  }

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height * 0.32;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 20),
        _buildTaskContent(maxHeight),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Show active', 'Option 2', 'Option 3', 'Option 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(width: 15),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  hintText: 'Search by name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: addNewTaskController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  hintText: 'Add new task',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  tasks.add({
                    'name': addNewTaskController.text,
                    'assign': 'Anyone',
                  });
                  addNewTaskController.clear();
                });
              },
              child: const Text(
                'ADD',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTaskContent(double maxHeight) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        boxShadow: const [
          // BoxShadow(
          //   color: Colors.black12,
          //   blurRadius: 8.0,
          //   offset: Offset(0, 2),
          // ),
        ],
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Text('NAME',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text('ASSIGNEES',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          ConstrainedBox(
            key: constrainedBoxKey,
            constraints: BoxConstraints(
              maxHeight: maxHeight,
            ),
            child: ListView.builder(
              physics: scrollable
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(tasks[index]['name']!)),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton<String>(
                            value: tasks[index]['assign'],
                            onChanged: (String? newValue) {
                              setState(() {
                                tasks[index]['assign'] = newValue!;
                              });
                            },
                            items: <String>[
                              'Anyone',
                              'Option 2',
                              'Option 3',
                              'Option 4'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            isExpanded: true,
                            underline: SizedBox(),
                          ),
                        ),
                      ),
                      Icon(Icons.more_vert),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
