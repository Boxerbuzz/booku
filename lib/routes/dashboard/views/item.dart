import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class ClubItem extends StatelessWidget {
  const ClubItem({required this.data, this.margin, Key? key, this.mini = true})
      : super(key: key);
  final ClubModel data;
  final EdgeInsetsGeometry? margin;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      width: double.infinity,
      borderRadius: Corners.s10Border,
      color: theme.surface,
      shadows: Shadows.m(theme.grey, .1),
      margin: EdgeInsets.symmetric(horizontal: Insets.l, vertical: 10),
      child: mini == true ? Row(
        children: [
          Container(
            width: context.widthPct(.22),
            height: context.heightPct(.13),
            decoration: BoxDecoration(
              borderRadius: Corners.s8Border,
              image: DecorationImage(
                image: AssetImage('assets/images/${data.img!}.jpg'),
                fit: BoxFit.cover,
              ),
              boxShadow: Shadows.m(theme.grey, .1),
            ),
          ),
          HSpace.md,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name!,
                  style: TextStyles.h6.bold.textHeight(1.4),
                ),
                VSpace.md,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EvSvgIc(R.I.location.svgB, size: 15),
                    HSpace.sm,
                    Expanded(
                      child: Text(
                        data.location!,
                        style: TextStyles.body1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                VSpace.md,
                EvCategoryView(data.categories!),
              ],
            ),
          ),
        ],
      ).padding(all: Insets.m) : _MaxSize(),
    );
  }
}

class _MaxSize extends StatelessWidget {
  const _MaxSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
