import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todd_coin_ui/constants.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';

class LocalStorageBroker {
  static Future<void> setBaseUrl(String baseUrl) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('baseUrl', baseUrl);
  }

  static Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();

    String? baseUrl = prefs.getString('baseUrl');
    if (baseUrl == null) {
      baseUrl = Constants.baseUrl;
      await prefs.setString('baseUrl', baseUrl);
    }

    return baseUrl;
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

  static Future<void> addKey(ParticipantKey participantKey) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('participant-key-${participantKey.id}',
        json.encode(participantKey.toJson()));
  }

  static Future<ParticipantKey?> getKey(String? id) async {
    final prefs = await SharedPreferences.getInstance();
    String? string = prefs.getString('participant-key-$id');

    return string == null ? null : ParticipantKey.fromJson(json.decode(string));
  }
}
