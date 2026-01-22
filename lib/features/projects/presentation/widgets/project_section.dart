import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import 'project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Flutter', 'Mobile', 'AI/ML/GenAI', 'Backend', 'Web'];

  final List<Project> _projects = [
    const Project(
      id: '1',
      title: 'My Web Portfolio',
      description:
          'A portfolio website built with Flutter Web, showcasing projects, skills, and professional experience.',
      longDescription:
          'Personal portfolio website built with Flutter Web featuring clean architecture, BLoC state management, responsive design optimized for all devices, and deployed on GitHub Pages.  Includes sections for projects, resume, blog integration, and contact information.',
      imageUrl: 'assets/images/projects/portfolio.png',
      technologies: ['Flutter', 'Dart', 'Web', 'BLoC', 'GitHub Pages'],
      githubUrl: 'https://github.com/TanviVVCE/my_web_portfolio',
      liveUrl: 'https://tanvivvce.github.io/my_web_portfolio',
      category: 'Flutter',
      featured: true,
    ),
    const Project(
      id: '2',
      title: 'Resume Swift',
      description: 'A resume making mobile application helping users select templates and modify resumes.',
      longDescription:
          'Flutter-based mobile application published on PlayStore which helps developers and professionals create resumes using JSON-based templates with export functionality.',
      imageUrl: 'assets/images/projects/resume.png',
      technologies: ['Flutter', 'Dart', 'JSON', 'PDF Export'],
      githubUrl: 'https://github.com/itsnits/ResumeMaker',
      liveUrl: 'https://play.google.com/store/apps/details?id=in.solswift.resumeSwift',
      category: 'Flutter',
      featured: true,
    ),
    const Project(
      id: '3',
      title: 'G12',
      description: 'Mobile application helping international students connect with universities.',
      longDescription:
          'Flutter application connecting international students with alumni, professors, and peers for Bachelor program enrollment guidance.',
      imageUrl: 'assets/images/projects/G12.jpg',
      technologies: ['Flutter', 'Firestore', 'Real-time Chat'],
      githubUrl: 'https://github.com/G12Uni/g12app',
      category: 'Flutter',
      featured: false,
    ),
    const Project(
      id: '4',
      title: 'GenAI Text to Speech',
      description: 'VQ-VAE based Generative AI application for text to speech synthesis.',
      longDescription:
          'Tiny diffusion model based TTS using LibriTTS-R dataset, ECAPA-TDNN speaker embeddings, and HiFi-GAN Vocoder.',
      imageUrl: 'assets/images/projects/TTS.png',
      technologies: ['Python', 'VQ-VAE', 'HiFi-GAN', 'Jupyter'],
      category: 'AI/ML/GenAI',
      githubUrl: 'https://github.com/Huanz86251/tinydiffusionTTS',
      featured: true,
    ),
    const Project(
      id: '5',
      title: 'GPU-Accelerated Video Processing',
      description: 'Real-time video processing using CUDA parallel programming.',
      longDescription:
          'GPU-accelerated solutions for edge detection, human detection, video illustration, and stabilization using NVIDIA CUDA.',
      imageUrl: 'assets/images/projects/GPU.jpeg',
      technologies: ['C++', 'CUDA', 'OpenCV', 'Parallel Computing'],
      githubUrl: 'https://github.com/aravind-3105/GPU-Accelerated-Real-Time-Video-Processing-Framework',
      category: 'AI/ML/GenAI',
      featured: true,
    ),
    const Project(
      id: '6',
      title: 'Trade Crypto',
      description: 'Android app for real-time cryptocurrency analysis and trading.',
      longDescription: 'Native Android project supporting real-time cryptocurrency trading and market analysis.',
      imageUrl: 'assets/images/projects/crypto.jpg',
      technologies: ['Java', 'Android', 'API Integration'],
      githubUrl: 'https://github.com/TanviVVCE/Android-CryptoCurrency-Project',
      category: 'Mobile',
      featured: false,
    ),
    const Project(
      id: '7',
      title: 'Post Quantum Cryptography for VANETs',
      description: 'Quantum-resistant blockchains for vehicular communication.',
      longDescription:
          'Research project developing quantum-resistant blockchains for vehicular ad-hoc networks using Post-Quantum Cryptographic algorithms.',
      imageUrl: 'assets/images/projects/PQC.jpg',
      technologies: ['Python', 'Solidity', 'Ganache', 'QAN'],
      githubUrl: 'https://github.com/TanviVVCE/PQC-Vanets',
      category: 'Backend',
      featured: true,
    ),
    const Project(
      id: '8',
      title: 'Telcel',
      description: 'Event management app with AI-based facial registration.',
      longDescription:
          'Flutter application supporting AI/ML facial registration and logging for event participants in Mexico.',
      imageUrl: 'assets/images/projects/telcel.jpg',
      technologies: ['Flutter', 'AI/ML', 'Face Recognition'],
      liveUrl: 'https://apps.apple.com/in/app/conectividad-inteligente/id6451044184',
      category: 'Mobile',
      featured: false,
    ),
    const Project(
      id: '9',
      title: 'Brane Task Manager',
      description: 'Task management app for Brane employees.',
      longDescription: 'Task management with priorities, deadlines, progress tracking, and local data persistence.',
      imageUrl: 'assets/images/projects/Brane.png',
      technologies: ['Flutter', 'SQLite', 'Provider'],
      liveUrl: 'https://apps.apple.com/in/app/brane/id1603829174',
      category: 'Mobile',
      featured: false,
    ),
    const Project(
      id: '10',
      title: 'SDI Warehouse Management',
      description: 'Cross-platform warehouse management solution.',
      longDescription: 'Warehouse management app with Firebase Crashlytics improving debugging by 40%.',
      imageUrl: 'assets/images/projects/SDI-WMS.png',
      technologies: ['Flutter', 'Firebase', 'Hive', 'FCM'],
      liveUrl: 'https://apps.apple.com/in/app/sdi-wms/id6503145632',
      category: 'Mobile',
      featured: false,
    ),
    const Project(
      id: '11',
      title: 'WoofWhere - Pet Playdates App',
      description: 'React based web application',
      longDescription: 'Pet playdate arrangement application using React deployed over Kubernetes',
      imageUrl: 'assets/images/projects/woofwhere.png',
      technologies: ['React', 'Mapbox', 'Hive', 'Docker', 'Kubernetes', 'Digital Ocean', 'Vite'],
      githubUrl: 'https://github.com/chx93965/WoofWhere',
      category: 'Web',
      featured: false,
    ),
  ];

  List<Project> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return _projects;
    }
    return _projects.where((project) => project.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isMobile),
          SizedBox(height: isMobile ? 24 : 32),
          _buildCategoryFilter(isMobile),
          SizedBox(height: isMobile ? 24 : 40),
          _buildProjectsGrid(isMobile, isTablet),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: isMobile ? 28 : 36,
              decoration: BoxDecoration(
                color: AppColors.navigationRailIconColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'My Projects',
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontColor,
                  fontFamily: 'AlfaSlabOne',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore my latest work and contributions',
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: isMobile ? 14 : 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.code, size: 16, color: Colors.white70),
                  const SizedBox(width: 6),
                  Text(
                    '${_projects.length} projects',
                    style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 6),
                  Text(
                    '${_projects.where((p) => p.featured).length} featured',
                    style: const TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(bool isMobile) {
    if (isMobile) {
      return SizedBox(
        height: 45,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = category == _selectedCategory;
            return _buildCategoryChip(category, isSelected);
          },
        ),
      );
    }

    return Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: _categories.map((category) {
          final isSelected = category == _selectedCategory;
          return _buildCategoryChip(category, isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.navigationRailIconColor : AppColors.navigationRailBgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.navigationRailIconColor : AppColors.borderColor.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.navigationRailIconColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.fontColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(bool isMobile, bool isTablet) {
    final filteredProjects = _filteredProjects;

    if (filteredProjects.isEmpty) {
      return _buildEmptyState();
    }

    int crossAxisCount;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: GridView.builder(
        key: ValueKey(_selectedCategory),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: isMobile ? 0.85 : 0.75,
          crossAxisSpacing: isMobile ? 16 : 24,
          mainAxisSpacing: isMobile ? 16 : 24,
        ),
        itemCount: filteredProjects.length,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 300 + (index * 50)),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(opacity: value, child: child),
              );
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: ProjectCard(
                    project: filteredProjects[index],
                    onTap: () => _showProjectDetail(filteredProjects[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64, color: AppColors.borderColor.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              'No projects found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.fontColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Try selecting a different category',
              style: TextStyle(fontSize: 14, color: AppColors.fontColor.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }

  void _showProjectDetail(Project project) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.navigationRailBgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.fontColor),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  project.longDescription ?? project.description,
                  style: TextStyle(color: AppColors.fontColor.withOpacity(0.8), fontSize: 16, height: 1.6),
                ),
                const SizedBox(height: 20),
                Text(
                  'Technologies',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navigationRailIconColor),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies.map((tech) {
                    return Chip(
                      label: Text(tech),
                      backgroundColor: AppColors.navigationRailIconColor.withOpacity(0.2),
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (project.githubUrl != null)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (project.githubUrl!.isNotEmpty == true &&
                                await canLaunchUrl(Uri.parse(project.githubUrl!))) {
                              await launchUrl(Uri.parse(project.githubUrl!), mode: LaunchMode.externalApplication);
                            }
                          },
                          icon: const Icon(Icons.code),
                          label: const Text('View Code'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.borderColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    if (project.githubUrl != null && project.liveUrl != null) const SizedBox(width: 12),
                    if (project.liveUrl != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            if (project.liveUrl!.isNotEmpty == true &&
                                await canLaunchUrl(Uri.parse(project.liveUrl!))) {
                              await launchUrl(Uri.parse(project.liveUrl!), mode: LaunchMode.externalApplication);
                            }
                          },
                          icon: const Icon(Icons.launch),
                          label: const Text('Live Demo'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.navigationRailIconColor,
                            side: BorderSide(color: AppColors.navigationRailIconColor),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
