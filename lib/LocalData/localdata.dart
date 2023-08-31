import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class LocalData {
  static List<dynamic> imageHomeUrl = [];
  static List<dynamic> imageArtikelUrl = [];

  static final cacheImageHomeUrl = DefaultCacheManager();
  static final cacheImageArtikelUrl = DefaultCacheManager();

  static int indexGetDataGanjil = 0;
  static int indexGetDataGenap = 0;
  static String valueCurrentGetDataGanjil = "";
  static String valueCurrentGetDataGenap = "";
}
