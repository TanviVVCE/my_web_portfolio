import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectCard({Key? key, required this.project, this.onTap}) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 8.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final isMobile = ResponsiveHelper.isMobile(context);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _elevationAnimation.value,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                onTap: widget.onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Image
                    _buildProjectImage(context),

                    // Project Content
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16.0 : 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Category
                          _buildHeader(theme),
                          const SizedBox(height: 12),

                          // Description
                          _buildDescription(theme),
                          const SizedBox(height: 16),

                          // Technologies
                          _buildTechnologies(theme),
                          const SizedBox(height: 20),

                          // Action Buttons
                          _buildActionButtons(theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectImage(BuildContext context) {
    return Stack(
      children: [
        // Image
        AspectRatio(
          aspectRatio: 16 / 9,
          child: widget.project.imageUrl.startsWith('http')
              ? Image.network(
                  widget.project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildImagePlaceholder();
                  },
                )
              : Image.asset(
                  widget.project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildImagePlaceholder();
                  },
                ),
        ),

        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
              ),
            ),
          ),
        ),

        // Featured Badge
        if (widget.project.featured)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.boxShadowColors.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Featured',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: AppColors.fontColor,
      child: const Center(child: Icon(Icons.code, size: 48, color: AppColors.borderColor)),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.project.title,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.borderColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.project.category,
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.iconsColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Text(
      widget.project.description,
      style: theme.textTheme.bodyMedium,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTechnologies(ThemeData theme) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.project.technologies.take(4).map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark ? AppColors.borderColor : AppColors.borderColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.brightness == Brightness.dark
                  ? AppColors.borderColor
                  : AppColors.borderColor.withOpacity(0.2),
            ),
          ),
          child: Text(tech, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        if (widget.project.githubUrl != null)
          Expanded(
            child: _buildButton(
              onPressed: () => _launchUrl(widget.project.githubUrl!),
              icon: Icons.code,
              label: 'GitHub',
              isPrimary: false,
              theme: theme,
            ),
          ),
        if (widget.project.githubUrl != null && widget.project.liveUrl != null) const SizedBox(width: 12),
        if (widget.project.liveUrl != null)
          Expanded(
            child: _buildButton(
              onPressed: () => _launchUrl(widget.project.liveUrl!),
              icon: Icons.launch,
              label: 'Live Demo',
              isPrimary: true,
              theme: theme,
            ),
          ),
      ],
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
    required ThemeData theme,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? AppColors.borderColor
            : theme.brightness == Brightness.dark
            ? AppColors.borderColor
            : Colors.white,
        foregroundColor: isPrimary
            ? Colors.white
            : theme.brightness == Brightness.dark
            ? AppColors.borderColor
            : AppColors.borderColor,
        elevation: isPrimary ? 2 : 0,
        side: isPrimary
            ? null
            : BorderSide(color: theme.brightness == Brightness.dark ? AppColors.borderColor : AppColors.borderColor),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
