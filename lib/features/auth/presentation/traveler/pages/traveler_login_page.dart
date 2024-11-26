import 'package:flutter/material.dart';

class TravelerLoginPage extends StatefulWidget {
  const TravelerLoginPage({super.key});

  @override
  State<TravelerLoginPage> createState() => _TravelerLoginPageState();
}

class _TravelerLoginPageState extends State<TravelerLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Traveler Login Page'),
      ),
    );
  }
}