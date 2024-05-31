import 'package:flutter/material.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:practice_2/views/screens/password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isDark;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    bool? mode = await getThemeMode("themeIsDark");
    setState(() {
      isDark = mode ?? false; // Default theme mode if none is saved
    });
  }

  Future<void> saveThemeMode(String key, bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, isDark);
  }

  Future<bool?> getThemeMode(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  void toggleThemeMode(bool value) {
    isDark = !isDark!;
    saveThemeMode("themeIsDark", isDark!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: (isDark ?? false) ? ThemeMode.dark : ThemeMode.light,
      home: PasswordScreen(
        onThemeChanged: toggleThemeMode,
      ),
    );
  }
}
