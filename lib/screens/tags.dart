import 'package:clockify_project/component/edit_tag_dialog.dart';
import 'package:clockify_project/component/infoboxcolumn.dart';
import 'package:clockify_project/component/tablebox.dart';
import 'package:clockify_project/component/headtablebox.dart';
import 'package:clockify_project/data/controller/tagController.dart';
import 'package:clockify_project/data/models/tag/tag.dart';
import 'package:clockify_project/mixin.dart';
import 'package:clockify_project/screenconfig.dart';
import 'package:clockify_project/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen>
    with ScrollableMixin<TagsScreen> {
  String dropdownValue = 'Show active';
  bool isChecked = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController addTagController = TextEditingController();
  final TagController tagController = Get.put(TagController());
  final _formKey = GlobalKey<FormState>();

  List<Tag> filteredTags = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
    searchController.addListener(_filterTags);
    filteredTags = tagController.tags;
  }

  void _filterTags() {
    setState(() {
      filteredTags = tagController.tags.where((tag) {
        return tag.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    });
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
            _buildHeader(isMobile, isPortrait, screenheight),
            SizedBox(height: 20),
            _buildTagsContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isPortrait, double screenheight) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          if (isMobile && isPortrait)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdownAndSearchField(isMobile, isPortrait),
                SizedBox(height: 20),
                _buildAddTagField(isMobile, screenheight),
              ],
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildDropdownAndSearchField(isMobile, isPortrait),
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                  child: _buildAddTagField(isMobile, screenheight),
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
              // counterText: '',
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

  Widget _buildAddTagField(bool isMobile, double screenheight) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              validator: (value) =>
                  Validator.validateEmptyText('Tag name', value),
              controller: addTagController,
              decoration: InputDecoration(
                // counterText: ' ',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                hintText: 'Add new tag',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          SizedBox(
            height: screenheight * 0.07,
            width: screenheight * 0.15,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() {
                    final String tagName = addTagController.text;
                    final newTag = Tag.create(name: tagName);
                    tagController.addTag(newTag);
                    addTagController.clear();
                  });
                }
              },
              child: const Text(
                'ADD',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsContent() {
    return Tablebox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TopBox(
            child: const Text(
              'Tags',
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
                    flex: 2,
                    child: Row(children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text('Name'),
                    ])),
              ],
            ),
          ),
          ConstrainedBox(
              key: constrainedBoxKey,
              constraints: BoxConstraints(
                maxHeight: maxHeight,
              ),
              child: _buildListTag()),
        ],
      ),
    );
  }

  Widget _buildListTag() {
    return Obx(() {
      final int totalItems = filteredTags.length;
      return ListView.builder(
        physics: scrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredTags.length,
        itemBuilder: (context, index) {
          final tag = filteredTags[index];
          return Infoboxcolumn(
              totalItems: totalItems, index: index, child: listInner(tag));
        },
      );
    });
  }

  Widget listInner(Tag tag) {
    return IntrinsicHeight(
        child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text(tag.name),
            ],
          ),
        ),
        SizedBox(width: 20),
        Row(
          children: [
            VerticalDivider(),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => editTagDialog(tag: tag, context: context),
            ),
            VerticalDivider(),
            Icon(Icons.more_vert),
          ],
        ),
      ],
    ));
  }
}
