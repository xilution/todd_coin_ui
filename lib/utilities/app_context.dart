import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todd_coin_ui/brokers/auth_broker.dart';
import 'package:todd_coin_ui/brokers/local_storage_broker.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/screens/auth/login.dart';

class AppContext {
  static Future<Token> getToken(NavigatorState navigator) async {
    String baseUrl = await LocalStorageBroker.getBaseUrl();
    Token? token = await LocalStorageBroker.getToken();

    if (token == null || JwtDecoder.isExpired(token.access)) {
      // todo - change to within 15 minutes of expiring.
      token = await navigator.push(MaterialPageRoute(
        builder: (BuildContext context) {
          return Login(
            baseUrl: baseUrl,
            onLogin: (_, token) {
              navigator.pop(token);
            },
          );
        },
      ));
    }

    if (token == null) {
      throw Error();
    }

    return token;
  }

  static Future<Participant> getUser(NavigatorState navigator) async {
    String baseUrl = await LocalStorageBroker.getBaseUrl();
    Token token = await AppContext.getToken(navigator);

    return await AuthBroker(Client(), baseUrl).fetchUserInfo(token.access);
  }
}
