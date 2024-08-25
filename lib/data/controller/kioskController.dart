import 'package:clockify_project/data/controller/user/userController.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:clockify_project/data/models/entry/entry.dart';

class KioskController extends GetxController {
  late final Box<Kiosk> _kioskBox;
  var kiosks = <Kiosk>[].obs;

  @override
  void onInit() {
    super.onInit();
    _kioskBox = Hive.box<Kiosk>('kiosks');
    ever(UserController.instance.currentUser, (_) => _loadkiosks());
    _loadkiosks();
  }

  void _loadkiosks() {
    final UserController userController = UserController.instance;
    final currentUser = userController.getCurrentUser();
    if (currentUser != null) {
      final kioskIds = currentUser.kiosksKey;
      final userKiosks =
          kioskIds.map((id) => _kioskBox.get(id)).whereType<Kiosk>().toList();
      kiosks.assignAll(userKiosks);
    } else {}
  }

  Future<void> saveKioskRecord(Kiosk kiosk) async {
    try {
      await _kioskBox.put(kiosk.id, kiosk);
      kiosks.add(kiosk);

      final currentUser = UserController.instance.getCurrentUser();

      if (currentUser != null) {
        currentUser.kiosksKey.add(kiosk.id);
        UserController.instance.updateUser(currentUser);
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try again $e");
    }
  }

  Kiosk? getKioskById(String id) {
    return kiosks.firstWhereOrNull((Kiosk) => Kiosk.id == id);
  }

  void removeKioskById(String id) {
    final kiosk = getKioskById(id);
    if (kiosk != null) {
      _kioskBox.delete(kiosk.id);
      kiosks.remove(kiosk);
    }
  }

  void updateKiosk(Kiosk updatedKiosk) {
    final index = kiosks.indexWhere((Kiosk) => Kiosk.id == updatedKiosk.id);
    if (index != -1) {
      _kioskBox.put(updatedKiosk.id, updatedKiosk);
      kiosks[index] = updatedKiosk;
    }
  }
}
