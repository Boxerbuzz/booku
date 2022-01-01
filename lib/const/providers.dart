import 'package:booku/exports.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers() => [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider())
    ];
