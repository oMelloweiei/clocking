import 'package:clockify_project/component/box.dart';
import 'package:clockify_project/data/models/project/project.dart';
import 'package:clockify_project/mixin.dart';
import 'package:flutter/material.dart';

class NoteTab extends StatefulWidget {
  final Project project;
  const NoteTab({Key? key, required this.project}) : super(key: key);

  @override
  State<NoteTab> createState() => _NoteTabState();
}

class _NoteTabState extends State<NoteTab> with ScrollableMixin<NoteTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkHeight());
  }

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height * 0.4;
    return InfoBox(child: Text('Add note'));
  }
}
