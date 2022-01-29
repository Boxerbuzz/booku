import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _AppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                VSpace.lg,
                const _Search().padding(horizontal: Insets.l),
                VSpace.lg,
                EvSectionHeader(title: R.S.recommended, more: false),
                EvRecommended(
                  onChange: (value) {},
                  items: Mocks.rec.map((c) => ClubModel.fromJson(c)).toList(),
                ),
                VSpace.lg,
                EvSectionHeader(title: R.S.popular, more: false),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Mocks.clubs.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ClubItem(
                        data: Mocks.clubs.reversed
                            .map((e) => ClubModel.fromJson(e))
                            .toList()[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*------------------------ Appbar -------------------------*/

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SafeArea(
      child: EvContainer(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.m),
          child: Row(
            children: [
              EvContainer(
                height: 24,
                width: 24,
                borderRadius: Corners.s5Border,
              ),
              Expanded(child: Container()),
              EvIcBtn(
                EvSvgIc(R.I.notificationBing.svgB),
                onPressed: () {},
              ),
              EvIcBtn(
                EvSvgIc(R.I.calendar.svgB),
                onPressed: () {},
              ),
            ],
          ),
        ),
        color: theme.surface,
        shadows: Shadows.m(theme.grey, .3),
      ),
    );
  }
}

/*----------------------- Search Field --------------------*/

class _Search extends StatelessWidget {
  const _Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Row(
      children: [
        const Expanded(child: EvSearchField(hint: 'Search for clubs...')),
        HSpace.md,
        EvIcBtn(
          EvSvgIc(R.I.search.svgT, color: theme.surface),
          onPressed: () {},
          padding: const EdgeInsets.all(12),
          bgColor: theme.primary,
          radius: Corners.s10,
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
    );
  }
}
