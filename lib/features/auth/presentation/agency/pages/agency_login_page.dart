import 'package:flutter/material.dart';

class AgencyLoginPage extends StatefulWidget {
  const AgencyLoginPage({super.key});

  @override
  State<AgencyLoginPage> createState() => _AgencyLoginPageState();
}

class _AgencyLoginPageState extends State<AgencyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Agency Login Page'),
      ),
    );
  }
}