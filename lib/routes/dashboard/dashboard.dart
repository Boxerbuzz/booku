import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: Insets.l),
      child: Column(
        children: [
          VSpace.xl,
          Row(
            children: [
              Expanded(
                child: EvSearchField(
                  hint: 'Search for clubs...',
                  suffix: EvIcBtn(
                    EvSvgIc(R.I.search.svgT),
                    shrinkWrap: true,
                    onPressed: () {},
                  ),
                ),
              ),
              HSpace.md,
              EvIcBtn(
                EvSvgIc(R.I.candle.svgT, color: theme.surface),
                onPressed: () {},
                padding: const EdgeInsets.all(12),
                bgColor: theme.primary,
                radius: Corners.s10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
