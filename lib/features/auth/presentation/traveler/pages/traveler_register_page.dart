import 'package:flutter/material.dart';

class TravelerRegisterPage extends StatefulWidget {
  const TravelerRegisterPage({super.key});

  @override
  State<TravelerRegisterPage> createState() => _TravelerRegisterPageState();
}

class _TravelerRegisterPageState extends State<TravelerRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Traveler Register Page'),
      ),
    );
  }
}