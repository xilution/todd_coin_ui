import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todd_coin_ui/models/api/token.dart';

import '../models/domain/participant.dart';

class AppContext {
  static Future<void> setBaseUrl(String baseUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseUrl', baseUrl);
  }

  static Future<String?> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('baseUrl');
  }

  static Future<void> setToken(Token token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', json.encode(token.toJson()));
  }

  static Future<Token?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? string = prefs.getString('token');

    return string == null ? null : Token.fromJson(json.decode(string));
  }

  static Future<void> setUser(Participant user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toJson()));
  }

  static Future<Participant?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? string = prefs.getString('user');

    return string == null ? null : Participant.fromJson(json.decode(string));
  }
}
