import 'package:clockify_project/component/create_project_dialog.dart';
import 'package:clockify_project/component/infoboxcolumn.dart';
import 'package:clockify_project/component/tablebox.dart';
import 'package:clockify_project/component/headtablebox.dart';
import 'package:clockify_project/data/controller/clientController.dart';
import 'package:clockify_project/data/controller/project/projectController.dart';
import 'package:clockify_project/data/controller/project/projectsettingController.dart';
import 'package:clockify_project/data/models/client/client.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/mixin.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with ScrollableMixin<ProjectsScreen> {
  late List<Client> dropdownClient = [];
  bool isChecked = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addProjectController = TextEditingController();
  final ProjectController projectController = Get.put(ProjectController());
  final ClientController clientController = Get.put(ClientController());
  final ProjectSettingController projectsetting =
      Get.put(ProjectSettingController());
  String dropdownValue = 'Show active';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
    _initializeDropdown();
  }

  void _initializeDropdown() {
    dropdownClient = clientController.clients.toList();
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
          createProjectDialog(
              context: context,
              dropdownClient: dropdownClient,
              addProjectController: addProjectController);
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
    return Obx(() {
      final totalItems = projects.length;
      return ListView.builder(
        physics: scrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          final client = clientController.getClientById(project.clientKey);
          return GestureDetector(
              onTap: () {
                GoRouter.of(context).go(
                  '/project/property_${project.name}',
                  extra: project.id,
                );
              },
              child: Infoboxcolumn(
                  totalItems: totalItems,
                  index: index,
                  child: isMobile && isPortrait
                      ? backdrop(project, client)
                      : regularRow(project, client)));
        },
      );
    });
  }

  Widget regularRow(Project project, Client? client) {
    return IntrinsicHeight(
        child: Row(
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
                client?.name ?? 'Unknown Client',
              )),
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
    ));
  }

  Widget backdrop(Project project, Client? client) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text('Name'),
          subtitle: Text(project.name),
          children: [
            ListTile(
              title: Text('Client'),
              subtitle: Text(
                client?.name ?? 'Unknown Client',
              ),
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
