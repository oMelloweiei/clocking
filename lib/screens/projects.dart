import 'package:clockify_project/component/color_dropdown.dart';
import 'package:clockify_project/component/infoboxcolumn.dart';
import 'package:clockify_project/component/tablebox.dart';
import 'package:clockify_project/component/headtablebox.dart';
import 'package:clockify_project/data/controller/projectController.dart';
import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/mixin.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with ScrollableMixin<ProjectsScreen> {
  late List<String> dropdownValue = [
    'Select client',
  ];
  bool isChecked = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addProjectController = TextEditingController();
  final ProjectController projectController = Get.put(ProjectController());
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
    _initializeDropdown();
  }

  void _initializeDropdown() {
    final usersList = userController.getuserslist();
    dropdownValue = ['Select client'] + usersList;
    setState(() {});
  }

  Future openDialog() async {
    final _formKey = GlobalKey<FormState>();
    String selectedDropdownValue = dropdownValue.first;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create New Project'),
                Divider(thickness: 2, color: Colors.black),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: addProjectController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Enter project name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a project name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: DropdownMenu<String>(
                        initialSelection: selectedDropdownValue,
                        onSelected: (String? newValue) {
                          setState(() {
                            selectedDropdownValue = newValue!;
                          });
                        },
                        dropdownMenuEntries: dropdownValue
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                            value: value,
                            label: value,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ColorDropdownButton(),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 14),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final String projectName = addProjectController.text;
                final newProject = Project.create(
                  name: projectName,
                  clientKey: selectedDropdownValue,
                  trackedKey: '',
                  access: '',
                );

                projectController.saveProjectRecord(newProject);
                addProjectController.clear();
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Create',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
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
            _buildProjectsContent(isMobile, isPortrait),
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
                _buildAddProjectsButton(isMobile),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: _buildDropdownAndSearchField(isMobile, isPortrait),
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                  child: _buildAddProjectsButton(isMobile),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownAndSearchField(bool isMobile, bool isPortrait) {
    return Row(
      children: [
        DropdownMenu<String>(
          initialSelection: dropdownValue.first,
          onSelected: (String? newValue) {
            setState(() {
              dropdownValue.first = newValue!;
            });
          },
          dropdownMenuEntries:
              dropdownValue.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
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

  Widget _buildAddProjectsButton(bool isMobile) {
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
          openDialog();
        });
      },
      child: const Text(
        'Create New Project',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildProjectsContent(bool isMobile, bool isPortrait) {
    return Tablebox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TopBox(
            child: const Text(
              'projects',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Colors.grey),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: Row(children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        'Name',
                      ),
                    ])),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(
                        flex: 6,
                        child: Text(
                          'Client',
                        )),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(
                        flex: 2,
                        child: Text(
                          'Tracked',
                        )),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(
                        flex: 2,
                        child: Text(
                          'Access',
                        )),
                Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          ConstrainedBox(
              key: constrainedBoxKey,
              constraints: BoxConstraints(
                maxHeight: maxHeight,
              ),
              child: _buildlistproject(isMobile, isPortrait))
        ],
      ),
    );
  }

  Widget _buildlistproject(bool isMobile, bool isPortrait) {
    final projects = projectController.projects;
    return Obx(
      () => ListView.builder(
        physics: scrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  '/project_property',
                  arguments: project,
                );
              },
              child: Infoboxcolumn(
                  index: index,
                  child: isMobile && isPortrait
                      ? backdrop(project)
                      : regularRow(project)));
        },
      ),
    );
  }

  Widget regularRow(Project project) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Row(children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text(project.name)
            ])),
        Flexible(
            flex: 6,
            child: Row(children: [
              VerticalDivider(),
              Flexible(
                  child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      project.clientKey)),
            ])),
        Expanded(
            flex: 2,
            child: Row(children: [
              VerticalDivider(),
              Container(child: Text(project.trackedKey))
            ])),
        Expanded(
            flex: 2,
            child: Row(children: [
              VerticalDivider(),
              Container(child: Text(project.access))
            ])),
        Expanded(
          flex: 1,
          child: Row(children: [VerticalDivider(), Icon(Icons.more_vert)]),
        )
      ],
    );
  }

  Widget backdrop(Project project) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text('Name'),
          subtitle: Text(project.name),
          children: [
            ListTile(
              title: Text('Client'),
              subtitle: Text(project.clientKey),
            ),
            ListTile(
              title: Text('Tracked'),
              subtitle: Text(project.trackedKey),
            ),
            ListTile(
              title: Text('Access'),
              subtitle: Text(project.access),
            )
          ],
          onExpansionChanged: (bool expand) {
            setState(() {
              scrollable = expand;
            });
          },
        ));
  }
}
