import 'package:flutter/material.dart';

class EvGlobal {
  final GlobalKey<NavigatorState> navKey = GlobalKey();

  NavigatorState? get nav => navKey.currentState;
}
