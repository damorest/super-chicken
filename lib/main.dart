import 'package:flutter/material.dart';
import 'package:media_test/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'core/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
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
          fontFamily: 'Poppins'),
      initialRoute: AppRouter.loading,
      routes: AppRouter.routes,
    );
  }
}
