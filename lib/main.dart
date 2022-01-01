import 'package:flutter/material.dart';
import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: providers(),
      builder: (context, child) => const Booku(),
    ),
  );
}

class Booku extends StatefulWidget {
  const Booku({Key? key}) : super(key: key);

  @override
  State<Booku> createState() => _BookuState();
}

class _BookuState extends State<Booku> {
  @override
  Widget build(BuildContext context) {
    var themeType = context.select<AppProvider, ThemeType>((val) => val.theme);
    AppTheme theme = AppTheme.fromType(themeType);
    return Provider.value(
      value: theme,
      child: MaterialApp(
        title: 'Evento',
        theme: theme.themeData,
        navigatorKey: R.G.navKey,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: context.widthPx <= 800 ? 0.8 : 1.9,
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
