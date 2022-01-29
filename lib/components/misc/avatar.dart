import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

class EvAvatar extends StatelessWidget {
  const EvAvatar(
    this.imgUrl, {
    this.email,
    this.size = 24,
    this.radius,
    Key? key,
  }) : super(key: key);
  final double size;
  final BorderRadius? radius;
  final String? imgUrl;
  final String? email;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        image: DecorationImage(
          image: NetworkImage(
            StringHelper.isEmpty(imgUrl) == true
                ? StringHelper.getAvatar(email)
                : imgUrl!,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: radius ?? BorderRadius.circular(30),
        boxShadow: Shadows.m(theme.grey, .1),
        border: Border.all(color: theme.primary, width: .9),
      ),
    );
  }
}
