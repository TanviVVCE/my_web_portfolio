import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/common_widgets.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(children: [WidgetCommons().navigationBarClass(context)]));
  }
}
