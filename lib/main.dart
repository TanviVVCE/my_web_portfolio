import 'dart:ui_web';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/features/resume/about_me.dart';
import 'package:my_portfolio/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:my_portfolio/features/contact/contact_page.dart';
import 'package:my_portfolio/features/home/home_page.dart';
// import 'package:my_portfolio/features/projects/presentation/pages/projects_page.dart';

void main() {
  const HashUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tanvi\'s Portfolio',
      theme: FlexThemeData.dark(),
      home: const HomePage(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        // '/projects': (context) => ProjectsPage(),
        '/resume': (context) => Resume(),
        '/contact': (context) => ContactPage(),
        '/blogs': (context) => BlogDetailPage(),
      },
    );
  }
}
