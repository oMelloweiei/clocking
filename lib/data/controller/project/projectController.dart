import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/data/controller/user/userController.dart';

class ProjectController extends GetxController {
  late final Box<Project> _projectBox;
  RxList<Project> projects = <Project>[].obs;

  @override
  void onInit() {
    super.onInit();
    _projectBox = Hive.box<Project>('projects');

    ever(UserController.instance.currentUser, (_) => _loadProjects());
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      final currentUser = UserController.instance.getCurrentUser();

      if (currentUser != null) {
        final projectIds = currentUser.projectsKey;
        final userProjects = projectIds
            .map((id) => _projectBox.get(id))
            .whereType<Project>()
            .toList();
        projects.assignAll(userProjects);
      } else {
        projects.clear();
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try again $e");
    }
  }

  Future<void> saveProjectRecord(Project project) async {
    try {
      await _projectBox.put(project.id, project);
      projects.add(project);

      final currentUser = UserController.instance.getCurrentUser();

      if (currentUser != null) {
        currentUser.projectsKey.add(project.id);
        UserController.instance.updateUser(currentUser);
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try again $e");
    }
  }

  Project? getProjectById(String id) {
    return projects.firstWhereOrNull((project) => project.id == id);
  }

  void removeProjectById(String id) {
    final project = getProjectById(id);
    if (project != null) {
      _projectBox.delete(id);
      projects.remove(project);

      final currentUser = UserController.instance.getCurrentUser();

      if (currentUser != null) {
        currentUser.projectsKey.remove(id);
        UserController.instance.updateUser(currentUser);
      }
    }
  }

  void updateProject(Project updatedProject) {
    final index =
        projects.indexWhere((project) => project.id == updatedProject.id);
    if (index != -1) {
      _projectBox.put(updatedProject.id, updatedProject);
      projects[index] = updatedProject;
    }
  }
}
