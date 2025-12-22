import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF17153B),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetCommons().navigationBarClass(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [columnAnimated(), cardBuilder(context)],
            ),
            // WidgetCommons().contactInfoBuilder(),
            // WidgetCommons().skillsCard(),
          ],
        ),
      ),
    );
  }

  Widget columnAnimated() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 19),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          animatedTextContent('Hello World !! I am a Developer 💻'),
          animatedTextContent('Hello World !! I am a Blogger ✉️'),
          animatedTextContent('Hello World !! I am a GenAI Enthusiast 🤖'),
          animatedTextContent('Hello World !! I am trying to learn MLOps 🚢'),
        ],
      ),
    );
  }

  Widget cardBuilder(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 70),
          child: Container(
            constraints: BoxConstraints(maxWidth: 1300, minWidth: 300, maxHeight: 800),
            decoration: BoxDecoration(
              border: BoxBorder.all(color: AppColors.borderColor),
              boxShadow: WidgetCommons().boxShadowswithColors(),
              color: AppColors.navigationRailBgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                          child: Text(
                            '👋 About Me',
                            style: TextStyle(fontSize: 20, color: AppColors.fontColor, fontFamily: 'AlfaSlabOne'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.borderColor,
                            ),
                            width: 100,
                            height: 3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: WidgetCommons().responsiveFontSize(context),
                              ),
                              children: [
                                const TextSpan(
                                  text:
                                      'I’m a passionate and results-driven software developer who combines startup speed and innovation with ',
                                ),
                                TextSpan(
                                  text: 'enterprise-level engineering discipline',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.navigationRailIconColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                    // height: 1.6,
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      '.\nI specialize in building scalable, high-performance cross-platform applications using ',
                                ),
                                TextSpan(
                                  text: 'Flutter',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.navigationRailIconColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      ', delivering consistent and polished experiences across Android, iOS, Web \nWindows, and macOS from a single, maintainable codebase. My expertise spans building \n \n ',
                                ),
                                TextSpan(
                                  text: '🚀 Reusable widget systems \n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.navigationRailIconColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                  ),
                                ),
                                TextSpan(
                                  text: '🚀 Robust state management architectures using ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: 'Providers, Bloc, GetX, RiverPod ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.navigationRailIconColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' that support rapid iteration while remaining clean, testable, and production-ready. \n \n ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: 'Track record of delivering end-to-end solutions, including : \n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.navigationRailIconColor,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                  ),
                                ),
                                TextSpan(
                                  text: '🚀 REST API integrations \n',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: '🚀 Third-party SDKs \n',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: '🚀 Performance optimization \n',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: '🚀 Advanced debugging to ensure reliability at scale. \n',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: '🚀 Docker and Kubernetes deployments \n \n',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: 'Beyond application development, I am deeply engaged in ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: 'Artificial Intelligence and Generative AI ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.navigationRailIconColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ', with hands-on experience in:\n 🌟 Building reasoning-based models \n 🌟 Fine-tuning Large Language Models (LLMs) \n 🌟 Developing and integrating image generation systems.\n 🌟 Designing AI-driven features with a strong emphasis on scalability, efficiency, and real-world deployment. \n \n ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: 'Post-Quantum Cryptography ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.navigationRailIconColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' as a side research initiative, focusing on building systems resilient to future quantum-era security threats. \n \n ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text:
                                      'I thrive in agile, cross-functional teams, value clear communication and ownership, and enjoy collaborating with designers, product managers, and engineers to transform ideas into impactful products. \nI continuously stay current with emerging technologies, tools, and best practices to deliver solutions that are not only innovative but also future-ready. \n \n ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text:
                                      '🚀 If you’re looking for a developer who can move fast, think strategically, and deliver robust solutions with powerful AI and GenAI integrations, ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                                TextSpan(
                                  text: 'I’d love to collaborate and help bring your vision to life.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.navigationRailIconColor,
                                    fontSize: WidgetCommons().responsiveFontSize(context),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' \n \n 😁 I’m always open to meaningful discussions, so don’t hesitate to reach out! Being part of the developer community, I’m happy to connect, share insights, and help solve problems together. \n \n I am still learning about DevOps and MLOps and enthusiastic to learn more. 🛳 ',
                                  style: TextStyle(fontSize: WidgetCommons().responsiveFontSize(context)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedText animatedTextContent(String contentData) {
    return TypewriterAnimatedText(
      contentData,
      speed: const Duration(milliseconds: 150),
      textStyle: TextStyle(
        fontSize: MediaQuery.of(context).size.width < 600 ? 16 : 35,
        fontFamily: 'AlfaSlabOne',
        color: AppColors.fontColor,
      ),
    );
  }
}
