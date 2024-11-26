import 'package:flutter/material.dart';

class TravelerProfilePage extends StatefulWidget {
  const TravelerProfilePage({super.key});

  @override
  State<TravelerProfilePage> createState() => _TravelerProfilePageState();
}

class _TravelerProfilePageState extends State<TravelerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( 
        child: Text('Traveler Profile Page'),
      ),
    );
  }
}