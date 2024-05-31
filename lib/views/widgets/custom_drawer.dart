import 'package:flutter/material.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:practice_2/views/screens/home_screen.dart';
import 'package:practice_2/views/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  CustomDrawer({super.key, required this.onThemeChanged});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  double? fontSize;

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
    setState(() {
      fontSize = size ?? 16.0; // Default font size if none is saved
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              AppConstants.backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Center(
                child: Text(
                  "User",
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return HomeScreen(
                        onThemeChanged: widget.onThemeChanged,
                      );
                    },
                  ),
                );
              },
              title: Text(
                "Bosh sahifa",
                style: TextStyle(fontSize: fontSize),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return SettingsScreen(
                        onThemeChanged: widget.onThemeChanged,
                      );
                    },
                  ),
                );
              },
              title: Text(
                "Sozlamalar",
                style: TextStyle(fontSize: fontSize),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
