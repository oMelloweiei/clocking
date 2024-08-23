import 'package:clockify_project/component/create_kiosk_dialog.dart';
import 'package:clockify_project/component/infoboxcolumn.dart';
import 'package:clockify_project/component/tablebox.dart';
import 'package:clockify_project/component/headtablebox.dart';
import 'package:clockify_project/data/controller/kioskController.dart';
import 'package:clockify_project/data/controller/project/projectController.dart';
import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:clockify_project/data/models/entry/entry.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/data/models/user/user.dart';
import 'package:clockify_project/mixin.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KiosksScreen extends StatefulWidget {
  const KiosksScreen({super.key});

  @override
  State<KiosksScreen> createState() => _KiosksScreenState();
}

class _KiosksScreenState extends State<KiosksScreen>
    with ScrollableMixin<KiosksScreen> {
  String dropdownValue = 'Show active';
  String dropdowndata = 'Everyone';
  bool isChecked = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addKioskController = TextEditingController();
  final ProjectController projectController = Get.put(ProjectController());
  final KioskController kioskController = Get.put(KioskController());
  final UserController userController = Get.put(UserController());

  late List<User> assigneesList = [];
  late List<Project> projectsList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
    _initializeAssigneesList();
    _initializeProjectsList();
  }

  void _initializeAssigneesList() {
    assigneesList = userController.users.toList();
    setState(() {});
  }

  void _initializeProjectsList() {
    projectsList = projectController.projects.map((p) => p).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenConfig = ScreenConfig.of(context);
    final isMobile = screenConfig.isMobile;
    final isPortrait = screenConfig.isPortrait;
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    maxHeight = isMobile ? screenheight * 0.48 : screenheight * 0.575;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: !isMobile
              ? screenheight * 0.04
              : !isPortrait
                  ? (screenheight * 0.1)
                  : screenheight * 0.03,
          horizontal: isMobile ? screenwidth * 0.04 : screenwidth * 0.05,
        ),
        child: Column(
          children: [
            _buildHeader(isMobile, isPortrait),
            SizedBox(height: 30),
            _buildKiosksContent(isMobile, isPortrait),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isPortrait) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          if (isMobile && isPortrait)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdownAndSearchField(isMobile, isPortrait),
                SizedBox(height: 20),
                _buildAddKiosksField(isMobile),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildDropdownAndSearchField(isMobile, isPortrait),
                ),
                Spacer(),
                _buildAddKiosksField(isMobile),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownAndSearchField(bool isMobile, bool isPortrait) {
    return Row(
      children: [
        DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: DropdownButton<String>(
              icon: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(Icons.arrow_drop_down_rounded)),
              underline: Container(),
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
                  child: Padding(
                      padding: EdgeInsets.only(left: 10), child: Text(value)),
                );
              }).toList(),
            )),
        SizedBox(width: isMobile ? 10 : 20),
        Expanded(
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              hintText: 'Search by name',
              filled: true,
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddKiosksField(bool isMobile) {
    print(projectsList);
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      onPressed: () {
        setState(() {
          createKioskDialog(
              context: context,
              assigneesList: assigneesList,
              projectList: projectsList,
              addKioskController: addKioskController);
        });
      },
      child: const Text(
        'Create Kiosk',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildKiosksContent(bool isMobile, bool isPortrait) {
    return Tablebox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TopBox(
            child: const Text(
              'kiosks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Colors.grey),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(
                        flex: 3,
                        child: Text(
                          'Name',
                        ),
                      ),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(
                        flex: 3,
                        child: Text(
                          'Assignees',
                        )),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(
                        flex: 6,
                        child: Text(
                          'Url',
                        )),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(flex: 3, child: SizedBox()),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          ConstrainedBox(
              key: constrainedBoxKey,
              constraints: BoxConstraints(
                maxHeight: maxHeight,
              ),
              child: _buildkiosksList(isMobile, isPortrait))
        ],
      ),
    );
  }

  Widget _buildkiosksList(bool isMobile, bool isPortrait) {
    final kiosks = kioskController.kiosks;
    return Obx(() {
      final totalItems = kiosks.length;
      return ListView.builder(
        physics: scrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: kiosks.length,
        itemBuilder: (context, index) {
          final kiosk = kiosks[index];
          return Infoboxcolumn(
              totalItems: totalItems,
              padding: [2, 28],
              index: index,
              child:
                  isMobile && isPortrait ? backdrop(kiosk) : regularRow(kiosk));
        },
      );
    });
  }

  Widget regularRow(Kiosk kiosk) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text(kiosk.name)),
        Expanded(
            flex: 3,
            child: Row(children: [
              VerticalDivider(),
              DropdownButton<String>(
                value: dropdowndata,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdowndata = newValue!;
                  });
                },
                items: <String>['Everyone', 'Option 2', 'Option 3', 'Option 4']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ])),
        Expanded(
            flex: 6,
            child: Row(children: [
              VerticalDivider(),
              Flexible(
                  child: Text(
                      maxLines: 1, overflow: TextOverflow.ellipsis, kiosk.url)),
            ])),
        Expanded(flex: 3, child: Text('Launch')),
        Expanded(
          flex: 1,
          child: Row(children: [VerticalDivider(), Icon(Icons.more_vert)]),
        )
      ],
    );
  }

  Widget backdrop(Kiosk kiosk) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text('Name'),
          subtitle: Text(kiosk.name),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  //   Text('Assignees: '),
                  //   DropdownButton<String>(
                  //     value: dropdowndata,
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         dropdowndata = newValue!;
                  //       });
                  //     },
                  //     items: <String>[
                  //       'Everyone',
                  //       'Option 2',
                  //       'Option 3',
                  //       'Option 4'
                  //     ].map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //   )
                  // ]),
                  Text('URL: ${kiosk.url}'),
                ]),
              ),
            ),
          ],
          onExpansionChanged: (bool expand) {
            setState(() {});
          },
        ));
  }
}
