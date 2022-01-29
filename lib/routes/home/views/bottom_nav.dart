import 'package:booku/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class EvBottomNav extends StatelessWidget {
  const EvBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Consumer<AppProvider>(
      builder: (context, store, child) {
        return SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.indicator,
          snakeViewColor: theme.primary,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: store.currentPage,
          onTap: (index) => store.currentPage = index,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: store.currentPage == 0
                  ? EvSvgIc(R.I.homeAlt.svgB, color: theme.primary)
                  : EvSvgIc(R.I.homeAlt.svgT, color: theme.greyStrong),
            ),
            BottomNavigationBarItem(
              label: 'Library',
              icon: store.currentPage == 1
                  ? EvSvgIc(R.I.book.svgB, color: theme.primary)
                  : EvSvgIc(R.I.book.svgT, color: theme.greyStrong),
            ),
            BottomNavigationBarItem(
              label: 'Club',
              icon: store.currentPage == 2
                  ? EvSvgIc(R.I.people.svgB, color: theme.primary)
                  : EvSvgIc(R.I.people.svgT, color: theme.greyStrong),
            ),
            BottomNavigationBarItem(
              label: 'Achievements',
              icon: store.currentPage == 3
                  ? EvSvgIc(R.I.award.svgB, color: theme.primary)
                  : EvSvgIc(R.I.award.svgT, color: theme.greyStrong),
            ),
            BottomNavigationBarItem(
              label: 'Me',
              icon: store.currentPage == 4
                  ? EvSvgIc(R.I.profile.svgB, color: theme.primary)
                  : EvSvgIc(R.I.profile.svgT, color: theme.greyStrong),
            ),
          ],
        );
      },
    );
  }
}
