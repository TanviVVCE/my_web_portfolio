import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:my_portfolio/widgets/quick_action_menu/quick_action_menu.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback? onMainFabTap;

  const PageWrapper({super.key, required this.child, this.onMainFabTap});

  @override
  Widget build(BuildContext context) {
    return QuickActionMenu(
      onTap: onMainFabTap ?? () => Navigator.pushReplacementNamed(context, '/home'),
      icon: Icons.menu,
      backgroundColor: AppColors.navigationRailIconColor,
      actions: WidgetCommons().getQuickActions(context),
      child: child,
    );
  }
}
