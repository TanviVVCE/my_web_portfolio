import 'package:flutter/material.dart';
import 'package:my_portfolio/features/projects/presentation/widgets/project_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
// import '../widgets/projects_section.dart';
import '../widgets/experience_timeline.dart';
import '../widgets/contact_section.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(children: const [ProjectsSection()])),
    );
  }
}
