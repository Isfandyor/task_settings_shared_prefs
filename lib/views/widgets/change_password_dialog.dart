import 'package:flutter/material.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({super.key});

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  var textController = TextEditingController();
  String? errorPassword;

  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Parolni o'zgartirish"),
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  errorText: errorPassword,
                  label: const Text("New passoword"),
                  hintText: "Enter new password",
                  border: const OutlineInputBorder()),
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                String newPassword = textController.text.trim();
                if (newPassword.isNotEmpty && newPassword.length >= 4) {
                  errorPassword = null;
                  saveString("password", newPassword);
                  // AppConstants.passwordApp = newPassword;
                  Navigator.pop(context);
                  setState(() {});
                } else {
                  errorPassword = "Please, enter valid password";
                }
                setState(() {});
              },
              child: const Text("Save"),
            )
          ],
        )
      ],
    );
  }
}
