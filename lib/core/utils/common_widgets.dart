import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/widgets/quick_action_menu/src/quick_action.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetCommons {
  navigationBarClass(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxHeight < 600;
        return Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: isSmallScreen ? 400 : 500, minHeight: 200, maxWidth: 110),
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.navigationRailBgColor,
                  border: Border.all(color: AppColors.borderColor),
                  boxShadow: boxShadowswithColors(),
                ),
                child: NavigationRail(
                  backgroundColor: AppColors.navigationRailBgColor,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (value) {
                    if (value == 0) {
                      Navigator.pushReplacementNamed(context, '/projects');
                    } else if (value == 1) {
                      Navigator.pushReplacementNamed(context, '/resume');
                    } else if (value == 2) {
                      Navigator.pushReplacementNamed(context, '/contact');
                    } else if (value == 3) {
                      Navigator.pushReplacementNamed(context, '/blogs');
                    } else if (value == 4) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  destinations: [
                    navigationRailContent(Icons.code, 'Projects'),
                    navigationRailContent(Icons.person, 'Resume'),
                    navigationRailContent(Icons.mail, 'Contact'),
                    navigationRailContent(Icons.message, 'Blogs'),
                    navigationRailContent(Icons.home, 'Home'),
                  ],
                  selectedIndex: null,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            // contactBuilder(context),
          ],
        );
      },
    );
  }

  contactBuilder(BuildContext context) {
    final socialLinks = {
      'assets/logos/linkedin.svg': ['https://www.linkedin.com/in/tanvi-virappa-patil-044796197/', 'LinkedIn'],
      'assets/logos/github.svg': ['https://github.com/TanviVVCE', 'GitHub'],
      'assets/logos/google.svg': ['mailto:tanvipatil843@gmail.com', 'Contact'],
      'assets/logos/blog.svg': ['https://tanvis-blogs.hashnode.dev/', 'Blogs'],
    };

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20), // Add controlled margins
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 20,
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border.all(color: AppColors.borderColor),
        boxShadow: boxShadowswithColors(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: socialLinks.entries.map((entry) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                final url = entry.value[0];
                if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                }
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8), // Add padding for better touch target
                    child: SvgPicture.asset(
                      entry.key,
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(
                        AppColors.navigationRailIconColor, // Colorize SVGs to match theme
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Text(
                    entry.value[1],
                    style: TextStyle(fontFamily: 'Funnel', color: AppColors.navigationRailIconColor),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  navigationRailContent(IconData iconType, String labelText) {
    return NavigationRailDestination(
      icon: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Icon(iconType, color: AppColors.navigationRailIconColor),
      ),
      selectedIcon: Icon(iconType),
      label: Text(labelText, style: TextStyle(fontSize: 12, color: AppColors.navigationRailIconColor)),
    );
  }

  Widget contactInfoBuilder() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 60),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.navigationRailBgColor,
          border: Border.all(color: AppColors.borderColor),
          boxShadow: boxShadowswithColors(),
        ),
        height: 120,
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(left: 18.0, top: 30.0), child: Text('Toronto, ON, CA')),
            GestureDetector(
              onTap: () async {
                final Uri emailUri = Uri(scheme: 'mailto', path: 'tanvipatil843@gmail.com');
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri, mode: LaunchMode.externalApplication);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 8),
                child: Text(
                  'tanvipatil843@gmail.com',
                  style: const TextStyle(
                    color: AppColors.navigationRailIconColor,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BoxShadow> boxShadowswithColors() {
    return const [
      BoxShadow(
        color: AppColors.boxShadowColors,
        blurRadius: 3,
        spreadRadius: 1,
        offset: Offset(0, 0), // shadow equally on all sides
      ),
    ];
  }

  double responsiveFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) return 10; // mobile
    if (width < 900) return 12; // tablet
    return 15; // desktop
  }

  List<QuickAction> getQuickActions(BuildContext context) {
    return [
      QuickAction(
        icon: Icons.code_rounded,
        backgroundColor: AppColors.navigationRailBgColor,
        iconColor: AppColors.navigationRailIconColor,
        onTap: () {
          Navigator.pushReplacementNamed(context, '/projects');
        },
      ),
      QuickAction(
        icon: Icons.person_rounded,
        backgroundColor: AppColors.navigationRailBgColor,
        iconColor: AppColors.navigationRailIconColor,
        onTap: () {
          Navigator.pushReplacementNamed(context, '/resume');
        },
      ),
      QuickAction(
        icon: Icons.message,
        backgroundColor: AppColors.navigationRailBgColor,
        iconColor: AppColors.navigationRailIconColor,
        onTap: () async {
          String url = 'https://tanvis-blogs.hashnode.dev';
          if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          }
        },
      ),
    ];
  }
}
