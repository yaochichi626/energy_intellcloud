class LoginModel {
  final String access_token;
  final String token_type;
  final String refresh_token;
  final int expires_in;
  final String scope;

  LoginModel(
      {this.access_token,
      this.token_type,
      this.refresh_token,
      this.expires_in,
      this.scope});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      access_token: json['access_token'],
      token_type: json['token_type'],
      refresh_token: json['refresh_token'],
      expires_in: json['expires_in'],
      scope: json['scope'],
    );
  }
}
