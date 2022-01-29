import 'package:booku/exports.dart';

import 'views/bottom_nav.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const EvBottomNav(),
      body: Consumer<AppProvider>(builder: (context, store, child) {
        return IndexedStack(children: _screens(), index: store.currentPage);
      }),
    );
  }
}

List<Widget> _screens() {
  return [
    const DashboardScreen(),
    const LibraryScreen(),
    const ClubScreen(),
    const AchievementScreen(),
    const ProfileScreen()
  ];
}
