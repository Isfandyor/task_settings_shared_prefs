import 'package:flutter/material.dart';
import 'package:practice_2/views/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PasswordScreen extends StatefulWidget {
  Function(bool) onThemeChanged;
  PasswordScreen({super.key, required this.onThemeChanged});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String? password;
  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  void _loadFontSize() async {
    setState(() async {
      password = await getString("password") ?? "1234";
    });
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  var textController = TextEditingController();
  String? errorPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_rounded,
              size: 40,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                errorText: errorPassword,
                labelText: "Password",
                hintText: "Enter password",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                String passwordUser = textController.text.trim();
                if (passwordUser == password) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => HomeScreen(
                              onThemeChanged: widget.onThemeChanged)));
                } else {
                  errorPassword = "Password error";
                }
                setState(() {});
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
