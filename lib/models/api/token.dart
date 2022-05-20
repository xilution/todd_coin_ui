class Token {
  final String access;

  Token(this.access);

  Token.fromJson(Map<String, dynamic> json) : access = json['access'];
}
