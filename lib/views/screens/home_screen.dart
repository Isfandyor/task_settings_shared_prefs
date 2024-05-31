import 'package:flutter/material.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:practice_2/views/widgets/custom_drawer.dart';
import 'package:practice_2/views/widgets/tab_first.dart';
import 'package:practice_2/views/widgets/tab_second.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  const HomeScreen({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bosh Sahifa",
            style: TextStyle(fontSize: fontSize),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppConstants.language,
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          ],
        ),
        drawer: CustomDrawer(
          onThemeChanged: widget.onThemeChanged,
        ),
        body: const Column(
          children: [
            TabBar(
                labelPadding: EdgeInsets.all(20),
                indicatorWeight: 5,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Text(
                    "TO DO",
                  ),
                  Text(
                    "NOTES",
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                TabFirst(),
                TabSecond(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
