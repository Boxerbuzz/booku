import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class EvSectionHeader extends StatelessWidget {
  const EvSectionHeader(
      {required this.title,
      this.more = false,
      this.click,
      this.pad = false,
      Key? key})
      : super(key: key);
  final String title;
  final bool more;
  final Function()? click;
  final bool pad;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: TextStyles.h6.semiBold),
            Expanded(child: Container()),
            EvIcBtn(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'More',
                    style: TextStyles.button.textColor(theme.primary),
                  ),
                  HSpace.sm,
                  EvSvgIc(R.I.arrowRight.svgT, size: 15, color: theme.primary),
                ],
              ),
              shrinkWrap: true,
              onPressed: () {},
            ),
          ],
        ),
        VSpace.md,
      ],
    ).padding(horizontal: Insets.l, vertical: pad == true ? Insets.l : 0);
  }
}
