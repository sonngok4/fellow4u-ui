// core/presentation/widgets/layouts/main_scaffold.dart
import 'package:flutter/material.dart';
import '../shared/custom_header.dart';
import '../shared/custom_navigation_bar.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? headerBackground;
  final bool showSearch;
  final int currentIndex;
  final ValueChanged<int>? onNavigationChanged;

  const MainScaffold({
    super.key,
    required this.body,
    this.title,
    this.headerBackground,
    this.showSearch = false,
    this.currentIndex = 0,
    this.onNavigationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomHeader(
            title: title,
            background: headerBackground,
            showSearch: showSearch,
          ),
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentIndex,
        onTap: onNavigationChanged,
      ),
    );
  }
}
