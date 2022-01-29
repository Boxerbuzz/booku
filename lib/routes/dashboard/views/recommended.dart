import 'dart:math';
import 'package:flutter/material.dart';
import 'package:booku/exports.dart';

class EvRecommended extends StatefulWidget {
  const EvRecommended({Key? key, this.items = const [], this.onChange})
      : super(key: key);
  final List<ClubModel> items;
  final Function? onChange;

  @override
  _EvRecommendedState createState() => _EvRecommendedState();
}

class _EvRecommendedState extends State<EvRecommended>
    with SingleTickerProviderStateMixin {
  final double _maxRotation = 30;

  late PageController _pageController;
  late int selectedIndex;

  late double _cardWidth;
  late double _cardHeight;
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  AnimationController? _tweenController;
  Tween<double>? _tween;
  Animation<double>? _tweenAnim;

  @override
  Widget build(BuildContext context) {
    _cardHeight = (context.heightPct(.4)).clamp(130.0, 300.0);
    _cardWidth = context.widthPct(.7);
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: _cardWidth / context.widthPx,
      keepPage: false,
    );

    Widget listContent = SizedBox(
      height: _cardHeight,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => _buildItemRenderer(i),
        onPageChanged: (value) => setState(() => selectedIndex = value),
        reverse: true,
      ),
    );

    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: listContent,
      ),
    );
  }

  Widget _buildItemRenderer(int itemIndex) {
    return _Rotation3d(
      rotationY: _normalizedOffset * _maxRotation,
      child: _Item(
        _normalizedOffset,
        item: widget.items[itemIndex % widget.items.length],
        cardWidth: _cardWidth,
        color: itemIndex == 0 ? Colors.indigoAccent : Colors.pinkAccent,
      ),
    );
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
      widget.onChange!(widget.items
          .elementAt(_pageController.page!.round() % widget.items.length));
    }
    //Scroll Start
    else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController?.stop();
      }
    }
    return true;
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _setOffset(double value) => setState(() => _normalizedOffset = value);

  void _startOffsetTweenToZero() {
    int tweenTime = 1000;
    if (_tweenController == null) {
      _tweenController =
          AnimationController(vsync: this, duration: tweenTime.milliseconds);
      _tween = Tween<double>(begin: -1, end: 0);
      _tweenAnim = _tween?.animate(
          CurvedAnimation(parent: _tweenController!, curve: Curves.elasticOut));
      _tweenAnim?.addListener(() => _setOffset(_tweenAnim!.value));
    }
    _tween?.begin = _normalizedOffset;
    _tweenController?.reset();
    _tween?.end = 0;
    _tweenController?.forward();
  }
}

class _Rotation3d extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 160;

  final Widget child;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  const _Rotation3d(
      {Key? key,
      required this.child,
      this.rotationX = 0,
      this.rotationY = 0,
      this.rotationZ = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(rotationX * degrees2Radians)
        ..rotateY(rotationY * degrees2Radians)
        ..rotateZ(rotationZ * degrees2Radians),
      child: child,
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
    this.offset, {
    Key? key,
    this.cardWidth = 250,
    required this.item,
    this.color,
  }) : super(key: key);
  final double offset;
  final double? cardWidth;
  final ClubModel item;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return SizedBox(
      width: cardWidth,
      child: EvContainer(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: ColorHelper.shiftHsl(theme.surface, .1),
        borderRadius: Corners.s10Border,
        shadows: Shadows.m(theme.grey, .2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.8,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorHelper.shiftHsl(color!, .1),
                  borderRadius: BorderRadius.only(
                    topRight: Corners.s10Radius,
                    topLeft: Corners.s10Radius,
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/${item.img!}.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name!,
                    style: TextStyles.h6.semiBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                EvContainer(
                  borderRadius: Corners.s10Border,
                  child: EvSvgIc(
                          item.locked == true ? R.I.lock.svgT : R.I.unlock.svgT,
                          size: 15,
                          color: theme.primary)
                      .padding(all: 4),
                  color: theme.primary.withOpacity(.1),
                ),
              ],
            ).padding(horizontal: 10),
            const Spacer(flex: 1),
            Row(
              children: [
                const Expanded(
                  child: FacePile(
                    facePercentOverlap: .3,
                    faceSize: 30,
                    urls: [
                      'https://randomuser.me/api/portraits/women/1.jpg',
                      'https://randomuser.me/api/portraits/women/4.jpg',
                      'https://randomuser.me/api/portraits/women/9.jpg',
                      'https://randomuser.me/api/portraits/women/3.jpg',
                      'https://randomuser.me/api/portraits/women/2.jpg',
                    ],
                  ),
                ),
                Text(
                  '${item.members} Members',
                  style: TextStyles.body2.textColor(theme.primary),
                ),
              ],
            ).padding(horizontal: 10),
            const Spacer(flex: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EvSvgIc(R.I.location.svgB, size: 15),
                HSpace.sm,
                Expanded(
                  child: Text(
                    item.location!,
                    style: TextStyles.body1,
                  ),
                )
              ],
            ).padding(horizontal: 10),
            const Spacer(flex: 1),
            EvCategoryView(item.categories!),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
