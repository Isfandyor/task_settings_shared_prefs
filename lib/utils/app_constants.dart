import 'package:practice_2/models/note.dart';
import 'package:practice_2/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
//   static ThemeMode themeMode = ThemeMode.light;
  static String backgroundImage = "";
  static String language = "uz";
//   static double fontSizeText = 15;
  static String? passwordApp;
  static String password = "1234";
  static List<Note> listNote = [
    Note(text: "Bugun yuguraman"),
    Note(text: "Kitob o'qish"),
    Note(text: "Soat tuzatish"),
    Note(text: "Uhlash"),
    Note(text: "Suv ichish"),
    Note(text: "Ovqatlanish"),
  ];

  static List<Todo> listTodo = [
    Todo(text: "Bugun yuguraman", isDone: false),
    Todo(text: "Kitob o'qish", isDone: false),
    Todo(text: "Soat tuzatish", isDone: false),
    Todo(text: "Uhlash", isDone: false),
    Todo(text: "Suv ichish", isDone: false),
    Todo(text: "Ovqatlanish", isDone: false),
  ];

  // // theme mode
  // static Future<void> saveThemeMode(String key, bool isDark) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(key, isDark);
  // }

  // static Future<bool?> getThemeMode(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(key);
  // }

  // static Future<void> saveString(String key, String value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(key, value);
  // }

  // static Future<String?> getString(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(key);
  // }

  // static Future<void> saveDouble(String key, double value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble(key, value);
  // }

  // static Future<double?> getDouble(key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getDouble(key);
  // }
}
