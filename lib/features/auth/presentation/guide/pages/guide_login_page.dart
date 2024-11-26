import 'package:flutter/material.dart';

class GuideLoginPage extends StatefulWidget {
  const GuideLoginPage({super.key});

  @override
  State<GuideLoginPage> createState() => _GuideLoginPageState();
}

class _GuideLoginPageState extends State<GuideLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Guide Login Page'),
      ),
    );
  }
}