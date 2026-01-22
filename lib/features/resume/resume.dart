import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web/web.dart' as web;

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  TabController? _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _selectedTab = _tabController!.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> downloadResume() async {
    if (kIsWeb) {
      try {
        final byteData = await rootBundle.load('assets/resume/resume.pdf');
        final bytes = byteData.buffer.asUint8List();
        final jsBytes = bytes.toJS;
        final blob = web.Blob([jsBytes].toJS);
        final url = web.URL.createObjectURL(blob);
        final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
        anchor.href = url;
        anchor.download = 'Tanvi_Patil_Resume.pdf';
        web.document.body?.appendChild(anchor);
        anchor.click();
        web.document.body?.removeChild(anchor);
        web.URL.revokeObjectURL(url);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Yaay !! Resume downloaded successfully!', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.borderColor,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('❌ Error:  $e'), backgroundColor: Colors.red));
        }
      }
    }
  }

  bool get isMobile => MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    // Wait for TabController to be initialized
    if (_tabController == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF17153B),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF17153B),
      body: SafeArea(
        child: Row(
          children: [
            // Left Sidebar - Profile & Navigation
            if (!isMobile) _buildDesktopSidebar(),

            // Main Content Area
            Expanded(
              child: Column(
                children: [
                  // Top Navigation for Mobile
                  if (isMobile) _buildMobileHeader(),

                  // Tab Navigation
                  _buildTabBar(),

                  // Content
                  Expanded(
                    child: TabBarView(
                      controller: _tabController!,
                      children: [
                        _buildSkillsTab(),
                        _buildExperienceTab(),
                        _buildEducationTab(),
                        _buildVoluteeringTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border(right: BorderSide(color: AppColors.borderColor.withOpacity(0.3))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),

          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.navigationRailIconColor),
            ),
            child: ClipOval(child: Image.asset('assets/images/projects/Memoji.gif', fit: BoxFit.cover)),
          ),

          const SizedBox(height: 20),

          // Name
          Text(
            'Tanvi Virappa Patil',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.fontColor,
              fontFamily: 'Funnel',
            ),
          ),

          const SizedBox(height: 8),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Flutter & AI/ML Developer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.navigationRailIconColor, fontFamily: 'Funnel'),
            ),
          ),

          const SizedBox(height: 30),

          // Contact Links
          _buildSidebarLink(Icons.email, 'tanvipatil843@gmail.com', 'mailto:tanvipatil843@gmail.com'),
          _buildSidebarLink(Icons.code, 'GitHub', 'https://github.com/TanviVVCE'),
          _buildSidebarLink(Icons.home, 'Home', ''),
          _buildSidebarLink(Icons.message, 'Blogs', 'https://tanvis-blogs.hashnode.dev/'),

          // _buildSidebarLink(Icons.link, 'Portfolio', 'https://tanvivvce.github.io/my_web_portfolio'),
          const Spacer(),

          // Download Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: downloadResume,
              icon: const Icon(Icons.download),
              label: const Text('Download PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navigationRailIconColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarLink(IconData icon, String text, String url) {
    return InkWell(
      onTap: () async {
        if (text == 'Home') {
          Navigator.pushReplacementNamed(context, '/home');
        }
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.navigationRailIconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: AppColors.fontColor, fontSize: 13, fontFamily: 'Funnel'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        border: Border(bottom: BorderSide(color: AppColors.borderColor.withOpacity(0.3))),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.navigationRailIconColor, width: 2),
                  gradient: LinearGradient(colors: [AppColors.navigationRailIconColor, AppColors.borderColor]),
                ),
                child: const Center(
                  child: Text(
                    'TP',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanvi Patil',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.fontColor,
                        fontFamily: 'Funnel',
                      ),
                    ),
                    Text(
                      'Flutter & AI/ML Developer',
                      style: TextStyle(fontSize: 12, color: AppColors.navigationRailIconColor, fontFamily: 'Funnel'),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: downloadResume,
                icon: Icon(Icons.download, color: AppColors.navigationRailIconColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor.withOpacity(0.5),
        border: Border(bottom: BorderSide(color: AppColors.borderColor.withOpacity(0.3))),
      ),
      child: TabBar(
        controller: _tabController!,
        labelColor: AppColors.navigationRailIconColor,
        unselectedLabelColor: AppColors.fontColor.withOpacity(0.6),
        indicatorColor: AppColors.navigationRailIconColor,
        indicatorWeight: 3,
        tabs: const [
          Tab(icon: Icon(Icons.code), text: 'Skills'),
          Tab(icon: Icon(Icons.work), text: 'Experience'),
          Tab(icon: Icon(Icons.school), text: 'Education'),
          Tab(icon: Icon(Icons.person), text: 'Volunteering'),
        ],
      ),
    );
  }

  Widget _buildSkillsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Wrap(
        spacing: 10,
        runSpacing: 20,
        children: [
          _buildSkillCard('Programming Languages', Icons.code, [
            'Dart',
            'Python',
            'JavaScript',
            'C++',
            'TypeScript',
            'Java',
          ], Colors.blue),
          _buildSkillCard('Mobile Development', Icons.phone_android, [
            'Flutter',
            'Android',
            'iOS',
            'Cross-platform',
            'macOS/Windows',
          ], Colors.green),
          _buildSkillCard('State Management', Icons.settings_applications, [
            'BLoC',
            'Provider',
            'GetX',
            'Riverpod',
            'Redux',
          ], Colors.orange),
          _buildSkillCard('Backend & Cloud', Icons.cloud, [
            'Firebase',
            'Node.js',
            'REST APIs',
            'GraphQL',
            'Docker',
          ], Colors.purple),
          _buildSkillCard('AI/ML Technologies', Icons.psychology, [
            'TensorFlow',
            'PyTorch',
            'LLMs',
            'VQVAEs',
            'MLOps',
            'OpenCV',
          ], Colors.pink),
          _buildSkillCard('DevOps & Tools', Icons.build, [
            'Git',
            'Docker',
            'Kubernetes',
            'CI/CD',
            'AWS',
            'Azure',
          ], Colors.teal),
          _buildSkillCard('Databases', Icons.storage, [
            'MySQL',
            'MongoDB',
            'PostgreSQL',
            'SQLite',
            'Firestore',
            'Hive',
          ], Colors.amber),
          _buildSkillCard('Web Technologies', Icons.web, [
            'React',
            'HTML/CSS',
            'TypeScript',
            'Responsive Design',
          ], Colors.indigo),
          _buildSkillCard('Corporate Technologies', Icons.web, [
            'Confluence',
            'Slack',
            'Jira',
            'Notion',
            'n8n',
            'Zendesk AI',
          ], Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildSkillCard(String title, IconData icon, List<String> skills, Color color) {
    final cardWidth = isMobile ? double.infinity : (MediaQuery.of(context).size.width - 280 - 100) / 3;

    return Container(
      width: isMobile ? double.infinity : cardWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.fontColor,
                    fontFamily: 'Funnel',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  skill,
                  style: TextStyle(color: AppColors.fontColor, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineItem(
            isFirst: true,
            isLast: false,
            title: 'Flutter Developer - Volunteering',
            organization: 'G12',
            period: 'Jan 2025 - May 2025 - Toronto',
            description: 'Leading Flutter development team and architecting scalable mobile solutions',
            points: [
              'Developed a student friendly cross-platform mobile application reaching 1K+ users',
              'Implemented clean architecture and BLoC pattern reducing bugs by 40%',
              'Developed a cross-platform Flutter mobile application to assist students, leveraging Firebase and RESTful APIs, and optimized backend performance by 30\% through Docker-based containerization and CI/CD integration.'
                  'Transformed Figma designs into pixel-perfect Flutter interfaces, improving accessibility and increasing user engagement by 20%.',
              'Managed project deployments and automated workflows using GitHub and GitHub Actions, while monitoring and debugging deployment issues to ensure smooth, reliable production releases.',
            ],
            color: Colors.blue,
          ),

          _buildTimelineItem(
            isFirst: false,
            isLast: false,
            title: 'Senior Flutter Developer',
            organization: 'Brane Services Private Limited',
            period: 'Aug 2022 - July 2024 - Bangalore',
            description: 'Cross Platfrom Application development and architecting scalable mobile solutions',
            points: [
              'Built and maintained cross-platform Flutter applications with pixel-perfect UI/UX, integrating responsive layouts for both mobile and macOS dashboards.',
              'Integrated payment gateways (Stripe, Razorpay) processing \$1K+ transactions',
              'Optimized app performance reducing load time by 40% and crash rate by 70%',
              'Implemented Firebase authentication, cloud functions, and real-time database',
              'Collaborated with design team to create pixel-perfect UI/UX',
              'Mentored 5 junior developers and conducted 50+ code reviews',
              'Integrated AI/ML features using TensorFlow Lite for image recognition',
              'Improved app performance by 60% through optimization techniques and state management like Bloc, Riverpod, GetX',
              'Supported offline functionality by caching data and managing it in SharedPreferences and Hive DB',
              'Implemented feature flags functionalities',
              'Delivered an AI-driven facial recognition app using Firebase ML, FaceNet, and Dio, managing secure API integration, live deployment, Git version control, automated testing, and technical documentation.',
              'Ensured secure and efficient API integration using Dio, HTTPS, and Firebase Cloud Functions, aligned with OWASP standards.',
              'Delivered 8+ scalable Flutter apps to 1K+ users.',
              'Published applications on Playstore and Apple Appstore',
            ],
            color: Colors.green,
          ),
          _buildTimelineItem(
            isFirst: false,
            isLast: true,
            title: 'Software Development Intern',
            organization: 'Brane Services Private Limited',
            period: 'May 2021 - July 2022',
            description: 'Mobile app development internship focusing on Flutter and Firebase',
            points: [
              'Developed UI components using Flutter and Material Design',
              'Worked on REST API integration with proper error handling',
              'Participated in agile development cycles and daily standups',
              'Learned DevOps basics with Docker and CI/CD pipelines',
              'Contributed to internal documentation and code standards via confluence and Jira',
              'Implemented new Flutter features and resolved bugs, ensuring efficient UX and secure API integration. Developed robust backend logic with OOP, multithreading, collections, and exception handling.',
              'Developed interactive, data-driven UI components aligned with business requirements and Figma designs.',
              'Built Django APIs and integrated with frontend via Dio and HTTPS, improving performance by 15%.',
              'Built a warehouse management app with Firebase Crashlytics, improving debugging efficiency by 40\% and strengthening app stability.',
            ],
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineItem(
            isFirst: true,
            isLast: false,
            title: 'Masters in Electrical and Computer Engineering',
            organization: 'University of Toronto',
            period: '2024 - 2026',
            description: 'Specialization in Artificial Intelligence and Computer Engineering',
            points: [
              'MPAC Student Wing - Student Ambassador, University of Toronto - Collaborated with the MEng Graduate Office to enhance the overall experience for engineering students ',
              'Led and conducted several professional development initiatives to support student growth beyond academics ',
              'Tech2U Classroom Ambassador - Supported 600+ instructors with classroom technology, ensuring seamless teaching experiences and Deployed Whisper AI-based auto-captioning system aligned with professor feedback for improved accuracy ',
              'Published research paper on "Mitigating Quantum Attacks from V2G with Blockchain and Vehicular Trust"',
              'Research under Prof. Kundur – Post Quantum Cryptography to secure Blockchains and scale them using Cloud Computing',
              'Courses - Introduction to Generative AI, Introduction to Machine Learning, Introduction to Deep Learning, Introduction to Cloud Computing, Parallel Programming, Masters of Engineeing Project, Blockchains and Cryptocurrencies',
            ],
            color: AppColors.navigationRailIconColor,
          ),
          _buildTimelineItem(
            isFirst: false,
            isLast: false,
            title: 'Bachelor of Engineering in Computer Science',
            organization: 'Visvesvaraya Technological University',
            period: '2018 - 2022',
            description: 'CGPA: 9.16/10 - First Class with Distinction',
            points: [
              'Specialized in Software Engineering, AI/ML, and Mobile App Development',
              'Final year project: AI-powered mobile application for healthcare',
              'Published research paper on "An innovative medical system to predict mortality rates in Hospitals using Machine Learning and Artificial Intelligence "',
              'Teaching Assistant for Data Structures and Algorithms course',
              'Led "Code Bar camps" and "Hacktoberfests" arrangements',
            ],
            color: Colors.purple,
          ),
          // _buildTimelineItem(
          //   isFirst: false,
          //   isLast: true,
          //   title: 'Pre-University Course (PUC)',
          //   organization: 'ABC College',
          //   period: '2016 - 2018',
          //   description: 'Percentage: 92% - Science Stream (Physics, Chemistry, Mathematics, Computer Science)',
          //   points: [
          //     'School topper in Computer Science with 98%',
          //     'Developed interest in programming through C++ and Python',
          //     'Participated in National Science Olympiad',
          //     'Led school tech club and organized coding workshops',
          //   ],
          //   color: Colors.teal,
          // ),
        ],
      ),
    );
  }

  Widget _buildVoluteeringTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineItem(
            isFirst: true,
            isLast: false,
            title: 'Classroom Ambassador - Tech2U',
            organization: 'University of Toronto',
            period: '2025 - Present',
            description: 'Worked as a technical support analyst for University',
            points: [
              'Tech2U Classroom Ambassador - Supported 600+ instructors with classroom technology, ensuring seamless teaching experiences',
              'Deployed Whisper AI-based auto-captioning system aligned with professor feedback for improved accuracy',
              'Managed classroom setups across 290+ instructional spaces, performing preventive maintenance and troubleshooting AV systems',
              'Collaborated with Tech2U Co-Pilots and colleagues to standardize technology support procedures',
            ],
            color: AppColors.navigationRailIconColor,
          ),
          _buildTimelineItem(
            isFirst: false,
            isLast: false,
            title: 'Exam Invigilator',
            organization: 'University of Toronto',
            period: '2025 - 2026',
            description: 'Exam invigilator for Jackman Law College',
            points: [
              'Supervised and proctored in-person examinations to ensure academic integrity and compliance with university policies',
              'Provided support to students requiring accommodations, ensuring an inclusive and equitable test-taking environment',
              'Monitored exam sessions attentively to prevent academic misconduct and promptly addressed any irregularities',
              'Coordinated with faculty and administrative staff to ensure smooth exam operations and adherence to procedures',
              'Demonstrated strong attention to detail, time management, and the ability to remain calm and organized during high-pressure exam periods',
            ],
            color: Colors.purple,
          ),
          _buildTimelineItem(
            isFirst: false,
            isLast: true,
            title: 'Event Coordinator',
            organization: 'University of Toronto',
            period: '2024 - 2026',
            description: 'Helped in conducting events in University',
            points: [
              'Liaised with faculty, student groups, vendors, and campus services to ensure smooth event execution and alignment with university standards',
              'Oversaw event timelines, registrations, and on-site operations, resolving issues in real time to ensure a positive attendee experience',
              'Managed event registration processes, including sign-in desks, attendee lists, and on-site check-in to ensure efficient guest flow',
              'Directed wayfinding and on-site navigation by coordinating signage, floor plans, and volunteer guidance to support attendee movement',
              'Coordinated post-event wrap-up by collecting equipment, signage, and materials, ensuring all resources were returned, stored, or documented appropriately',
            ],
            color: Colors.teal,
          ),
        ],
      ),
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
    required Color color,
  }) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(color: color.withOpacity(0.3), thickness: 2),
      indicatorStyle: IndicatorStyle(
        width: 50,
        height: 50,
        indicator: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: const Icon(Icons.star, color: Colors.white, size: 24),
        ),
      ),
      endChild: Container(
        margin: const EdgeInsets.only(left: 24, bottom: 32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.navigationRailBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.fontColor,
                fontFamily: 'Funnel',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Icon(Icons.business, color: color, size: 18),
                // const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    organization,
                    style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.fontColor.withOpacity(0.6), size: 16),
                const SizedBox(width: 8),
                Text(period, style: TextStyle(fontSize: 14, color: AppColors.fontColor.withOpacity(0.7))),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.fontColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(color: AppColors.fontColor.withOpacity(0.9), fontSize: 14, height: 1.5),
                      ),
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
}
