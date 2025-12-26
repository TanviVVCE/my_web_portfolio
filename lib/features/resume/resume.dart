import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:web/web.dart' as web;

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _downloadResume() async {
    if (kIsWeb) {
      // Web platform - download from assets
      try {
        final byteData = await rootBundle.load('assets/resume/resume.pdf');
        final bytes = byteData.buffer.asUint8List();

        // Convert Uint8List to JSUint8Array
        final jsBytes = bytes.toJS;

        // Create blob using package:web
        final blob = web.Blob([jsBytes].toJS);
        final url = web.URL.createObjectURL(blob);

        // Create and trigger download
        final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
        anchor.href = url;
        anchor.download = 'Tanvi_Patil_Resume.pdf';
        web.document.body?.appendChild(anchor);
        anchor.click();
        web.document.body?.removeChild(anchor);

        // Clean up
        web.URL.revokeObjectURL(url);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Resume downloaded successfully! '), backgroundColor: Colors.green),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('❌ Error downloading resume: $e'), backgroundColor: Colors.red));
        }
      }
    } else {
      // Mobile/Desktop platform - open external URL
      // final uri = Uri.parse(resumeDownloadUrl);
      // if (await canLaunchUrl(uri)) {
      //   await launchUrl(uri, mode: LaunchMode.externalApplication);
      // } else {
      //   if (mounted) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text('❌ Could not open resume'),
      //         backgroundColor: Colors.red,
      //       ),
      //     );
      //   }
      // }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17153B),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              _buildDownloadButton(),
              const SizedBox(height: 40),
              _buildSkillsSection(),
              const SizedBox(height: 40),
              _buildExperienceSection(),
              const SizedBox(height: 40),
              _buildEducationSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(16),
        boxShadow: WidgetCommons().boxShadowswithColors(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanvi Virappa Patil',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.fontColor,
                        fontFamily: 'AlfaSlabOne',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Flutter Developer | AI/ML Enthusiast',
                      style: TextStyle(fontSize: 18, color: AppColors.navigationRailIconColor),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.email, color: AppColors.navigationRailIconColor, size: 18),
                        const SizedBox(width: 8),
                        Text('tanvipatil843@gmail.com', style: TextStyle(color: AppColors.fontColor, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.code, color: AppColors.navigationRailIconColor, size: 18),
                        const SizedBox(width: 8),
                        Text('github.com/TanviVVCE', style: TextStyle(color: AppColors.fontColor, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _downloadResume,
        icon: const Icon(Icons.download_rounded),
        label: const Text('Download Resume PDF'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navigationRailIconColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Technical Skills'),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildSkillCategory('Programming Languages', ['Dart', 'Python', 'JavaScript', 'C++'], Icons.code),
            _buildSkillCategory('Frameworks & Tools', ['Flutter', 'Firebase', 'Docker', 'Kubernetes'], Icons.build),
            _buildSkillCategory('State Management', ['BLoC', 'Provider', 'GetX', 'Riverpod'], Icons.settings),
            _buildSkillCategory('AI/ML', ['TensorFlow', 'PyTorch', 'LLMs', 'GenAI'], Icons.psychology),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillCategory(String title, List<String> skills, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width < 768 ? double.infinity : (MediaQuery.of(context).size.width - 88) / 2,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: WidgetCommons().boxShadowswithColors(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.navigationRailIconColor, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.fontColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: skills.map((skill) => _buildSkillChip(skill)).toList()),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.navigationRailIconColor.withOpacity(0.1),
        border: Border.all(color: AppColors.navigationRailIconColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        skill,
        style: TextStyle(color: AppColors.navigationRailIconColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Work Experience'),
        const SizedBox(height: 20),
        _buildTimelineItem(
          isFirst: true,
          isLast: false,
          title: 'Senior Flutter Developer',
          organization: 'Tech Company XYZ',
          period: 'Jan 2023 - Present',
          description: 'Leading Flutter development team',
          points: [
            'Developed 10+ cross-platform mobile applications',
            'Implemented clean architecture and BLoC pattern',
            'Mentored junior developers and conducted code reviews',
            'Integrated AI/ML features using TensorFlow Lite',
          ],
        ),
        _buildTimelineItem(
          isFirst: false,
          isLast: false,
          title: 'Flutter Developer',
          organization: 'StartUp ABC',
          period: 'Jun 2021 - Dec 2022',
          description: 'Full-stack mobile development',
          points: [
            'Built e-commerce mobile app with 50K+ downloads',
            'Integrated payment gateways (Stripe, Razorpay)',
            'Optimized app performance reducing load time by 40%',
            'Implemented Firebase authentication and cloud functions',
          ],
        ),
        _buildTimelineItem(
          isFirst: false,
          isLast: true,
          title: 'Software Development Intern',
          organization: 'Company DEF',
          period: 'Jan 2021 - May 2021',
          description: 'Mobile app development internship',
          points: [
            'Developed UI components using Flutter',
            'Worked on REST API integration',
            'Participated in agile development cycles',
            'Learned DevOps basics with Docker',
          ],
        ),
      ],
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Education'),
        const SizedBox(height: 20),
        _buildTimelineItem(
          isFirst: true,
          isLast: false,
          title: 'Bachelor of Engineering in Computer Science',
          organization: 'Visvesvaraya Technological University',
          period: '2018 - 2022',
          description: 'CGPA: 8.5/10',
          points: [
            'Specialized in Software Engineering and AI/ML',
            'Final year project: AI-powered mobile application',
            'Active member of coding club',
            'Won 2nd place in state-level hackathon',
          ],
        ),
        _buildTimelineItem(
          isFirst: false,
          isLast: true,
          title: 'Pre-University Course (PUC)',
          organization: 'ABC College',
          period: '2016 - 2018',
          description: 'Percentage: 92%',
          points: [
            'Science stream with Computer Science',
            'Developed interest in programming',
            'School topper in Computer Science',
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required bool isFirst,
    required bool isLast,
    required String title,
    required String organization,
    required String period,
    required String description,
    required List<String> points,
  }) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(color: AppColors.navigationRailIconColor, thickness: 2),
      indicatorStyle: IndicatorStyle(
        width: 40,
        height: 40,
        indicator: Container(
          decoration: BoxDecoration(
            color: AppColors.navigationRailIconColor,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderColor, width: 3),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 20),
        ),
      ),
      endChild: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.navigationRailBgColor,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(12),
          boxShadow: WidgetCommons().boxShadowswithColors(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.fontColor),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.business, color: AppColors.navigationRailIconColor, size: 16),
                const SizedBox(width: 8),
                Text(
                  organization,
                  style: TextStyle(fontSize: 14, color: AppColors.navigationRailIconColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.fontColor.withOpacity(0.6), size: 14),
                const SizedBox(width: 8),
                Text(period, style: TextStyle(fontSize: 13, color: AppColors.fontColor.withOpacity(0.7))),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: AppColors.fontColor.withOpacity(0.8), fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 12),
            ...points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        color: AppColors.navigationRailIconColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(point, style: TextStyle(color: AppColors.fontColor, fontSize: 14, height: 1.5)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 32,
          decoration: BoxDecoration(color: AppColors.navigationRailIconColor, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.fontColor,
            fontFamily: 'AlfaSlabOne',
          ),
        ),
      ],
    );
  }
}
