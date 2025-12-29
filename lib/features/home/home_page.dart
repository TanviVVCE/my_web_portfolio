import 'dart:js_interop';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/widgets/quick_action_menu/quick_action_menu.dart';
import 'package:web/web.dart' as web;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  AnimationController? _floatingController;
  AnimationController? _fadeController;
  Animation<double>? _floatingAnimation;
  Animation<double>? _fadeAnimation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Floating animation for decorative elements
    _floatingController = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _floatingController!, curve: Curves.easeInOut));

    // Fade in animation
    _fadeController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController!, curve: Curves.easeIn));

    _fadeController!.forward();
    _isInitialized = true;

    // Force rebuild after initialization
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _floatingController?.dispose();
    _fadeController?.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  bool get isMobile => MediaQuery.of(context).size.width < 900;
  bool get isTablet => MediaQuery.of(context).size.width >= 900 && MediaQuery.of(context).size.width < 1200;

  @override
  Widget build(BuildContext context) {
    // Wait for animations to initialize
    if (!_isInitialized || _floatingAnimation == null || _fadeAnimation == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF17153B),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF17153B),
      body: SafeArea(
        child: Stack(
          children: [
            // Animated background elements
            _buildBackgroundDecorations(),

            // Main content
            SingleChildScrollView(
              controller: _scrollController,
              child: FadeTransition(
                opacity: _fadeAnimation!,
                child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              ),
            ),

            // Floating social buttons
            if (!isMobile) _buildFloatingSocialButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // Gradient circles
        Positioned(
          top: -100,
          right: -100,
          child: AnimatedBuilder(
            animation: _floatingAnimation!,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_floatingAnimation!.value, _floatingAnimation!.value),
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.navigationRailIconColor.withOpacity(0.1), Colors.transparent],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: -150,
          left: -150,
          child: AnimatedBuilder(
            animation: _floatingAnimation!,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-_floatingAnimation!.value, -_floatingAnimation!.value),
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [AppColors.borderColor.withOpacity(0.08), Colors.transparent]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Hero section
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroSection(),
                const SizedBox(height: 40),
                _buildQuickStats(),
                const SizedBox(height: 40),
                _buildAboutSection(),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Right column - Skills & highlights
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // _buildSkillsHighlight(),
                const SizedBox(height: 30),
                _buildCurrentFocus(),
                const SizedBox(height: 30),
                _buildCTAButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          const SizedBox(height: 30),
          _buildQuickStats(),
          const SizedBox(height: 30),
          // _buildSkillsHighlight(),
          const SizedBox(height: 30),
          _buildAboutSection(),
          const SizedBox(height: 30),
          _buildCurrentFocus(),
          const SizedBox(height: 30),
          _buildCTAButtons(),
          const SizedBox(height: 30),
          _buildMobileSocialButtons(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Animated greeting
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.navigationRailIconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.navigationRailIconColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('👋', style: TextStyle(fontSize: isMobile ? 20 : 24)),
              const SizedBox(width: 8),
              Text(
                'Hello, I\'m',
                style: TextStyle(
                  color: AppColors.navigationRailIconColor,
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Name
        Text(
          'Tanvi Virappa Patil',
          style: TextStyle(
            fontSize: isMobile ? 36 : 56,
            fontWeight: FontWeight.bold,
            color: AppColors.fontColor,
            fontFamily: 'AlfaSlabOne',
            height: 1.2,
          ),
        ),

        const SizedBox(height: 20),

        // Animated roles
        SizedBox(
          height: isMobile ? 80 : 100,
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(milliseconds: 1000),
            animatedTexts: [
              _buildAnimatedRole('Flutter Developer 📱', Colors.blue),
              _buildAnimatedRole('Software Engineer 💻', Colors.green),
              _buildAnimatedRole('GenAI Enthusiast 🤖', Colors.purple),
              _buildAnimatedRole('Tech Blogger ✍️', Colors.orange),
              _buildAnimatedRole('MLOps Learner 🚢', Colors.teal),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Tagline
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.navigationRailIconColor.withOpacity(0.1), AppColors.borderColor.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
          ),
          child: Text(
            '🚀 Building scalable, high-performance cross-platform applications using enterprise-grade engineering practices, with real-world AI/ML and Generative AI integrations that drive measurable business impact.',
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: AppColors.fontColor.withOpacity(0.9),
              fontWeight: FontWeight.w500,
              height: 1.5,
              fontFamily: 'Funnel',
            ),
          ),
        ),
      ],
    );
  }

  TypewriterAnimatedText _buildAnimatedRole(String text, Color color) {
    return TypewriterAnimatedText(
      text,
      speed: const Duration(milliseconds: 100),
      textStyle: TextStyle(
        fontSize: isMobile ? 24 : 40,
        fontWeight: FontWeight.bold,
        color: color,
        fontFamily: 'AlfaSlabOne',
      ),
    );
  }

  Widget _buildQuickStats() {
    final stats = [
      {'icon': '🎯', 'label': 'Projects', 'value': '20+'},
      {'icon': '💼', 'label': 'Experience', 'value': '3+ Years'},
      {'icon': '🏆', 'label': 'Achievements', 'value': '10+'},
      {'icon': '⭐', 'label': 'Skills', 'value': '20+'},
      {'icon': '📱', 'label': 'Apps', 'value': '5+'},
    ];

    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: stats.map((stat) {
        return Container(
          width: isMobile ? (MediaQuery.of(context).size.width - 56) / 2 : 160,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.navigationRailBgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
            boxShadow: WidgetCommons().boxShadowswithColors(),
          ),
          child: Column(
            children: [
              Text(stat['icon']!, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                stat['value']!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.navigationRailIconColor),
              ),
              const SizedBox(height: 4),
              Text(stat['label']!, style: TextStyle(fontSize: 12, color: AppColors.fontColor.withOpacity(0.7))),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillsHighlight() {
    // final skills = [
    //   {'name': 'Flutter', 'level': 0.95, 'color': Colors.blue},
    //   {'name': 'AI/ML', 'level': 0.85, 'color': Colors.purple},
    //   {'name': 'GenAI', 'level': 0.80, 'color': Colors.pink},
    //   {'name': 'DevOps', 'level': 0.75, 'color': Colors.orange},
    // ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: WidgetCommons().boxShadowswithColors(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.navigationRailIconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.star, color: AppColors.navigationRailIconColor, size: 20),
              ),
              const SizedBox(width: 12),
              // Text(
              //   'Core Expertise',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.fontColor,
              //     fontFamily: 'AlfaSlabOne',
              //   ),
              // ),
            ],
          ),
          // const SizedBox(height: 20),
          // ...skills.map((skill) {
          //   return Padding(
          //     padding: const EdgeInsets.only(bottom: 16),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               skill['name'] as String,
          //               style: TextStyle(color: AppColors.fontColor, fontSize: 14, fontWeight: FontWeight.w600),
          //             ),
          //             Text(
          //               '${((skill['level'] as double) * 100).toInt()}%',
          //               style: TextStyle(color: skill['color'] as Color, fontSize: 12, fontWeight: FontWeight.bold),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 8),
          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(10),
          //           child: TweenAnimationBuilder<double>(
          //             duration: const Duration(milliseconds: 1500),
          //             curve: Curves.easeOut,
          //             tween: Tween<double>(begin: 0, end: skill['level'] as double),
          //             builder: (context, value, child) {
          //               return LinearProgressIndicator(
          //                 value: value,
          //                 backgroundColor: AppColors.borderColor.withOpacity(0.2),
          //                 valueColor: AlwaysStoppedAnimation<Color>(skill['color'] as Color),
          //                 minHeight: 8,
          //               );
          //             },
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // }).toList(),
        ],
      ),
    );
  }

  Widget _buildCurrentFocus() {
    final focuses = [
      {'icon': '🚀', 'title': 'GenAI Integration', 'desc': 'Building AI-powered features'},
      {'icon': '🛳️', 'title': 'MLOps', 'desc': 'Learning deployment pipelines'},
      {'icon': '🔐', 'title': 'Post-Quantum Cryptography and Blockchains', 'desc': 'Research initiative'},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navigationRailIconColor.withOpacity(0.1), AppColors.borderColor.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.navigationRailIconColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎯 Current Focus',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.fontColor,
              fontFamily: 'AlfaSlabOne',
            ),
          ),
          const SizedBox(height: 16),
          ...focuses.map((focus) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(focus['icon']!, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          focus['title']!,
                          style: TextStyle(color: AppColors.fontColor, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          focus['desc']!,
                          style: TextStyle(color: AppColors.fontColor.withOpacity(0.6), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.navigationRailBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: WidgetCommons().boxShadowswithColors(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.navigationRailIconColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'About Me',
                style: TextStyle(
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontColor,
                  fontFamily: 'AlfaSlabOne',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAboutParagraph(),
        ],
      ),
    );
  }

  Widget _buildAboutParagraph() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: TextStyle(color: AppColors.fontColor, fontSize: isMobile ? 14 : 16, height: 1.8),
        children: [
          const TextSpan(text: 'I’m a results-driven '),
          TextSpan(
            text: 'software developer',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navigationRailIconColor),
          ),
          const TextSpan(text: ' who combines startup agility with enterprise-grade engineering.\n\n'),
          const TextSpan(text: 'I specialize in building '),
          TextSpan(
            text:
                'scalable, high-performance cross-platform applications with Flutter and deploying AI/ML/GenAI Solutions',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navigationRailIconColor),
          ),
          const TextSpan(text: ', delivering consistent experiences across Android, iOS, Web, Windows, and macOS.\n\n'),
          const TextSpan(
            text: '💡 My expertise includes:\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: '• Scalable and clean architecture with BLoC, Provider, GetX, Riverpod\n'),
          const TextSpan(text: '• REST API integrations & third-party SDKs\n'),
          const TextSpan(text: '• Performance optimization & debugging\n'),
          const TextSpan(text: '• Docker & Kubernetes deployments\n'),
          const TextSpan(text: '• AI/ML integration with TensorFlow & PyTorch\n\n'),
          const TextSpan(text: 'Beyond development, I\'m deeply engaged in '),
          TextSpan(
            text: 'Generative AI',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navigationRailIconColor),
          ),
          const TextSpan(
            text:
                ', fine-tuning LLMs, and building AI-driven features with real-world deployment focus including Image Generation.\n\n',
          ),
          TextSpan(
            text:
                'Curious by nature, I\’m continuously learning and keep myself tech updated to build future-ready solutions. \n',
          ),
          const TextSpan(text: '🚀 '),
          TextSpan(
            text: 'Let\'s collaborate and build something amazing together ! ',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navigationRailIconColor),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/projects'),
          icon: const Icon(Icons.rocket_launch),
          label: const Text('View My Projects'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.navigationRailIconColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            minimumSize: Size(isMobile ? double.infinity : 250, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 5,
          ),
        ),
        // const SizedBox(height: 16),
        // OutlinedButton.icon(
        //   onPressed: () => downloadResume,
        //   icon: const Icon(Icons.download),
        //   label: const Text('Download Resume'),
        //   style: OutlinedButton.styleFrom(
        //     foregroundColor: AppColors.navigationRailIconColor,
        //     side: BorderSide(color: AppColors.navigationRailIconColor, width: 2),
        //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        //     minimumSize: Size(isMobile ? double.infinity : 250, 56),
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        //   ),
        // ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () async {
            String url = 'https://tanvis-blogs.hashnode.dev';
            if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            }
          },
          icon: const Icon(Icons.message),
          label: const Text('Blogs'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.navigationRailIconColor,
            side: BorderSide(color: AppColors.navigationRailIconColor, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            minimumSize: Size(isMobile ? double.infinity : 250, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/resume'),
          icon: const Icon(Icons.rocket_launch),
          label: const Text('View My Journey'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.navigationRailIconColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            minimumSize: Size(isMobile ? double.infinity : 250, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingSocialButtons() {
    return Positioned(
      right: 40,
      bottom: 40,
      child: Column(
        children: [
          _buildSocialButton(
            svgPath: 'assets/logos/linkedin.svg',
            url: 'https://www.linkedin.com/in/tanvi-virappa-patil-044796197/',
          ),
          const SizedBox(height: 16),
          _buildSocialButton(svgPath: 'assets/logos/github.svg', url: 'https://github.com/TanviVVCE'),
          const SizedBox(height: 16),
          _buildSocialButton(svgPath: 'assets/logos/google.svg', url: 'mailto:tanvipatil843@gmail.com'),
        ],
      ),
    );
  }

  Widget _buildMobileSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          svgPath: 'assets/logos/linkedin.svg',
          url: 'https://www.linkedin.com/in/tanvi-virappa-patil-044796197/',
        ),
        const SizedBox(width: 16),
        _buildSocialButton(svgPath: 'assets/logos/github.svg', url: 'https://github.com/TanviVVCE'),
        const SizedBox(width: 16),
        _buildSocialButton(svgPath: 'assets/logos/google.svg', url: 'mailto:tanvipatil843@gmail.com'),
      ],
    );
  }

  Widget _buildSocialButton({required String svgPath, required String url}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _floatingAnimation!,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatingAnimation!.value / 2),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.navigationRailIconColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navigationRailIconColor.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () async {
                  if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  }
                },
                icon: SvgPicture.asset(
                  svgPath,
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
