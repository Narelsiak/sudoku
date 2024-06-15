import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/menu_screen.dart';
import 'utils/shared_prefs.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final sharedPreferencesManager = SharedPreferencesManager();
  await sharedPreferencesManager.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('pl', 'PL')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: SnakeApp() 
    ),
  );
  //runApp(SnakeApp());
}

class SnakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      
      home: MenuScreen(), // Zmiana na ekran menu
      debugShowCheckedModeBanner: false,
    );
  }
}