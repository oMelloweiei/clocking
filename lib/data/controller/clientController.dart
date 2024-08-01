import 'package:clockify_project/data/controller/userController.dart';
import 'package:clockify_project/data/models/client/client.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ClientController extends GetxController {
  late final Box<Client> _clientBox;
  var clients = <Client>[].obs;

  @override
  void onInit() {
    super.onInit();
    _clientBox = Hive.box<Client>('clients');
    ever(UserController.instance.currentUser, (_) => _loadclients());
    _loadclients();
  }

  void _loadclients() {
    final UserController userController = UserController.instance;
    final currentUser = userController.getCurrentUser();

    if (currentUser != null) {
      final clientIds = currentUser.clientsKey;
      final userClients = clientIds
          .map((id) => _clientBox.get(id))
          .whereType<Client>()
          .toList();
      clients.assignAll(userClients);
    } else {}
  }

  void addClient(Client Client) {
    _clientBox.add(Client);
    clients.add(Client);
  }

  Client? getClientById(String id) {
    return clients.firstWhereOrNull((Client) => Client.id == id);
  }

  void removeClientById(String id) {
    final Client = getClientById(id);
    if (Client != null) {
      _clientBox.delete(Client.id);
      clients.remove(Client);
    }
  }

  void updateClient(Client updatedClient) {
    final index = clients.indexWhere((Client) => Client.id == updatedClient.id);
    if (index != -1) {
      _clientBox.put(updatedClient.id, updatedClient);
      clients[index] = updatedClient;
    }
  }
}
