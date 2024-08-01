import 'package:clockify_project/data/controller/tagController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagPopUp extends StatefulWidget {
  TagPopUp({Key? key}) : super(key: key);

  @override
  State<TagPopUp> createState() => _TagPopUpState();
}

class _TagPopUpState extends State<TagPopUp> {
  final Map<String, bool> _tagSelection = {};
  final TagController tagController = Get.put(TagController());

  @override
  void initState() {
    super.initState();
    for (var tag in tagController.tags) {
      _tagSelection[tag.name] = false; // or true based on existing selections
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(240, 45),
      icon: Icon(Icons.tag_outlined),
      itemBuilder: (BuildContext bc) {
        final tags = tagController.tags;
        List<PopupMenuEntry<String>> menuItems = [
          PopupMenuItem(
            enabled: false,
            child: Container(
              padding: EdgeInsets.all(4.0),
              width: 400,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_outlined),
                  hintText: 'Add/Search Tags',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
        ];
        for (var tag in tags) {
          menuItems.add(
            PopupMenuItem<String>(
              value: tag.name,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue,
                    value: _tagSelection[tag.name],
                    onChanged: (bool? value) {
                      setState(() {
                        _tagSelection[tag.name] = value!;
                      });

                      this.setState(() {
                        _tagSelection[tag.name] = value!;
                      });
                    },
                    title: Text(tag.name),
                  );
                },
              ),
            ),
          );
        }
        return menuItems;
      },
    );
  }
}
