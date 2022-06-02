import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todd_coin_ui/models/api/token.dart';
import 'package:todd_coin_ui/screens/auth/login.dart';
import 'package:todd_coin_ui/utilities/app_context.dart';

class ApiContext {
  static Future<Token> getToken(
      NavigatorState navigator, String baseUrl) async {
    Token? token = await AppContext.getToken();

    if (token == null || JwtDecoder.isExpired(token.access)) {
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
}
