import 'package:booku/exports.dart';
import 'package:flutter/material.dart';

abstract class BaseCmd extends BaseApi {
  static BuildContext? _lastKnownRoot;
  BuildContext? context;
  NavigatorState? get rootNav => R.G.nav;

  BaseCmd(BuildContext c) {
    context = (rootNav!.context == _lastKnownRoot)
        ? R.G.nav!.context
        : Provider.of(rootNav!.context, listen: false);
    _lastKnownRoot = context;
  }

  T getProvider<T>() => Provider.of<T>(context!, listen: false);
}
