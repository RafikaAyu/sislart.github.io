import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveDataCache(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();

  if (value is String) {
    prefs.setString(key, value);
  } else if (value is int) {
    prefs.setInt(key, value);
  } else if (value is double) {
    prefs.setDouble(key, value);
  } else if (value is bool) {
    prefs.setBool(key, value);
  }
}

Future<dynamic> getDataCache(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}

Future<void> saveListCache(String key, List<dynamic> list) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = list.map((item) => item.toString()).toList().join(',');
  prefs.setString(key, jsonString);
}

Future getListCache(String key, void Function(List<dynamic>) callback) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);

  if (jsonString != null) {
    final items = jsonString.split(',');
    callback(items);
  }
}
