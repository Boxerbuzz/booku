import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class EvCategoryView extends StatelessWidget {
  const EvCategoryView(this.types, {Key? key}) : super(key: key);
  final List<String> types;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Wrap(
      runSpacing: 5,
      children: [
        ...parseList().map((e) => EvContainer(
              child:
                  Text(e, style: TextStyles.body3.textColor(theme.background))
                      .padding(all: 5),
              borderRadius: Corners.s5Border,
            ).padding(left: 10)),
        types.length > 4 ? _More(types.length) : const SizedBox.shrink(),
      ],
    );
  }

  List<String> parseList() => types.length > 3 ? types.take(3).toList() : types;
}

class _More extends StatelessWidget {
  const _More(this.count, {Key? key}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return EvContainer(
      child: Text('+ ${count - 3} More',
              style: TextStyles.body3.textColor(theme.surface))
          .padding(all: 5),
      borderRadius: Corners.s5Border,
    ).padding(left: 10);
  }
}
