import 'package:clockify_project/component/circular_checkbox.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/mixin.dart';
import 'package:flutter/material.dart';

class AccessTab extends StatefulWidget {
  final Project project;
  const AccessTab({Key? key, required this.project}) : super(key: key);

  @override
  State<AccessTab> createState() => _AccessTabState();
}

class _AccessTabState extends State<AccessTab> with ScrollableMixin<AccessTab> {
  String dropdownValue = 'Option 1';
  bool _isHovering = false;

  var users = [
    {'name': 'User1', 'bill-rate': 100, 'role': 'owner'},
    {'name': 'User2', 'bill-rate': null, 'role': 'member'},
    {'name': 'User2', 'bill-rate': null, 'role': 'member'},
    {'name': 'User2', 'bill-rate': null, 'role': 'member'},
    {'name': 'User2', 'bill-rate': null, 'role': 'member'},
    {'name': 'User3', 'bill-rate': 100, 'role': 'member'}
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
  }

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height * 0.18;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibility',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Only people you add to the project can track time on it.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 10),
        Row(children: [
          Row(children: [
            // CircularCheckbox(),
            SizedBox(width: 5),
            Text('Light'),
          ]),
          SizedBox(width: 20),
          Row(children: [
            // CircularCheckbox(),
            SizedBox(width: 5),
            Text('Dark'),
          ]),
        ]),
        SizedBox(height: 15),
        Divider(),
        SizedBox(height: 10),
        _buildaddMember(),
        SizedBox(height: 15),
        _builduserList(),
      ],
    );
  }

  Widget _builduserList() {
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
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(users[index]['name'].toString())),
                      Expanded(
                          flex: 4,
                          child: Container(
                            child: Row(
                              children: [
                                Text(users[index]['bill-rate'] == null
                                    ? '-'
                                    : users[index]['bill-rate'].toString()),
                                GestureDetector(
                                  child: Text('Change'),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Text(users[index]['role'].toString())),
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

  Widget _buildaddMember() {
    return InkWell(
      onTap: () {},
      onHover: (hovering) {
        setState(() {
          _isHovering = hovering;
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.blue,
              ),
            ),
            TextSpan(
              text: " Add member",
              style: TextStyle(
                color: Colors.blue,
                decoration: _isHovering
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
