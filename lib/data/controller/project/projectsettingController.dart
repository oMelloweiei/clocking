import 'package:clockify_project/data/controller/project/projectController.dart';
import 'package:clockify_project/data/models/project_setting/project_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ProjectSettingController extends GetxController {
  late final Box<ProjectSetting> _projectsettingbox;

  //dummy from map change
  var projectsetting = ProjectSetting(
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
    _projectsettingbox = Hive.box<ProjectSetting>('projectsetting');
    // ever(
    //     ProjectController().instance.currentUser, (_) => _loadProjectSetting());
    // _loadProjectSetting();
  }
  //load Projectsetting by id ==> Projectsetting.id == project.id
  // void _loadProjectSetting() {

  // }

  void createSetting(ProjectSetting projectsetting) {
    _projectsettingbox.put(projectsetting.id, projectsetting);
  }
}
