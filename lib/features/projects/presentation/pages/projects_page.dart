import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:my_portfolio/features/projects/presentation/widgets/project_section.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF17153B),
      body: SafeArea(
        child: Row(
          children: [
            // Side Navigation (Desktop only)
            !isMobile ? _buildSideNavigation(context) : _buildTopBar(context, isMobile),
            // Main Content
            Expanded(
              child: Column(
                children: [
                  // Top App Bar

                  // Projects Content
                  const Expanded(child: SingleChildScrollView(child: ProjectsSection())),
                ],
              ),
            ),
          ],
        ),
      ),
      // Mobile bottom navigation
      bottomNavigationBar: isMobile ? _buildBottomNavigation(context) : null,
    );
  }

  Widget _buildSideNavigation(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border(right: BorderSide(color: AppColors.borderColor.withOpacity(0.3))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildNavItem(context, icon: Icons.home, label: 'Home', route: '/home', isSelected: false),

          const SizedBox(height: 8),

          // Projects
          _buildNavItem(context, icon: Icons.code, label: 'Projects', route: '/projects', isSelected: true),

          const SizedBox(height: 8),

          // Resume
          _buildNavItem(context, icon: Icons.person, label: 'Resume', route: '/resume', isSelected: false),

          const SizedBox(height: 8),

          // Contact
          _buildNavItem(context, icon: Icons.message, label: 'Blogs', route: '', isSelected: false),
          const Spacer(),

          // Settings or Theme Toggle
          // IconButton(
          //   icon: const Icon(Icons.settings, color: Colors.white54),
          //   onPressed: () {},
          // ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isSelected,
  }) {
    return Tooltip(
      message: label,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.navigationRailIconColor.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? Border.all(color: AppColors.navigationRailIconColor) : null,
            ),
            child: IconButton(
              icon: Icon(icon, color: isSelected ? AppColors.navigationRailIconColor : Colors.white70),
              onPressed: () async {
                if (label == 'Blogs') {
                  String url = 'https://tanvis-blogs.hashnode.dev';
                  if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  }
                }
                Navigator.pushReplacementNamed(context, route);
              },
            ),
          ),
          SizedBox(height: 10),
          // Text(label),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border(bottom: BorderSide(color: AppColors.borderColor.withOpacity(0.3))),
      ),
      child: Row(
        children: [
          // Menu button for mobile
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => _showMobileMenu(context),
            ),

          // Breadcrumb
          Icon(Icons.code, color: AppColors.navigationRailIconColor, size: 24),
          const SizedBox(width: 12),
          Text(
            'Projects',
            style: TextStyle(
              color: AppColors.fontColor,
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'AlfaSlabOne',
            ),
          ),

          const Spacer(),

          // Quick actions
          if (!isMobile) ...[
            TextButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              icon: const Icon(Icons.home, size: 18),
              label: const Text('Home'),
              style: TextButton.styleFrom(foregroundColor: Colors.white70),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/resume'),
              icon: const Icon(Icons.person, size: 18),
              label: const Text('Resume'),
              style: TextButton.styleFrom(foregroundColor: Colors.white70),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border(top: BorderSide(color: AppColors.borderColor.withOpacity(0.3))),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.navigationRailIconColor,
        unselectedItemColor: Colors.white54,
        currentIndex: 1, // Projects
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              // Already on projects
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/resume');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/contact');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Resume'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Contact'),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.navigationRailBgColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.code, color: AppColors.navigationRailIconColor),
              title: Text(
                'Projects',
                style: TextStyle(color: AppColors.navigationRailIconColor, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Resume', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/resume');
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail, color: Colors.white),
              title: const Text('Contact', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}
