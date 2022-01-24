import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class EvNavTabView extends StatefulWidget {
  final List<Widget> children;
  final List<String> titles;
  final List<IconData>? icons;

  const EvNavTabView({
    Key? key,
    required this.children,
    required this.titles,
    this.icons,
  }) : super(key: key);

  @override
  _EvNavTabViewState createState() => _EvNavTabViewState();
}

class _EvNavTabViewState extends State<EvNavTabView> {
  int _selectedTabIndex = 0;

  void _onPressed(int index) => setState(() => _selectedTabIndex = index);

  @override
  Widget build(BuildContext context) {
    return _TabbedListView(
      index: _selectedTabIndex,
      onTabPressed: _onPressed,
      children: widget.children,
      titles: widget.titles,
      icons: widget.icons ?? [],
    );
  }
}

class _TabbedListView extends StatelessWidget {
  final List<Widget> children;
  final List<String> titles;
  final List<IconData>? icons;
  final void Function(int)? onTabPressed;
  final int index;

  const _TabbedListView({
    Key? key,
    required this.children,
    required this.titles,
    this.icons,
    this.index = 0,
    this.onTabPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();

    ShapeDecoration buildTabDec(bool isBg) {
      return ShapeDecoration(
        shape: _TabBorder(selectedTab: isBg == true ? 0 : index),
        color: isBg
            ? theme.surface
            : ColorHelper.blend(Colors.grey, theme.background, .35),
        shadows: isBg ? Shadows.m(Colors.black, .01) : null,
      );
    }

    bool firstSelected = index == 0;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: buildTabDec(true),
              foregroundDecoration: buildTabDec(false),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: _LabelButton(
                        title: titles[0],
                        // icon: icons[0],
                        isSelected: firstSelected,
                        onPressed: () => onTabPressed?.call(0)),
                  ),
                  Expanded(
                    child: _LabelButton(
                      title: titles[1],
                      //   icon: icons[1],
                      isSelected: !firstSelected,
                      onPressed: () => onTabPressed?.call(1),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(Insets.l),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Corners.s10Radius,
              bottomRight: Corners.s10Radius,
            ),
            color: theme.background,
            boxShadow: Shadows.m(theme.grey, .4),
          ),
          child: Column(
            children: [
              firstSelected ? children.first : children.last,
            ],
          ),
        ),
      ],
    );
  }
}

class _LabelButton extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String title;
  final IconData? icon;

  const _LabelButton({
    Key? key,
    this.isSelected = false,
    this.onPressed,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    Color color = isSelected ? theme.primary : theme.onSurface;
    TextStyle titleStyle = TextStyles.t2.textColor(color);
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: BaseBtn(
        contentPadding: EdgeInsets.zero,
        bgColor: Colors.transparent,
        downColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onPressed: isSelected ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon, color: color, size: 26),
            HSpace(Insets.sm),
            Flexible(child: Text(title, style: titleStyle)),
          ],
        ),
      ),
    );
  }
}

class _TabBorder extends ShapeBorder {
  final int selectedTab;
  final double barHeight;

  const _TabBorder({required this.selectedTab, this.barHeight = 50});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    var radius = Corners.s10Radius;

    void drawTab(Path p, bool rightSide) {
      double xPos = rightSide ? rect.width * .5 : 0;
      Rect tabRect =
          Rect.fromLTWH(rect.left + xPos, rect.top, rect.width * .5, barHeight);
      p.addRRect(RRect.fromRectAndCorners(tabRect,
          topLeft: radius,
          bottomLeft: Radius.zero,
          topRight: radius,
          bottomRight: Radius.zero));
    }

    //Bg mode draws 2 tabs and a body section. Otherwise, just the un-selected tab is drawn.
    bool bgMode = selectedTab == 0;
    Path path = Path();
    //Draw Left side?
    if (bgMode || selectedTab == 1) {
      drawTab(path, false);
    }
    //Draw Right Side?
    if (bgMode || selectedTab == 0) {
      drawTab(path, true);
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }
}
