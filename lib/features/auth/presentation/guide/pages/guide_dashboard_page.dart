import 'package:flutter/material.dart';

class GuideDashboardPage extends StatefulWidget {
  const GuideDashboardPage({super.key});

  @override
  State<GuideDashboardPage> createState() => _GuideDashboardPageState();
}

class _GuideDashboardPageState extends State<GuideDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Guide Dashboard Page'),
      ),
    );
  }
}