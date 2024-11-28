
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoes/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoes/theme_update/theme.dart';
import 'package:todoes/theme_update/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      themeMode: themeNotifier.themeMode,
      darkTheme: darkTheme,
      theme: lightTheme,
      home: const SignUpScreen(),
    );
  }
}
