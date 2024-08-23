import 'package:clockify_project/component/edit_client.dialog.dart';
import 'package:clockify_project/component/infoboxcolumn.dart';
import 'package:clockify_project/component/tablebox.dart';
import 'package:clockify_project/component/headtablebox.dart';
import 'package:clockify_project/data/controller/clientController.dart';
import 'package:clockify_project/data/models/client/client.dart';
import 'package:clockify_project/mixin.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen>
    with ScrollableMixin<ClientsScreen> {
  String dropdownValue = 'Show active';
  bool isChecked = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addClientController = TextEditingController();
  final ClientController clientController = Get.put(ClientController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
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
              ? screenheight * 0.06
              : !isPortrait
                  ? (screenheight * 0.1)
                  : screenheight * 0.03,
          horizontal: isMobile ? screenwidth * 0.04 : screenwidth * 0.05,
        ),
        child: Column(
          children: [
            _buildHeader(isMobile, isPortrait),
            SizedBox(height: 30),
            _buildClientsContent(isMobile, isPortrait),
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
                _buildAddClientsField(isMobile),
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
                SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: _buildAddClientsField(isMobile),
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

  Widget _buildAddClientsField(bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: addClientController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              hintText: 'Add new client',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            setState(() {
              // Add your tag addition logic here
              // addTagController.clear();
            });
          },
          child: const Text(
            'ADD',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildClientsContent(bool isMobile, bool isPortrait) {
    return Tablebox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TopBox(
            padding: [12, 28],
            child: const Text(
              'clients',
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
                          'Address',
                        )),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(
                        flex: 2,
                        child: Text(
                          'Currency',
                        )),
                isMobile && isPortrait
                    ? SizedBox()
                    : Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          ),
          ConstrainedBox(
              key: constrainedBoxKey,
              constraints: BoxConstraints(
                maxHeight: maxHeight,
              ),
              child: _buildclientList(isMobile, isPortrait))
        ],
      ),
    );
  }

  Widget _buildclientList(bool isMobile, bool isPortrait) {
    final clients = clientController.clients;
    return Obx(() {
      final int totalItems = clients.length;
      return ListView.builder(
        physics: scrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return Infoboxcolumn(
              totalItems: totalItems,
              index: index,
              child: isMobile && isPortrait
                  ? backdrop(client)
                  : regularRow(client));
        },
      );
    });
  }

  Widget regularRow(Client client) {
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
              Text(client.name)
            ])),
        Flexible(
            flex: 6,
            child: Row(children: [
              VerticalDivider(),
              Flexible(
                  child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      client.address)),
            ])),
        Expanded(
            flex: 2,
            child: Row(children: [
              VerticalDivider(),
              Container(child: Text(client.currency))
            ])),
        Expanded(
          flex: 2,
          child: Row(children: [
            VerticalDivider(),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () =>
                  editClientDialog(client: client, context: context),
            ),
            VerticalDivider(),
            Icon(Icons.more_vert)
          ]),
        )
      ],
    );
  }

  // Widget backdrop(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         turns += 1 / 2;
  //       });
  //     },
  //     child: AnimatedContainer(
  //       color: Colors.amber,
  //       duration: Duration(milliseconds: 500),
  //       child: Column(children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(client.name),
  //             AnimatedRotation(
  //               turns: turns,
  //               duration: Duration(milliseconds: 500),
  //               child: Icon(Icons.arrow_downward_rounded),
  //             )
  //           ],
  //         ),
  //       ]),
  //     ),
  //   );
  // }

  Widget backdrop(Client client) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text('Name'),
          subtitle: Text(client.name),
          children: [
            ListTile(
              title: Text('Address'),
              subtitle: Text(client.address),
            ),
            ListTile(
              title: Text('Currency'),
              subtitle: Text(client.currency),
            )
          ],
          onExpansionChanged: (bool expand) {
            setState(() {});
          },
        ));
  }
}
