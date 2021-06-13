import 'dart:convert';
import 'package:flutter/services.dart';

class JSONHelper {
  static Future<Map<String, dynamic>> parseJsonFromAsset(String assetPath) async {
    String data = await rootBundle.loadString(assetPath);
    return jsonDecode(data);
  }
}
