import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:clockify_project/data/models/tag/tag.dart';

class TagController extends GetxController {
  late final Box<Tag> _tagBox;
  var tags = <Tag>[].obs;

  @override
  void onInit() {
    super.onInit();
    _tagBox = Hive.box<Tag>('tags');
    ever(UserController.instance.currentUser, (_) => _loadTags());
    _loadTags();
  }

  void _loadTags() {
    final UserController userController = UserController.instance;
    final currentUser = userController.getCurrentUser();

    if (currentUser != null) {
      final tagIds = currentUser.tagsKey;
      final userTags =
          tagIds.map((id) => _tagBox.get(id)).whereType<Tag>().toList();

      tags.assignAll(userTags);
    } else {
      // tags.assignAll(_tagBox.values.toList());

      print('No current user, loading all tags: ${_tagBox.values.toList()}');
    }
  }

  void addTag(Tag tag) {
    final UserController userController = Get.find<UserController>();
    final currentUser = userController.getCurrentUser();

    if (currentUser != null) {
      _tagBox.put(tag.id, tag);
      tags.add(tag);
      currentUser.tagsKey.add(tag.id);
      userController.updateUser(currentUser);
    }
  }

  Tag? getTagById(String id) {
    return tags.firstWhereOrNull((tag) => tag.id == id);
  }

  void removeTagById(String id) {
    final tag = getTagById(id);
    if (tag != null) {
      _tagBox.delete(id); // Ensure correct ID is used for deletion
      tags.remove(tag);
    }
  }

  void updateTag(Tag updatedTag) {
    final index = tags.indexWhere((tag) => tag.id == updatedTag.id);
    if (index != -1) {
      _tagBox.put(updatedTag.id, updatedTag);
      tags[index] = updatedTag;
    }
  }
}
