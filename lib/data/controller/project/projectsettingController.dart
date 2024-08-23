import 'package:clockify_project/data/controller/project/projectController.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/data/models/project_setting/project_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ProjectSettingController extends GetxController {
  late final Box<ProjectSetting> _projectSettingBox;

  //dummy for map change
  var projectSetting = ProjectSetting(
          id: '',
          clientKey: 'clientKey',
          color: Colors.white,
          onBillable: false,
          billablerate: 0.0,
          estimate: '')
      .obs;

  @override
  void onInit() {
    super.onInit();
    _projectSettingBox = Hive.box<ProjectSetting>('projectsetting');
  }

  //load Projectsetting by id ==> Projectsetting.id == project.id
  void loadProjectSetting(String projectId) {
    var setting = _projectSettingBox.get(projectId);
    if (setting != null) {
      projectSetting.value = setting;
    } else {
      // Handle case where no setting exists
    }
  }

  void createSetting(Project project) {
    var projectSetting = ProjectSetting(
        id: project.id,
        clientKey: 'clientKey',
        color: Colors.white,
        onBillable: false,
        billablerate: 0.0,
        estimate: '');

    _projectSettingBox.put(projectSetting.id, projectSetting);
  }

  //Update name of project
  void updatename(String projectkey, String newname) {
    final projectController = Get.find<ProjectController>();
    final project = projectController.getProjectById(projectkey);

    project!.name = newname;
    projectController.updateProject(project);
  }

  // Update client key
  void updateClientKey(String newClientKey) {
    projectSetting.update((setting) {
      setting?.clientKey = newClientKey;
    });
    _saveProjectSetting();
  }

  // Update color
  void updateColor(Color newColor) {
    projectSetting.update((setting) {
      setting?.color = newColor;
    });
    _saveProjectSetting();
  }

  // Update billable status
  void updateOnBillable(bool newOnBillable) {
    projectSetting.update((setting) {
      setting?.onBillable = newOnBillable;
    });
    _saveProjectSetting();
  }

  // Update billable rate
  void updateBillableRate(double newBillableRate) {
    projectSetting.update((setting) {
      setting?.billablerate = newBillableRate;
    });
    _saveProjectSetting();
  }

  // Update estimate
  void updateEstimate(String newEstimate) {
    projectSetting.update((setting) {
      setting?.estimate = newEstimate;
    });
    _saveProjectSetting();
  }

  void _saveProjectSetting() {
    if (projectSetting.value.id.isNotEmpty) {
      _projectSettingBox.put(projectSetting.value.id, projectSetting.value);
    }
  }
}
