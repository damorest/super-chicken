import 'package:flutter/material.dart';
import 'package:media_test/services/settings_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final settingsService = SettingsService(prefs);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsService>.value(value: settingsService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Chicken',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
          fontFamily: 'RubikMonoOne'),
      initialRoute: AppRouter.loading,
      routes: AppRouter.routes,
    );
  }
}
