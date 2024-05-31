import 'package:flutter/material.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:practice_2/views/widgets/change_password_dialog.dart';
import 'package:practice_2/views/widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double? fontSize;
  bool? isDark;

  Future<void> saveDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  void _loadFontSize() async {
    double? size = await getDouble("fontSize");
    bool? mode = await getThemeMode("themeIsDark");
    setState(() {
      fontSize = size ?? 16.0;
      isDark = mode ?? false; // Default font size if none is saved
    });
  }

  var textController = TextEditingController();
  int valueItemLanguage = 0;

  Future<void> saveThemeMode(String key, bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, isDark);
  }

  Future<bool?> getThemeMode(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sozlamalar",
          style: TextStyle(fontSize: fontSize),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppConstants.language,
              style: TextStyle(fontSize: fontSize),
            ),
          )
        ],
      ),
      drawer: CustomDrawer(onThemeChanged: widget.onThemeChanged),
      body: Container(
        decoration: BoxDecoration(
            image: AppConstants.backgroundImage.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(AppConstants.backgroundImage))
                : null),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              SwitchListTile(
                value: isDark!,
                onChanged: widget.onThemeChanged,
                title: Text(
                  "Tungi holat",
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              const Divider(height: 30),
              const SizedBox(height: 20),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  AppConstants.backgroundImage = textController.text;
                  setState(() {});
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select language",
                    style: TextStyle(fontSize: fontSize),
                  ),
                  DropdownButton(
                      value: valueItemLanguage,
                      items: [
                        DropdownMenuItem(
                          value: 0,
                          child: Text(
                            "uz",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            "ru",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            "eng",
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == 0) {
                          AppConstants.language = "uz";
                          valueItemLanguage = 0;
                        } else if (value == 1) {
                          AppConstants.language = "ru";
                          valueItemLanguage = 1;
                        } else {
                          AppConstants.language = "eng";
                          valueItemLanguage = 2;
                        }
                        setState(() {});
                      }),
                ],
              ),
              const Divider(height: 30),
              Text(
                "Select size text:",
                style: TextStyle(fontSize: fontSize),
              ),
              Slider(
                min: 15,
                max: 40,
                label: '${fontSize! - 15}',
                divisions: 5,
                value: fontSize!,
                onChanged: (value) async {
                  fontSize = value;
                  await saveDouble("fontSize", fontSize ?? 16);
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => const MyAlertDialog());
                },
                title: const Text("Change password"),
                trailing: const Icon(
                  Icons.navigate_next_rounded,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
