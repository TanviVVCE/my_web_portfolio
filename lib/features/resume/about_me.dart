import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(children: [WidgetCommons().navigationBarClass(context)]));
  }
}
