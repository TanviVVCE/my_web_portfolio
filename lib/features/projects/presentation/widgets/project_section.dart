import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/widgets/quick_action_menu/quick_action_menu.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
// import '../../domain/entities/project.dart';
import 'project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Mobile', 'Web', 'Desktop', 'Backend'];

  // Sample projects data - replace with your actual projects
  final List<Project> _projects = [
    const Project(
      id: '1',
      title: 'Flutter Blog Portfolio',
      description:
          'A responsive blog and portfolio website built with Flutter Web, featuring clean architecture and BLoC state management.',
      longDescription:
          'Complete portfolio and blog platform showcasing modern Flutter development practices including clean architecture, BLoC pattern, responsive design, and deployment strategies.',
      imageUrl: 'assets/images/projects/blog_portfolio.jpg',
      technologies: ['Flutter', 'Dart', 'BLoC', 'Clean Architecture', 'Firebase'],
      githubUrl: 'https://github.com/TanviVVCE/my_web_portfolio',
      liveUrl: 'https://tanvivvce.github.io/my_web_portfolio',
      category: 'Web',
      featured: true,
    ),
    const Project(
      id: '2',
      title: 'E-Commerce Mobile App',
      description:
          'Full-featured e-commerce application with product catalog, cart, checkout, and payment integration.',
      imageUrl: 'assets/images/projects/ecommerce_app. jpg',
      technologies: ['Flutter', 'Firebase', 'Stripe', 'Provider'],
      githubUrl: 'https://github.com/yourusername/ecommerce-app',
      category: 'Mobile',
      featured: true,
    ),
    const Project(
      id: '3',
      title: 'Weather Forecast App',
      description:
          'Beautiful weather application with real-time forecasts, location-based weather, and interactive maps.',
      imageUrl: 'assets/images/projects/weather_app.jpg',
      technologies: ['Flutter', 'OpenWeather API', 'Riverpod', 'Maps'],
      githubUrl: 'https://github.com/yourusername/weather-app',
      liveUrl: 'https://your-weather-app.web.app',
      category: 'Mobile',
    ),
    const Project(
      id: '4',
      title: 'Task Management Dashboard',
      description:
          'Productivity dashboard for managing tasks, projects, and team collaboration with real-time updates.',
      imageUrl: 'assets/images/projects/task_dashboard.jpg',
      technologies: ['Flutter', 'Web', 'WebSockets', 'Node.js'],
      githubUrl: 'https://github.com/yourusername/task-dashboard',
      liveUrl: 'https://task-dashboard.app',
      category: 'Web',
    ),
    const Project(
      id: '5',
      title: 'Chat Application',
      description: 'Real-time messaging app with group chats, media sharing, and end-to-end encryption.',
      imageUrl: 'assets/images/projects/chat_app.jpg',
      technologies: ['Flutter', 'Firebase', 'Cloud Functions', 'BLoC'],
      githubUrl: 'https://github.com/yourusername/chat-app',
      category: 'Mobile',
    ),
    const Project(
      id: '6',
      title: 'REST API Backend',
      description:
          'Scalable REST API built with Node.js and Express, featuring authentication, database integration, and API documentation.',
      imageUrl: 'assets/images/projects/backend_api.jpg',
      technologies: ['Node.js', 'Express', 'MongoDB', 'JWT', 'Docker'],
      githubUrl: 'https://github.com/yourusername/api-backend',
      category: 'Backend',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Project> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return _projects;
    }
    return _projects.where((project) => project.category == _selectedCategory).toList();
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return QuickActionMenu(
      onTap: _navigateToHome,
      icon: Icons.menu,
      backgroundColor: AppColors.navigationRailIconColor,
      actions: WidgetCommons().getQuickActions(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getHorizontalPadding(context),
          vertical: ResponsiveHelper.getVerticalPadding(context) * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            _buildSectionHeader(theme, isMobile),
            SizedBox(height: isMobile ? 24 : 32),

            // Category Filter
            _buildCategoryFilter(theme, isMobile),
            SizedBox(height: isMobile ? 24 : 40),

            // Projects Grid
            _buildProjectsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: isMobile ? 32 : 40,
              decoration: BoxDecoration(
                // gradient: AppColors.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Text('My Projects', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Explore my latest work and side projects',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.brightness == Brightness.dark ? AppColors.borderColor : AppColors.borderColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(ThemeData theme, bool isMobile) {
    if (isMobile) {
      return SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = category == _selectedCategory;
            return _buildCategoryChip(category, isSelected, theme);
          },
        ),
      );
    }

    return Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: _categories.map((category) {
          final isSelected = category == _selectedCategory;
          return _buildCategoryChip(category, isSelected, theme);
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected, ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
        backgroundColor: theme.brightness == Brightness.dark ? AppColors.borderColor : Colors.white,
        selectedColor: AppColors.borderColor,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : theme.brightness == Brightness.dark
              ? AppColors.borderColor
              : AppColors.borderColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isSelected
                ? AppColors.borderColor
                : theme.brightness == Brightness.dark
                ? AppColors.borderColor
                : AppColors.borderColor,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final crossAxisCount = ResponsiveHelper.getCrossAxisCount(context);
    final filteredProjects = _filteredProjects;

    if (filteredProjects.isEmpty) {
      return _buildEmptyState(context);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: GridView.builder(
        key: ValueKey(_selectedCategory),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: ResponsiveHelper.isMobile(context) ? 0.75 : 0.8,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        itemCount: filteredProjects.length,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 300 + (index * 100)),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: ProjectCard(
              project: filteredProjects[index],
              onTap: () => _showProjectDetail(filteredProjects[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          children: [
            Icon(
              Icons.folder_open,
              size: 64,
              color: theme.brightness == Brightness.dark ? AppColors.borderColor : AppColors.borderColor,
            ),
            const SizedBox(height: 16),
            Text(
              'No projects found',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.brightness == Brightness.dark ? AppColors.borderColor : AppColors.borderColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try selecting a different category',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.brightness == Brightness.dark ? AppColors.borderColor : AppColors.borderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProjectDetail(Project project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(project.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(project.longDescription ?? project.description),
              const SizedBox(height: 16),
              const Text('Technologies: ', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.technologies.map((tech) {
                  return Chip(label: Text(tech));
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }
}
