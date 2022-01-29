import 'package:flutter/material.dart';

class FacePile extends StatefulWidget {
  const FacePile({
    Key? key,
    required this.urls,
    this.faceSize = 48,
    this.facePercentOverlap = 0.5,
  }) : super(key: key);

  final List<String> urls;
  final double faceSize;
  final double facePercentOverlap;

  @override
  _FacePileState createState() => _FacePileState();
}

class _FacePileState extends State<FacePile>
    with SingleTickerProviderStateMixin {
  final _visibleAvatars = <String>[];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _syncAvatarsWithPile();
    });
  }

  @override
  void didUpdateWidget(FacePile oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _syncAvatarsWithPile();
    });
  }

  void _syncAvatarsWithPile() {
    setState(() {
      final newAvatars = widget.urls.where(
        (avatar) => _visibleAvatars
            .where((visibleAvatar) => visibleAvatar == avatar)
            .isEmpty,
      );

      for (final newAvatar in newAvatars) {
        _visibleAvatars.add(newAvatar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final facesCount = _visibleAvatars.length;

        double facePercentVisible = 1.0 - widget.facePercentOverlap;

        final maxIntrinsicWidth = facesCount > 1
            ? (1 + (facePercentVisible * (facesCount - 1))) * widget.faceSize
            : widget.faceSize;

        late double leftOffset;
        if (maxIntrinsicWidth > constraints.maxWidth) {
          leftOffset = 0;
          //(constraints.maxWidth - maxIntrinsicWidth) / 2
          facePercentVisible =
              ((constraints.maxWidth / widget.faceSize) - 1) / (facesCount - 1);
        } else {
          leftOffset = 0;
        }

        if (constraints.maxWidth < widget.faceSize) {
          // There isn't room for a single face. Show nothing.
          return const SizedBox();
        }

        return SizedBox(
          height: widget.faceSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < facesCount; i += 1)
                AnimatedPositioned(
                  key: ValueKey(_visibleAvatars[i]),
                  top: 0,
                  height: widget.faceSize,
                  left: leftOffset + (i * facePercentVisible * widget.faceSize),
                  width: widget.faceSize,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.bounceInOut,
                  child: _Avatar(
                    url: _visibleAvatars[i],
                    showFace: widget.urls.contains(_visibleAvatars[i]),
                    faceSize: widget.faceSize,
                    onDisappear: () =>
                        setState(() => _visibleAvatars.removeAt(i)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Avatar extends StatefulWidget {
  const _Avatar({
    Key? key,
    required this.url,
    required this.faceSize,
    required this.showFace,
    required this.onDisappear,
  }) : super(key: key);

  final String url;
  final double faceSize;
  final bool showFace;
  final VoidCallback onDisappear;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<_Avatar> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onDisappear();
        }
      });
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _syncScaleAnimationWithWidget();
  }

  @override
  void didUpdateWidget(_Avatar oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncScaleAnimationWithWidget();
  }

  void _syncScaleAnimationWithWidget() {
    if (widget.showFace &&
        !_scaleController.isCompleted &&
        _scaleController.status != AnimationStatus.forward) {
      _scaleController.forward();
    } else if (!widget.showFace &&
        !_scaleController.isDismissed &&
        _scaleController.status != AnimationStatus.reverse) {
      _scaleController.reverse();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.faceSize,
      height: widget.faceSize,
      child: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.faceSize,
                height: widget.faceSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 1),
                  image: DecorationImage(image: NetworkImage(widget.url)),
                ),
                clipBehavior: Clip.hardEdge,
              ),
            );
          },
        ),
      ),
    );
  }
}
